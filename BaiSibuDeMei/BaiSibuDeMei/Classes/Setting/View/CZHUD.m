//
//  CZHUD.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/14.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZHUD.h"



@implementation CZHUD

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)doClick
{
    _doEvent();
}
- (IBAction)cancelClick
{
    _cancelEvent();
}

@end
