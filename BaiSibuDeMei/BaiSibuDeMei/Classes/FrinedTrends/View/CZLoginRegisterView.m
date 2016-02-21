
//
//  CZLoginRegisterView.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZLoginRegisterView.h"
#import "UIImage+Stretch.h"


@interface CZLoginRegisterView ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end


@implementation CZLoginRegisterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [_loginBtn setBackgroundImage:[UIImage imageStretchWithImage:_loginBtn.currentBackgroundImage] forState:UIControlStateNormal];
}

+ (instancetype)registerView
{
   return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)loginView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
