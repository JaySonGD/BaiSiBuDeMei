//
//  CZNavigationController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZNavigationController.h"

@interface CZNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation CZNavigationController

#pragma mark **************************************************************************************************
#pragma mark load

+ (void)load
{
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributes = @{
                                    NSFontAttributeName : [UIFont systemFontOfSize:22],
                                    //NSForegroundColorAttributeName : [UIColor blackColor],
                                    };
    [navigationBar setTitleTextAttributes:attributes];
    
}


#pragma mark **************************************************************************************************
#pragma mark life

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupPan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark **************************************************************************************************
#pragma mark setupPan

- (void)setupPan
{
    
    //self.interactivePopGestureRecognizer.delegate = self;
    
    // <UIScreenEdgePanGestureRecognizer: 0x7fe2f26a68f0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe2f26a4b20>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe2f26a5ed0>)>>
    
    id  target  = self.interactivePopGestureRecognizer.delegate;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.delegate = nil;

}

#pragma mark **************************************************************************************************
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.childViewControllers.count > 1)
    {
        return YES;
    }
    return NO;
}

#pragma mark **************************************************************************************************
#pragma mark events

- (void)backClick
{
    [self popViewControllerAnimated:YES];
}

#pragma mark **************************************************************************************************
#pragma mark pushViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitle:@"后退" forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    [super pushViewController:viewController animated:animated];
}
@end
