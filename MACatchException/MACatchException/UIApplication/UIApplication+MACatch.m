//
//  UIApplication+Uitl.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "UIApplication+MACatch.h"

//#import <AppKit/AppKit.h>


@implementation UIApplication (MACatch)

+(void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(canOpenURL:) method2Sel:@selector(maCatch_canOpenURL:)];
    });
}

- (BOOL) maCatch_canOpenURL:(NSURL *)url {

    __block BOOL res = NO;
    @try {
        
        if ( [NSThread isMainThread] ) {
  
            res = [self maCatch_canOpenURL:url];
        }
        else {

             
            dispatch_sync(dispatch_get_main_queue(), ^{
               
                res = [self maCatch_canOpenURL:url];
            });
        }
        
    }
    @catch(NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        return res;
    }
}
@end
