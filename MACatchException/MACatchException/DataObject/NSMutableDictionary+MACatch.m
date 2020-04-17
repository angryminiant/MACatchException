//
//  NSMutableDictionary+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSMutableDictionary+MACatch.h"

@implementation NSMutableDictionary (MACatch)


+ (void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        //setObject:forKey:
        [MACatch ma_exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKey:) method2Sel:@selector(maCatch_setObject:forKey:)];
        
        //setObject:forKeyedSubscript:
        if (@available(iOS 11.0, *)) {
            [MACatch ma_exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKeyedSubscript:) method2Sel:@selector(maCatch_setObject:forKeyedSubscript:)];
        }        
        
        //removeObjectForKey:
        [MACatch ma_exchangeInstanceMethod:dictionaryM method1Sel:@selector(removeObjectForKey:) method2Sel:@selector(maCatch_removeObjectForKey:)];
    });
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:

- (void)maCatch_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self maCatch_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                  setObject:forKeyedSubscript:
//=================================================================
#pragma mark - setObject:forKeyedSubscript:
- (void)maCatch_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self maCatch_setObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)maCatch_removeObjectForKey:(id)aKey {
    
    @try {
        [self maCatch_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


@end
