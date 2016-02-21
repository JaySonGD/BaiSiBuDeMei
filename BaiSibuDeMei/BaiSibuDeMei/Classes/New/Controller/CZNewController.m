//
//  CZNewController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZNewController.h"

#import "CZTagSubController.h"

@interface CZNewController ()

@end

@implementation CZNewController
#pragma mark **************************************************************************************************
#pragma mark life
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(leftClick)];
    
    [self initScrollView];
    [self initTitleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark **************************************************************************************************
#pragma mark init

- (void)initScrollView
{
    UIScrollView *scrollView =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
}


- (void)initTitleView
{
//NSArray *titles = @[@""];
}


#pragma mark **************************************************************************************************
#pragma mark evevts

- (void)leftClick
{
    CZTagSubController *TagSubVC = [[CZTagSubController alloc] init];
    
    [self.navigationController pushViewController:TagSubVC animated:YES];
}

@end
