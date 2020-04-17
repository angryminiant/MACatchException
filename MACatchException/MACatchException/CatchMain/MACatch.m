//
//  MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "MACatch.h"

@interface MACatch ()


//设置异常回调 (参数依次为：异常，异常的默认处理，堆栈信息）
@property (copy, nonatomic) void(^throwExceptionCallBack)(NSException *exception, NSString *defaultToDo, NSString *stackSymbolsInfo);

@end

@implementation MACatch

//=================================================================
//                        捕获异常后的回调
//=================================================================
/**
 *  异常捕获 的单例对象
 */
+ (instancetype)sharedInstance {
    
    static MACatch *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MACatch new];
    });
    
    return manager;
}

///  设置捕获异常后的回调
/// @param reportExceptionCallBack  异常，异常的默认处理，堆栈信息
+ (void) ma_setReportExceptionCallBack:(void(^)(NSException *exception, NSString *defaultToDo, NSString *stackSymbolsInfo))reportExceptionCallBack {
    
    if ( reportExceptionCallBack) {
        [MACatch sharedInstance].throwExceptionCallBack = reportExceptionCallBack;
    }
}


//=================================================================
//                        启动崩溃方法
//=================================================================

+ (void)ma_becomeEffective {
    [self ma_effectiveIfDealWithNoneSel:NO];
}

+ (void)ma_makeAllEffective {
    [self ma_effectiveIfDealWithNoneSel:YES];
}

+ (void)ma_effectiveIfDealWithNoneSel:(BOOL)dealWithNoneSel {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSObject maCatch_exchangeMethodIfDealWithNoneSel:dealWithNoneSel];
        [UIView maCatch_exchangeMethod];
        
        [NSArray maCatch_exchangeMethod];
        [NSMutableArray maCatch_exchangeMethod];
        
        [NSDictionary maCatch_exchangeMethod];
        [NSMutableDictionary maCatch_exchangeMethod];
        
        [NSString maCatch_exchangeMethod];
        [NSMutableString maCatch_exchangeMethod];
        
        [NSAttributedString maCatch_exchangeMethod];
        [NSMutableAttributedString maCatch_exchangeMethod];
        
        [NSThread maCatch_exchangeMethod];
                
        [UIApplication maCatch_exchangeMethod];
        
    });
}

+ (void)ma_setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings {
    [NSObject maCatch_setupNoneSelClassStringsArr:classStrings];
}

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 */
+ (void)ma_setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs {
    [NSObject maCatch_setupNoneSelClassStringPrefixsArr:classStringPrefixs];
}


//=================================================================
//                        替换
//=================================================================

/**
 *  类方法的交换
 *
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)ma_exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
   
    Method method1 = class_getClassMethod(anClass, method1Sel);
    Method method2 = class_getClassMethod(anClass, method2Sel);
    method_exchangeImplementations(method1, method2);
}


/**
 *  类方法的交换
 *
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)ma_exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {

    Method originMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzedMehtod = class_getInstanceMethod(anClass, method2Sel);
    BOOL methodAdded = class_addMethod(anClass, method1Sel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(anClass, method2Sel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}


//=================================================================
//                        处理崩溃的信息
//=================================================================

/**
 *  处理崩溃的信息(控制台输出、发送到服务端)
 *
 *  @param exception   捕获到的异常
 *  @param defaultToDo 捕获异常后的处理
 */
+ (void)ma_dealWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo {
    
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [MACatch ma_getErrorPlaceWithStackSymbols:callStackSymbolsArr];
    
    //errorReason 可能为 -[__NSCFConstantString ma_characterAtIndex:]: Range or index out of bounds
    //将ma_去掉
    //errorReason = [errorReason stringByReplacingOccurrencesOfString:@"ma_" withString:@""];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
//    GYNSLog(@"MACatch-errorPlace = %@", errorPlace);
    
    //将错误信息放在字典里，用通知的形式发送出去
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ( [MACatch sharedInstance].throwExceptionCallBack ) {
            [MACatch sharedInstance].throwExceptionCallBack(exception, defaultToDo, errorPlace);
        }
        
    });
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */
+ (NSString *)ma_getErrorPlaceWithStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
    }
    
    return mainCallStackSymbolMsg;
}

@end
