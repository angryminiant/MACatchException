//
//  NSThread+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "UIView+MACatch.h"

@implementation UIView (MACatch)


+(void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(setFrame:) method2Sel:@selector(maCatch_setFrame:)];
        [MACatch ma_exchangeInstanceMethod:[self class] method1Sel:@selector(addSubview:) method2Sel:@selector(maCatch_addSubview:)];
    });
}

// 添加子控件 常见错误：self add to self
- (void) maCatch_addSubview:(UIView *)view {
    
    @try {
        [self maCatch_addSubview:view];
    }
    @catch(NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
         
    }
}

// 
- (void) maCatch_setFrame:(CGRect)frame {
    
    @try {
        if ( !isnan(frame.origin.x) &&
            !isnan(frame.origin.y) &&
            !isnan(frame.size.width) &&
            !isnan(frame.size.height) ) {
            
            [self maCatch_setFrame:(frame)];
        }
    }
    @catch(NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}

@end
