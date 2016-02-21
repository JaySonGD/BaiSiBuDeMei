//
//  CZAdvertisementController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZAdvertisementController.h"
#import "CZTabBarController.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "CZAdItem.h"




NSString *const urtStr = @"http://mobads.baidu.com/cpro/ui/mads.php";

NSString *const code2  = @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam";

@interface CZAdvertisementController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic, strong) CZAdItem *adItem;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation CZAdvertisementController

#pragma mark **************************************************************************************************
#pragma mark life
- (void)viewDidLoad
{
    self.jumpBtn.layer.cornerRadius = self.jumpBtn.height * 0.25;
    [self getAdvertisementData];
    
    [super viewDidLoad];
    [self initTimer];
    [self setUplaunchImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark **************************************************************************************************
#pragma mark setUplaunchImageView

- (void)setUplaunchImageView
{
    //ip5 320 ip6 375  ip6p 414
    
    if (iPhone4)
    {
        _launchImageView.image = [UIImage imageNamed:@"LaunchImage"];
    }
    else if (iPhone5)
    {
        _launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    else if (iPhone6)
    {
        _launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    }
    else if (iPhone6p)
    {
        _launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }
}


#pragma mark **************************************************************************************************
#pragma mark initTimer

- (void)initTimer
{
    _timer  = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChang) userInfo:nil repeats:YES];
}


#pragma mark **************************************************************************************************
#pragma mark events

- (void)tap
{
    NSURL *url = [NSURL URLWithString:_adItem.ori_curl];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)timerChang
{
    static NSInteger index = 1;
    
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%zd)",index] forState:UIControlStateNormal];
    
    if (index == -1)
    {
        [self jumpClick];
    }
    index -- ;
}


- (IBAction)jumpClick
{
    [_timer invalidate];
    
    //    CZTabBarController *tabVC = [CZTabBarController new];
    //
    //     __weak CZTabBarController * weakSelf = tabVC;
    //
    //    [UIView transitionForView:self.view type:TransitionSuckEffect subtype:kNilOptions duration:0.2 animationKey:nil completion:^{
    //
    //
    //        [UIApplication sharedApplication].keyWindow.rootViewController = [[CZTabBarController alloc] init];
    //
    //    }];
    //
    //    [self.view addSubview:weakSelf.view];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[CZTabBarController alloc] init];
    
    
}

#pragma mark **************************************************************************************************
#pragma mark getAdvertisementData


/*
 
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 
 */

- (void)getAdvertisementData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    
    [mgr GET:urtStr parameters:parameters
    progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
         
         
         NSDictionary *adDict = [responseObject[@"ad"] lastObject];
         _adItem = [CZAdItem mj_objectWithKeyValues:adDict];
         
         if (!_adItem.w || !_adItem.h) {
             return ;
         }
         
         CGFloat x = 0;
         CGFloat y = 0;
         CGFloat w = [UIScreen mainScreen].bounds.size.width;
         CGFloat h = w /[_adItem.w integerValue] * [_adItem.h integerValue];
         
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
         imageView.userInteractionEnabled = YES;
         [_contentView addSubview:imageView];
         
         [imageView sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]];
         
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
         [imageView addGestureRecognizer:tap];
         
         
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         CZLog(@"%@",error);
     }];
}


@end
