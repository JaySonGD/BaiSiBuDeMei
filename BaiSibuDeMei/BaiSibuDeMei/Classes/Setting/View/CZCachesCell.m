//
//  CZCachesCell.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/27.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZCachesCell.h"
#import "CZFileTool.h"
#import "SandBoxPaths.h"
#import "CZHUD.h"

#import <SVProgressHUD.h>
#import <SDImageCache.h>

@interface CZCachesCell ()

@property (nonatomic, weak) UIView *coverView;

@end

@implementation CZCachesCell



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.text = @"清理缓存(计算中...)";
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.userInteractionEnabled = NO;
        
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        __block CGFloat _totalSize = 0;
        __weak typeof(self) weakSelf = self;
        [CZFileTool getSizeWithDirectoryPath:[SandBoxPaths cachePath] complete:^(NSInteger size) {
            
            
            _totalSize  = [[SDImageCache sharedImageCache] getSize] ;//+ size;
            NSString *strNum = @"清理缓存";
            if (_totalSize > 1000 *1000 *1000)
            {
                strNum = [NSString stringWithFormat:@"清理缓存(已使用%0.2fGB)",1.0 *_totalSize/1000000000];
            }else if (_totalSize > 1000 *1000)
            {
                strNum = [NSString stringWithFormat:@"清理缓存(已使用%0.2fMB)",1.0 *_totalSize/1000000];
            }
            else if (_totalSize > 1000)
            {
                strNum = [NSString stringWithFormat:@"清理缓存(已使用%0.2fKB)",1.0 *_totalSize/1000];
            }
            else if (_totalSize > 0)
            {
                strNum = [NSString stringWithFormat:@"清理缓存(已使用%0.2fB)",1.0 *_totalSize];
                
            }
            
            weakSelf.textLabel.text = strNum;
            weakSelf.accessoryView = nil;
            weakSelf.userInteractionEnabled = YES;
            
            
        }];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        
        
    }
    return self;
}
#pragma mark **************************************************************************************************
#pragma mark event

- (void)tapClick
{
    CZHUD *hudView = [CZHUD viewFromXib];

    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _coverView = coverView;
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [coverView addSubview:hudView];
    hudView.center =coverView.center;
    

    
    hudView.cancelEvent = ^(void){
        [UIView animateWithDuration:0.05 animations:^{
            hudView.transform =CGAffineTransformMakeScale(0.1, 0.1);

        } completion:^(BOOL finished) {
            [ _coverView removeFromSuperview];

        }];
    };
    
    hudView.doEvent = ^(void){
        
    
        
        [UIView animateWithDuration:0.05 animations:^{
            hudView.transform =CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [ _coverView removeFromSuperview];
            
            [self cleanCaches];
        }];
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_coverView];
}


#pragma mark **************************************************************************************************
#pragma mark cleanCaches

- (void)cleanCaches
{

    [SVProgressHUD showWithStatus:@"清除中..."];
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
            [SVProgressHUD showSuccessWithStatus:@"清除成功！"];
            weakSelf.textLabel.text = @"清理缓存";
        }];
        
    });
    

}

@end
