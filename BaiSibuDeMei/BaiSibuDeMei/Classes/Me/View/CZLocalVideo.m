//
//  CZLocalVideo.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/16.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZLocalVideo.h"

@interface CZLocalVideo ()
@property (weak, nonatomic) IBOutlet UIButton *downloading;
@property (weak, nonatomic) IBOutlet UIButton *finished;

@end

@implementation CZLocalVideo

- (void)awakeFromNib
{
    _downloading.enabled = _finished.enabled;
    _finished.enabled = !_downloading.enabled;
    
    [_downloading setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_downloading setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_finished setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [_finished setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)downloadingClick:(UIButton *)sender
{
    _finished.enabled = sender.enabled;
    sender.enabled = !sender.enabled;
    
    (sender.enabled == NO) ? (sender.backgroundColor = [UIColor redColor]) : (sender.backgroundColor = [UIColor whiteColor]);
    (_finished.enabled == NO) ? (_finished.backgroundColor = [UIColor redColor]) : (_finished.backgroundColor = [UIColor whiteColor]);
    
    if ([self.delegate respondsToSelector:@selector(DidSelectDownloadlocalVideo:)])
    {
        [self.delegate DidSelectDownloadlocalVideo:self];
    }
}
- (IBAction)finishedClick:(UIButton *)sender
{
    _downloading.enabled = sender.enabled;
    sender.enabled = !sender.enabled;
    
    (sender.enabled == NO) ? (sender.backgroundColor = [UIColor redColor]) : (sender.backgroundColor = [UIColor whiteColor]);
    (_downloading.enabled == NO) ? (_downloading.backgroundColor = [UIColor redColor]) : (_downloading.backgroundColor = [UIColor whiteColor]);
    if ([self.delegate respondsToSelector:@selector(DidSelectFinishedlocalVideo:)])
    {
        [self.delegate DidSelectFinishedlocalVideo:self];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
