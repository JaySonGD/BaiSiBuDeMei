//
//  CZErrorView.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/16.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZErrorView.h"

@implementation CZErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)errorClick:(UIButton *)sender
{
    if (_errorClick)
    {
        _errorClick();
    }
}

@end
