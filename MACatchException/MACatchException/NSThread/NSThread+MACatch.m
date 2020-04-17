//
//  NSThread+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSThread+MACatch.h"

//#import <AppKit/AppKit.h>


@implementation NSThread (MACatch)


+(void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(start) method2Sel:@selector(maCatch_start)];
    });
}

- (void) maCatch_start {
    
    @try {
                    
        [self maCatch_start];
    }
    @catch(NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
         
    }
}


@end
