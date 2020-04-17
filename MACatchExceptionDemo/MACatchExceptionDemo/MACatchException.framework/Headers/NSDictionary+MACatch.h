//
//  NSDictionary+MACatch.h
//  MACatchException
//
//  Created by MA on 2019/11/20.
//  Copyright © 2019 com.angryminiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MACatch)<MACatchProtocol>

@end

/**
 *  Can avoid crash method
 *
 *  1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"AvoidCrash"}; //这种创建方式其实调用的是2中的方法
 *  2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
 *
 */
