//
//  CZRefreshHeader.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/30.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZRefreshHeader.h"

@implementation CZRefreshHeader


-(void)prepare
{
    [super prepare];
    
    
    UIImage *image = [UIImage imageNamed:@"AppIcon-140x40"];
    UIImageView *logo  = [[UIImageView alloc] initWithImage:image];
    logo.centerX = iPhoneSize.width * 0.5;
    logo.centerY = -image.size.height * 0.5;
    [self addSubview:logo];
    
    //    [self addSubview:[UIButton buttonWithType:UIButtonTypeInfoDark]];
    self.automaticallyChangeAlpha = YES;
    
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    //    [self setTitle:@"松手刷新" forState:MJRefreshStatePulling];
    //    [self setTitle:@"刷新..." forState:MJRefreshStateRefreshing];
}


- (void)placeSubviews
{
    [super placeSubviews];
}
@end
