//
//  AppDelegate.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "AppDelegate.h"
#import "FPSLable.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkReachabilityManager.h>


#import "CZTabBarController.h"
#import "CZAdvertisementController.h"

@interface AppDelegate ()

@end

static UIWindow *window_;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //CZTabBarController *tabVC = [[CZTabBarController alloc] init];
    CZAdvertisementController *adVC = [[CZAdvertisementController alloc] init];
    self.window.rootViewController = adVC;
    [self.window makeKeyAndVisible];
    
    window_ = [[UIWindow alloc] init];
//    window_.windowLevel = UIWindowLevelAlert;
    window_.rootViewController = [UIViewController new];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.backgroundColor = [UIColor clearColor];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [AFNetworkActivityIndicatorManager sharedManager].completionDelay = 0;
    [AFNetworkActivityIndicatorManager sharedManager].activationDelay = 0;
    FPSLable *lable = [[FPSLable alloc] init];
    lable.x = 180;
    lable.y = 0;
    lable.height = 20;
    lable.width = 64;
    [window_.rootViewController.view addSubview:lable];
    
    window_.hidden = NO;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
