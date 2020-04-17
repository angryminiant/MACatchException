//
//  NSMutableArray+MACatch.h
//  MACatchException
//
//  Created by MA on 2019/11/20.
//  Copyright © 2019 com.angryminiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MACatch)<MACatchProtocol>

@end

/**
 *  Can avoid crash method
 *
 *  1. - (id)objectAtIndex:(NSUInteger)index
 *  2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
 *  3. - (void)removeObjectAtIndex:(NSUInteger)index
 *  4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index
 *  5. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 */
