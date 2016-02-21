//
//  CZLoginRegisterController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZLoginRegisterController.h"
#import "CZLoginRegisterTF.h"
#import "CZLoginRegisterView.h"
#import "UITextField+Placeholder.h"

@interface CZLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIView *loginContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeft;
@property (weak, nonatomic) IBOutlet UITextField *test;

@end

@implementation CZLoginRegisterController

#pragma mark **************************************************************************************************
#pragma mark life
- (void)viewDidLoad
{
    [super viewDidLoad];

    CZLoginRegisterView *loginView = [CZLoginRegisterView registerView ];
    [_loginContentView addSubview:loginView];
    
    CZLoginRegisterView *registerView = [CZLoginRegisterView loginView ];
    [_loginContentView addSubview:registerView];
    
    _test.placeHolderColor =[UIColor redColor];

    _test.placeholder = @"334";

}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _loginContentView.subviews[0].x = 0;
     _loginContentView.subviews[0].y = 0;
     _loginContentView.subviews[0].width = self.loginContentView.width /2 ;
     _loginContentView.subviews[0].height = self.loginContentView.height;
    
    
    _loginContentView.subviews[1].x = self.loginContentView.width /2;
    _loginContentView.subviews[1].y = 0;
    _loginContentView.subviews[1].width = self.loginContentView.width /2 ;
    _loginContentView.subviews[1].height = self.loginContentView.height;
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark **************************************************************************************************
#pragma mark events

- (IBAction)loginClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
 
    _contentViewLeft.constant =  (_contentViewLeft.constant == 0 )?  (- _loginContentView.width * 0.5) : 0 ;
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}



@end
