//
//  NSMutableAttributedString+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSMutableAttributedString+MACatch.h"

@implementation NSMutableAttributedString (MACatch)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        //initWithString:
        [MACatch ma_exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(maCatch_initWithString:)];
        
        //initWithString:attributes:
        [MACatch ma_exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(maCatch_initWithString:attributes:)];
    });
}

//=================================================================
//                          initWithString:
//=================================================================
#pragma mark - initWithString:


- (instancetype)maCatch_initWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self maCatch_initWithString:str];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultReturnNil];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                     initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:


- (instancetype)maCatch_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self maCatch_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultReturnNil];
    }
    @finally {
        return object;
    }
}


@end
