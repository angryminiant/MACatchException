//
//  NSMutableArray+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSMutableArray+MACatch.h"

@implementation NSMutableArray (MACatch)


+(void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
         Class arrayMClass = NSClassFromString(@"__NSArrayM");
        
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(removeObject:) method2Sel:@selector(maCatch_removeObject:)];
        
        
        //objectAtIndex:
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(objectAtIndex:) method2Sel:@selector(maCatch_objectAtIndex:)];
        
        //objectAtIndexedSubscript
        if (@available(iOS 11.0, *)) {
            [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(maCatch_objectAtIndexedSubscript:)];
        }
        
        
        //setObject:atIndexedSubscript:
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(setObject:atIndexedSubscript:) method2Sel:@selector(maCatch_setObject:atIndexedSubscript:)];
        
        
        //removeObjectAtIndex:
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(removeObjectAtIndex:) method2Sel:@selector(maCatch_removeObjectAtIndex:)];
        
        //insertObject:atIndex:
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(insertObject:atIndex:) method2Sel:@selector(maCatch_insertObject:atIndex:)];
        
        //getObjects:range:
        [MACatch ma_exchangeInstanceMethod:arrayMClass method1Sel:@selector(getObjects:range:) method2Sel:@selector(maCatch_getObjects:range:)];
    });
    
}


- (void) maCatch_removeObject:(id)anObject {
    
    @try {
        [self maCatch_removeObject:anObject];
    }
    @catch(NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array


- (void)maCatch_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    @try {
        [self maCatch_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)maCatch_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self maCatch_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    insertObject:atIndex:
//=================================================================
#pragma mark - set方法
- (void)maCatch_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self maCatch_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                           objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

- (id)maCatch_objectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self maCatch_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultReturnNil];
    }
    @finally {
        return object;
    }
}

//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)maCatch_objectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self maCatch_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultReturnNil];
    }
    @finally {
        return object;
    }
    
}


//=================================================================
//                         getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

- (void)maCatch_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self maCatch_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [MACatch ma_dealWithException:exception defaultToDo:MACatchDefaultIgnore];
        
    } @finally {
        
    }
}



/**
 安全的移除数组元素
 利用block来操作，遍历比for快20%左右
 原理：找到符合的条件之后，暂停遍历，然后修改数组的内容
 */
- (void) saveFun_removeObjFromMArray {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:@"12",@"23",@"34",@"45",@"56", nil];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isEqualToString:@"34"]) {
            
            *stop = YES;
            
            if (*stop == YES) {
                
                [tempArray replaceObjectAtIndex:idx withObject:@"3333333"];
                
            }
            
        }
        
        if (*stop) {
            
            NSLog(@"array is %@",tempArray);
            
        }
        
    }];
}

@end
