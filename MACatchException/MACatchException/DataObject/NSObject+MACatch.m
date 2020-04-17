//
//  NSObject+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSObject+MACatch.h"

@implementation NSObject (MACatch)


/**
 是否开启"unrecognized selector sent to instance"异常的捕获
 @param ifDealWithNoneSel 是否开启
 */
+ (void)maCatch_exchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //setValue:forKey:
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKey:) method2Sel:@selector(maCatch_setValue:forKey:)];
        
        //setValue:forKeyPath:
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKeyPath:) method2Sel:@selector(maCatch_setValue:forKeyPath:)];
        
        //setValue:forUndefinedKey:
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forUndefinedKey:) method2Sel:@selector(maCatch_setValue:forUndefinedKey:)];
        
        //setValuesForKeysWithDictionary:
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(setValuesForKeysWithDictionary:) method2Sel:@selector(maCatch_setValuesForKeysWithDictionary:)];
        
        
        //unrecognized selector sent to instance
        if (ifDealWithNoneSel) {
            [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(methodSignatureForSelector:) method2Sel:@selector(maCatch_methodSignatureForSelector:)];
            [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(forwardInvocation:) method2Sel:@selector(maCatch_forwardInvocation:)];
        }
    });
}



//=================================================================
//                        unrecognized selector sent to instance
//=================================================================
#pragma mark - unrecognized selector sent to instance

static NSMutableArray *noneSelClassStrings;
static NSMutableArray *noneSelClassStringPrefixs;

+ (void)maCatch_setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings {
    
    if (noneSelClassStrings) {
        
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n%@\n\n",MACatchSeparatorWithFlag,MACatchSeparator];
        MACatchLog(@"%@",warningMsg);
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStrings = [NSMutableArray array];
        for (NSString *className in classStrings) {
            if ([className hasPrefix:@"UI"] == NO &&
                [className isEqualToString:NSStringFromClass([NSObject class])] == NO) {
                [noneSelClassStrings addObject:className];
                
            } else {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NSObject类(请使用NSObject的子类)\n\n%@\n\n",MACatchSeparatorWithFlag,MACatchSeparator];
                MACatchLog(@"%@",warningMsg);
            }
        }
    });
}

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 */
+ (void)maCatch_setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs {
    if (noneSelClassStringPrefixs) {
        
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringPrefixsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n%@\n\n",MACatchSeparatorWithFlag,MACatchSeparator];
        MACatchLog(@"%@",warningMsg);
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        noneSelClassStringPrefixs = [NSMutableArray array];
        for (NSString *classNamePrefix in classStringPrefixs) {
            if ([classNamePrefix hasPrefix:@"UI"] == NO &&
                [classNamePrefix hasPrefix:@"NS"] == NO) {
                [noneSelClassStringPrefixs addObject:classNamePrefix];
                
            } else {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NS开头的类\n若需要对NS开头的类防止”unrecognized selector sent to instance”(比如NSArray),请使用setupNoneSelClassStringsArr:\n\n%@\n\n",MACatchSeparatorWithFlag,MACatchSeparator];
                MACatchLog(@"%@",warningMsg);
            }
        }
    });
}



//=================================================================
//                        替换
//=================================================================
- (NSMethodSignature *)maCatch_methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature *ms = [self maCatch_methodSignatureForSelector:aSelector];
    
    BOOL flag = NO;
    if (ms == nil) {
        for (NSString *classStr in noneSelClassStrings) {
            if ([self isKindOfClass:NSClassFromString(classStr)]) {
                ms = [MACatchProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
                flag = YES;
                break;
            }
        }
    }
    if (flag == NO) {
        NSString *selfClass = NSStringFromClass([self class]);
        for (NSString *classStrPrefix in noneSelClassStringPrefixs) {
            if ([selfClass hasPrefix:classStrPrefix]) {
                ms = [MACatchProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
            }
        }
    }
    return ms;
}

- (void)maCatch_forwardInvocation:(NSInvocation *)anInvocation {
    
    @try {
        [self maCatch_forwardInvocation:anInvocation];
        
    } @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
        
    } @finally {
        
    }
    
}


//=================================================================
//                         setValue:forKey:
//=================================================================
#pragma mark - setValue:forKey:

- (void)maCatch_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self maCatch_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                     setValue:forKeyPath:
//=================================================================
#pragma mark - setValue:forKeyPath:

- (void)maCatch_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self maCatch_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}



//=================================================================
//                     setValue:forUndefinedKey:
//=================================================================
#pragma mark - setValue:forUndefinedKey:

- (void)maCatch_setValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self maCatch_setValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                  setValuesForKeysWithDictionary:
//=================================================================
#pragma mark - setValuesForKeysWithDictionary:

- (void)maCatch_setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self maCatch_setValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}

@end
