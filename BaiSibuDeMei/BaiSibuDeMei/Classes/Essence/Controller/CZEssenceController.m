//
//  CZEssenceController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//
#import "CZHttpViewController.h"
#import "CZEssenceController.h"

#import "CZAllController.h"
#import "CZVideoController.h"
#import "CZPictureController.h"
#import "CZVoiceController.h"
#import "CZWordController.h"


@interface CZEssenceController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *selectedBtn;

@property (nonatomic, weak) UIScrollView *scrollView ;

@property (nonatomic, weak) UIScrollView *titleView ;

@property (nonatomic, weak) UIView *line ;

@end

@implementation CZEssenceController



#pragma mark **************************************************************************************************
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSLog(@"%@",NSHomeDirectory());
    
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(leftBtnClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:self action:@selector(rightBtnClick)];
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = titleView;
    
    [self initScrollView];
    [self initChildViewControllers];
    [self initTitleView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark **************************************************************************************************
#pragma mark init

- (void)initScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
}

- (void)initChildViewControllers
{
    CZAllController *allVC = [[CZAllController alloc] init];
    [self addChildViewController:allVC];
    
    CZVideoController *videoVC = [[CZVideoController alloc] init];
    [self addChildViewController:videoVC];
    
    CZVoiceController *voiceVC = [[CZVoiceController alloc] init];
    [self addChildViewController:voiceVC];
    
    
    CZPictureController *pictureVC = [[CZPictureController alloc] init];
    [self addChildViewController:pictureVC];
    
    
    CZWordController *wordVC = [[CZWordController alloc] init];
    [self addChildViewController:wordVC];
    
    self.scrollView.contentSize = CGSizeMake(_scrollView.width * self.childViewControllers.count, 0);
    
}


- (void)initTitleView
{
    NSArray *titles = @[@"全部", @"视频",@"声音", @"图片" ,@"段子"];
    
    UIScrollView *titleView = [[UIScrollView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.65];
    titleView.x = 0;
    titleView.y = 64;
    titleView.height = 35;
    titleView.width = self.view.width;
    _titleView = titleView;
    [self.view addSubview:titleView];
    
    NSInteger count = titles.count;
    //CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = titleView.width/count;
    CGFloat h = 35;
    
    
    for (NSInteger i =0 ; i < count; i++)
    {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        
        titleBtn.frame = CGRectMake(i * w, y, w, h);
        [titleView addSubview:titleBtn];
        
        if (!i)
        {
            [self titleClick:titleBtn];
            [self addChildView:0];
        }
        


    }
    
    UIButton *titleBtn = [titleView.subviews firstObject];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [titleBtn titleColorForState:UIControlStateSelected];
    [titleBtn.titleLabel sizeToFit];

    line.width = titleBtn.titleLabel.width;
    line.centerX = titleBtn.centerX;
    line.height = 1;
    line.y = 34;
    _line = line;
    [titleView addSubview:line];

}

- (void)addChildView:(NSInteger)index
{
    UIViewController *vc = self.childViewControllers[index];
    if ([vc isViewLoaded]) return;
    
    [_scrollView addSubview:vc.view];
    vc.view.x = _scrollView.width * index;
    vc.view.y = 0;
    vc.view.width = _scrollView.width;
    vc.view.height = _scrollView.height;
//    vc.view.backgroundColor = RandomColor;
    
    
}


#pragma mark **************************************************************************************************
#pragma mark events

- (void)titleClick:(UIButton *)titleBtn
{
    _selectedBtn.selected = NO;
    titleBtn.selected = YES;
    _selectedBtn = titleBtn;
    
    NSInteger index = titleBtn.x / titleBtn.width;
    
    CGPoint offset = _scrollView.contentOffset;
    offset.x = _scrollView.width * index;
    [_scrollView setContentOffset:offset animated:YES];

    [UIView animateWithDuration:0.25 animations:^{
       
        _line.width = titleBtn.titleLabel.width;
        _line.centerX = titleBtn.centerX;

        
    }];
}

- (void)leftBtnClick
{
    CZFunc();
    CZHttpViewController *shareVC = [[CZHttpViewController alloc] init];
    shareVC.urlString = @"http://jiejiegame.spriteapp.cn/Client/web/Default.aspx?87ddd83&ver=6.3.1&client=android&market=360zhushou&udid=863575020819998&appname=baisibudejie&mac=e8:d4:e0:d0:8c:7ftime=1455546016737";
    
    [self.navigationController pushViewController:shareVC animated:YES];
}

- (void)rightBtnClick
{
    CZFunc();
}

#pragma mark **************************************************************************************************
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger index = scrollView.contentOffset.x / _scrollView.width;
    
    UIButton *btn = _titleView.subviews[index];
    
    [self titleClick:btn];
    [self addChildView:index];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildView:scrollView.contentOffset.x / scrollView.width];

}

@end
