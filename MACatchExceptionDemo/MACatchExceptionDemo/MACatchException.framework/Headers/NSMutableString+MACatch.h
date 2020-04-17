//
//  NSMutableString+MACatch.h
//  MACatchException
//
//  Created by MA on 2019/11/20.
//  Copyright © 2019 com.angryminiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (MACatch)<MACatchProtocol>

@end

/**
 *  Can avoid crash method
 *
 *  1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了
 *  2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
 *  3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc
 *  4. - (void)deleteCharactersInRange:(NSRange)range
 *
 */
