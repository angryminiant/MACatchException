//
//  MACatch.h
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MACatchProtocol <NSObject>

@required
+ (void)maCatch_exchangeMethod;

@end


@interface MACatch : NSObject

//=================================================================
//                        捕获异常后的回调
//=================================================================
///  设置捕获异常后的回调
/// @param reportExceptionCallBack  异常，异常的默认处理，堆栈信息
+ (void) ma_setReportExceptionCallBack:(void(^)(NSException *exception, NSString *defaultToDo, NSString *stackSymbolsInfo))reportExceptionCallBack;



//=================================================================
//                        启动崩溃方法
//=================================================================

/**
 *
 *  开始生效.你可以在AppDelegate的didFinishLaunchingWithOptions方法中调用ma_becomeEffective方法
 *  【默认不开启  对”unrecognized selector sent to instance”防止崩溃的处理】
 *
 *  这是全局生效，若你只需要部分生效，你可以单个进行处理，比如:
 *  [NSArray maCatch_exchangeMethod];
 *  [NSMutableArray maCatch_exchangeMethod];
 *
 */
+ (void)ma_becomeEffective;


/**
 *  相比于ma_becomeEffective，增加
 *  对”unrecognized selector sent to instance”防止崩溃的处理
 *
 *  但是必须配合:
 *            ma_setupClassStringsArr:和
 *            ma_setupNoneSelClassStringPrefixsArr
 *            这两个方法可以同时使用
 */
+ (void)ma_makeAllEffective;



/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名数组
 *  ⚠️不可将@"NSObject"加入classStrings数组中
 *  ⚠️不可将UI前缀的字符串加入classStrings数组中
 */
+ (void)ma_setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;


/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 *  ⚠️不可将UI前缀的字符串(包括@"UI")加入classStringPrefixs数组中
 *  ⚠️不可将NS前缀的字符串(包括@"NS")加入classStringPrefixs数组中
 */
+ (void)ma_setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;




//=================================================================
//                        替换
//=================================================================

/**
 *  类方法的交换
 *
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)ma_exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;


/**
 *  对象方法的交换
 *
 *  @param method1Sel 方法1(原本的方法)
 *  @param method2Sel 方法2(要替换成的方法)
 */
+ (void)ma_exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;



//=================================================================
//                        处理崩溃的信息
//=================================================================


/**
 *  处理崩溃的信息(控制台输出、发送到服务端)
 *
 *  @param exception   捕获到的异常
 *  @param defaultToDo 捕获异常后的处理
 */
+ (void)ma_dealWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;


/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)ma_getErrorPlaceWithStackSymbols:(NSArray<NSString *> *)callStackSymbols;

@end
