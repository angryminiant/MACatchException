//
//  NSObject+MACatch.h
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MACatch)


/**
 是否开启"unrecognized selector sent to instance"异常的捕获
 @param ifDealWithNoneSel 是否开启
 */
+ (void)maCatch_exchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel;


#pragma mark - unrecognized selector sent to instance

+ (void)maCatch_setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 */
+ (void)maCatch_setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;


@end

/**
 *  Can avoid crash method
 *
 *  1.- (void)setValue:(id)value forKey:(NSString *)key
 *  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
 *  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
 *  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
 *  5. unrecognized selector sent to instance
 */
