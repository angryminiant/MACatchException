//
//  NSMutableString+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSMutableString+MACatch.h"

@implementation NSMutableString (MACatch)

+ (void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");
        
        //replaceCharactersInRange
        [MACatch ma_exchangeInstanceMethod:stringClass method1Sel:@selector(replaceCharactersInRange:withString:) method2Sel:@selector(maCatch_replaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [MACatch ma_exchangeInstanceMethod:stringClass method1Sel:@selector(insertString:atIndex:) method2Sel:@selector(maCatch_insertString:atIndex:)];
        
        //deleteCharactersInRange
        [MACatch ma_exchangeInstanceMethod:stringClass method1Sel:@selector(deleteCharactersInRange:) method2Sel:@selector(maCatch_deleteCharactersInRange:)];
    });
}

//=================================================================
//                     replaceCharactersInRange
//=================================================================
#pragma mark - replaceCharactersInRange

- (void)maCatch_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self maCatch_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)maCatch_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self maCatch_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                   deleteCharactersInRange
//=================================================================
#pragma mark - deleteCharactersInRange

- (void)maCatch_deleteCharactersInRange:(NSRange)range {
    
    @try {
        [self maCatch_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}








@end

