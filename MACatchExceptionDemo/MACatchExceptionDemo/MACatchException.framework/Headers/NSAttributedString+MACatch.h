//
//  NSAttributedString+MACatch.h
//  MACatchException
//
//  Created by MA on 2019/11/20.
//  Copyright © 2019 com.angryminiant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (MACatch)<MACatchProtocol>

@end

/**
 *  Can avoid crash method
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
 *  3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *
 *
 */
