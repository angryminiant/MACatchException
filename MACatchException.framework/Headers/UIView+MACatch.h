//
//  NSThread+MACatch.h
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MACatch)<MACatchProtocol>

@end
/**
 *  Can avoid crash method
 *
 *  1. - (void)addSubview:(UIView *)view;
 *  2. setFrame
 */
