//
//  NSMutableDictionary+MACatch.h
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MACatch)<MACatchProtocol>

@end

/**
 *  Can avoid crash method
 *
 *  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
 *  2. - (void)removeObjectForKey:(id)aKey
 *
 */
