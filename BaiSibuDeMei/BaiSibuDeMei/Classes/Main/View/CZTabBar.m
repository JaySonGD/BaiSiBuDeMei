//
//  CZTabBar.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTabBar.h"

@interface CZTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation CZTabBar

#pragma mark **************************************************************************************************
#pragma mark initWithFrame

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:plusBtn];
        [plusBtn sizeToFit];
        _plusBtn = plusBtn;
    }
    return self;
}


#pragma mark **************************************************************************************************
#pragma mark layoutSubviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger index = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / (self.items.count + 1);
    CGFloat h = self.height;
    
    for (UIView *tabBarButton in self.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            x = w * index;
            tabBarButton.frame = CGRectMake(x, y, w, h);
            index ++;
            if (index == 2) {
                index ++;
            }
        }
    }
    _plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}

@end
