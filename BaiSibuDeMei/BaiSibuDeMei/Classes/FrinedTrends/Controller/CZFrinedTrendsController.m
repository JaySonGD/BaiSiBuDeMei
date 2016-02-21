//
//  CZFrinedTrendsController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZFrinedTrendsController.h"

#import "CZLoginRegisterController.h"

@interface CZFrinedTrendsController ()

@end

@implementation CZFrinedTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(leftClick)];
    
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] init];
    
    [loadingView startAnimating];
    
    loadingView.center = self.view.center;
    
    [self.view addSubview:loadingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark **************************************************************************************************
#pragma mark events
- (IBAction)loginRegisterClick
{
    CZLoginRegisterController *loginRegister = [[CZLoginRegisterController alloc] init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)leftClick
{
    CZFunc();
}

@end
