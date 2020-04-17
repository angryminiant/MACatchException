//
//  NSArray+MACatch.m
//  MACatchException
//
//  Created by ma on 2019/12/5.
//  Copyright © 2019 com.ma. All rights reserved.
//

#import "NSArray+MACatch.h"

@implementation NSArray (MACatch)


/**
 load方法是main函数执行之前就调用了。
 如果在类与分类中都实现了 load 方法，它们都会被调用，不像其它的在分类中实现的方法会被覆盖，这就使 load 方法成为了方法调剂的绝佳时机。
 */
+(void)load {
    
}

+(void)maCatch_exchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //=================
        //   class method
        //=================
        
        //instance array method exchange
        [MACatch ma_exchangeClassMethod:[self class] method1Sel:@selector(arrayWithObjects:count:) method2Sel:@selector(maCatch_arrayWithObjects:count:)];
        
        
        
        //====================
        //   instance method
        //====================
        
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        
        //objectsAtIndexes:
        [MACatch ma_exchangeInstanceMethod:__NSArray method1Sel:@selector(objectsAtIndexes:) method2Sel:@selector(maCatch_objectsAtIndexes:)];
        
        
        //objectAtIndex:
        
        [MACatch ma_exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(maCatch_NSArrayI_objectAtIndex:)];
        
        [MACatch ma_exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(maCatch_NSSingleObjectArrayI_objectAtIndex:)];
        
        [MACatch ma_exchangeInstanceMethod:__NSArray0 method1Sel:@selector(objectAtIndex:) method2Sel:@selector(maCatch_NSArray0_objectAtIndex:)];
        
        //objectAtIndexedSubscript:
        if (@available(iOS 11.0, *)) {
            [MACatch ma_exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(maCatch_NSArrayI_objectAtIndexedSubscript:)];
        }
        
        
        //getObjects:range:
        [MACatch ma_exchangeInstanceMethod:__NSArray method1Sel:@selector(getObjects:range:) method2Sel:@selector(maCatch_NSArray_getObjects:range:)];
        
        [MACatch ma_exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(maCatch_NSSingleObjectArrayI_getObjects:range:)];
        
        [MACatch ma_exchangeInstanceMethod:__NSArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(maCatch_NSArrayI_getObjects:range:)];
    });
        
}


#pragma mark - instance array
+ (instancetype)maCatch_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self maCatch_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil object and instance a array.";
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self maCatch_arrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}



//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)maCatch_NSArrayI_objectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self maCatch_NSArrayI_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = MACatchDefaultReturnNil;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                       objectsAtIndexes:
//=================================================================
#pragma mark - objectsAtIndexes:

- (NSArray *)maCatch_objectsAtIndexes:(NSIndexSet *)indexes {
    
    NSArray *returnArray = nil;
    @try {
        returnArray = [self maCatch_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSString *defaultToDo = MACatchDefaultReturnNil;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        return returnArray;
    }
}


//=================================================================
//                         objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)maCatch_NSArrayI_objectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self maCatch_NSArrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = MACatchDefaultReturnNil;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//__NSSingleObjectArrayI objectAtIndex:
- (id)maCatch_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self maCatch_NSSingleObjectArrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = MACatchDefaultReturnNil;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//__NSArray0 objectAtIndex:
- (id)maCatch_NSArray0_objectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self maCatch_NSArray0_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = MACatchDefaultReturnNil;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)maCatch_NSArray_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self maCatch_NSArray_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = MACatchDefaultIgnore;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)maCatch_NSSingleObjectArrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self maCatch_NSSingleObjectArrayI_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = MACatchDefaultIgnore;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSArrayI  getObjects:range:
- (void)maCatch_NSArrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self maCatch_NSArrayI_getObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = MACatchDefaultIgnore;
        [MACatch ma_dealWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}

@end
