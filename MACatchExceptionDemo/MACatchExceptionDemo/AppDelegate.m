//
//  AppDelegate.m
//  MACatchExceptionDemo
//
//  Created by hugengya on 2019/11/21.
//  Copyright © 2019 com.angryminiant. All rights reserved.
//

#import "AppDelegate.h"
#import <MACatchException/MACatchException.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [MACatch ma_setReportExceptionCallBack:^(NSException *exception, NSString *defaultToDo, NSString *stackSymbolsInfo) {

        NSLog(@"exception = \n\n%@\n\n  defaultToDo = \n\n%@\n\n stackSymbolsInfo = \n\n%@\n\n", exception, defaultToDo, stackSymbolsInfo);

    }];
    [MACatch ma_makeAllEffective];
    
    
    //=============================================
    //   1、unrecognized selector sent to instance
    //=============================================
    
    //若出现unrecognized selector sent to instance并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString

    NSArray *noneSelClassStrings = @[@"NSString"];
    [MACatch ma_setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //=============================================
    //   2、unrecognized selector sent to instance
    //=============================================
    
    //若需要防止某个前缀的类的unrecognized selector sent to instance
    //比如AvoidCrashPerson
    //你可以调用如下方法
    NSArray *noneSelClassPrefix = @[@"MACatch"];
    [MACatch ma_setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *array = @[@"0", @"1", @"2", @"3", @"4"];
        NSString *item = array[3];
        NSLog(@"item 3 = %@", item);
        item = array[6];
        NSLog(@"item 6 = %@", item);
        
        
    });
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
