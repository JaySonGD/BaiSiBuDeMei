//
//  CZTabBarController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTabBarController.h"
#import "CZNavigationController.h"

#import "CZEssenceController.h"
#import "CZNewController.h"
#import "CZFrinedTrendsController.h"
#import "CZMeController.h"


#import "CZTabBar.h"

@interface CZTabBarController ()

@end

@implementation CZTabBarController

#pragma mark **************************************************************************************************
#pragma mark load

+ (void)load
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSDictionary *NorAttributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:13],
                                 //NSForegroundColorAttributeName : [UIColor blackColor],
                                 };
    
    [tabBarItem setTitleTextAttributes:NorAttributes forState:UIControlStateNormal];
    
    
    NSDictionary *SelAttributes = @{
                                   // NSFontAttributeName : [UIFont systemFontOfSize:16],
                                    NSForegroundColorAttributeName : [UIColor blackColor],
                                    };
    
    [tabBarItem setTitleTextAttributes:SelAttributes forState:UIControlStateSelected];
    
    
    UITabBar *tabBar = [UITabBar appearanceWhenContainedIn:self, nil];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

}


#pragma mark **************************************************************************************************
#pragma mark life

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildControllers];
    
    [self setupTabBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark **************************************************************************************************
#pragma mark setupTabBar

- (void)setupTabBar
{
    CZTabBar *tabBar = [[CZTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark **************************************************************************************************
#pragma mark setupChildsController

- (void)setupChildControllers
{
    CZEssenceController *essenceVC = [[CZEssenceController alloc] init];
    
    CZNavigationController *navEssence = [[CZNavigationController alloc] initWithRootViewController:essenceVC];
    
    navEssence.tabBarItem.title = @"精华";
    navEssence.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    navEssence.tabBarItem.selectedImage = [UIImage imageWithRendering:@"tabBar_essence_click_icon"];
    
    [self addChildViewController:navEssence];
    
    
    CZNewController *newVC = [[CZNewController alloc] init];
    newVC.title = @"新帖";
    CZNavigationController *navNew = [[CZNavigationController alloc] initWithRootViewController:newVC];
    navNew.tabBarItem.title = @"新帖";
    navNew.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    navNew.tabBarItem.selectedImage = [UIImage imageWithRendering:@"tabBar_new_click_icon"];
    [self addChildViewController:navNew];

    CZFrinedTrendsController *frinedTrendsVC = [[CZFrinedTrendsController alloc] init];
    frinedTrendsVC.title = @"关注";
    CZNavigationController *navFrinedTrends = [[CZNavigationController alloc] initWithRootViewController:frinedTrendsVC];
    navFrinedTrends.tabBarItem.title = @"关注";
    navFrinedTrends.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    navFrinedTrends.tabBarItem.selectedImage = [UIImage imageWithRendering:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:navFrinedTrends];

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([CZMeController class]) bundle:nil];
    
    CZMeController *meVC = [sb instantiateInitialViewController];
    meVC.title = @"我";
    CZNavigationController *navMe= [[CZNavigationController alloc] initWithRootViewController:meVC];
    navMe.tabBarItem.title = @"我";
    navMe.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    navMe.tabBarItem.selectedImage = [UIImage imageWithRendering:@"tabBar_me_click_icon"];

    [self addChildViewController:navMe];

}



@end
