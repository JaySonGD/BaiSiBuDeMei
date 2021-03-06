//
//  CZAllController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/27.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZAllController.h"
#import "CZTipItem.h"
#import "CZHTTPSessionManager.h"
#import "CZRefreshHeader.h"
#import "CZRefreshFooter.h"
#import "CZTopicCell.h"
#import "CZTopicVoice.h"
#import "CZVoiceView.h"
#import "CZTopicVideo.h"
#import "WMPlayer.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AVFoundation/AVFoundation.h>


@interface CZAllController () <UIScrollViewDelegate>
{
    NSString *_totalTime;
    NSDateFormatter *_dateFormatter;
}


@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, weak) UILabel *loadingText ;

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, weak) CZHTTPSessionManager *mgr;

@property (nonatomic, strong) AVPlayer *Player;

@property (nonatomic, strong) NSMutableArray <AVPlayer *> *players;

@property (nonatomic, strong) NSMutableArray <AVPlayerItem *> *playItems;

@property (nonatomic, weak)   CZVoiceView *voiceView ;

@property (nonatomic, strong) WMPlayer *myPlayer;

@property (nonatomic, weak) CZTopicVideo *video;

@property (nonatomic, assign) CGFloat orginY;

@property (nonatomic, assign) CGRect orginFrame;


@end

static  NSString * const ID = @"cell";


@implementation CZAllController

#pragma mark **************************************************************************************************
#pragma mark load


- (CZVoiceView *)voiceView
{
    if (!_voiceView)
    {
        CZVoiceView *voiceView = [CZVoiceView viewFromXib];
        [self.parentViewController.view addSubview:voiceView];
        _voiceView = voiceView;
        voiceView.x = 5;
        voiceView.y = 104;
        voiceView.width = self.view.width - 10;
        
        [_voiceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    }
    return _voiceView;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CZFunc();
    CGPoint point = [pan translationInView:pan.view];
    
    _voiceView.y += point.y;
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (CZHTTPSessionManager *)mgr
{
    if (!_mgr)
    {
        _mgr = [CZHTTPSessionManager manager];
    }
    return _mgr;
}

- (NSMutableArray<AVPlayerItem *> *)playItems
{
    if (!_playItems)
    {
        _playItems = [NSMutableArray array];
    }
    return _playItems;
}


- (NSMutableArray<AVPlayer *> *)players
{
    if (!_players)
    {
        _players = [NSMutableArray array];
    }
    return _players;
}

- (AVPlayer *)Player
{
    if (!_Player)
    {
        _Player = [[AVPlayer alloc] init];
    }
    return _Player;
}
#pragma mark **************************************************************************************************
#pragma mark play

- (void)playVoiceWith:(CZTipItem *)item
{
    [self.Player pause];
    [self.tips makeObjectsPerformSelector:@selector(setPlaying:) withObject:@(NO)];
    
    
    [self.playItems addObject:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:item.voiceuri]]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.Player replaceCurrentItemWithPlayerItem:[self.playItems lastObject]];
        
    });
    
    
    [[self.playItems lastObject] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [[self.playItems lastObject] addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    
    [self.Player play];
    
    item.playing = YES;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@---%@",keyPath,change);
    
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            CMTime duration = [self.playItems lastObject].duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgess) userInfo:nil repeats:YES];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        
    }
}
- (void)updateProgess
{
    CZFunc()
    self.voiceView.progress.progress = CMTimeGetSeconds(self.Player.currentTime) / CMTimeGetSeconds([self.playItems lastObject].duration);
    
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

#pragma mark **************************************************************************************************
#pragma mark life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    
    
    self.tableView.mj_header = [CZRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    [self.tableView.mj_header beginRefreshing];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVoiceNotification:) name:@"playVoice" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoNotification:) name:@"playVideo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClickNotice) name:@"fullScreenBtnClickNotice" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo) name:@"closeTheVideo" object:nil];
    
}

- (void)closeTheVideo
{
    
    if (_myPlayer.isFullscreen)
    {
        [self toNormal];
    }
    
    [_myPlayer.player.currentItem cancelPendingSeeks];
    [_myPlayer.player.currentItem.asset cancelLoading];
    
    [_myPlayer.player pause];
    [_myPlayer removeFromSuperview];
    [_myPlayer.playerLayer removeFromSuperlayer];
    [_myPlayer.player replaceCurrentItemWithPlayerItem:nil];
    _myPlayer = nil;
    _myPlayer.player = nil;
    _myPlayer.currentItem = nil;
    
    _myPlayer.playOrPauseBtn = nil;
    _myPlayer.playerLayer = nil;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView reloadData];
}

- (void)fullScreenBtnClickNotice
{
    if (_myPlayer.isFullscreen)
    {
        [self toNormal];
    }
    else
    {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
}


-(void)toNormal{
    



    [UIView animateWithDuration:0.25 animations:^{
        _myPlayer.transform = CGAffineTransformIdentity;
        _myPlayer.frame =CGRectMake(_orginFrame.origin.x, _orginFrame.origin.y, _orginFrame.size.width, _orginFrame.size.height);
        _myPlayer.playerLayer.frame =  _myPlayer.bounds;
        
        if (_orginFrame.size.width == self.view.width * 0.5)
        {
            [self.parentViewController.view addSubview:_myPlayer];
            
        }
        else
        {
            [_video.player addSubview:_myPlayer];
        }

        [_myPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_myPlayer).with.offset(0);
            make.right.equalTo(_myPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_myPlayer).with.offset(0);
        }];
        [_myPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_myPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_myPlayer).with.offset(5);
        }];
        
    }completion:^(BOOL finished) {
        _myPlayer.isFullscreen = NO;
        _myPlayer.fullScreenBtn.selected = NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
        [self dismissViewControllerAnimated:NO completion:nil];

    }];
}


-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [UIApplication sharedApplication].statusBarHidden = YES ;
    _orginFrame = _myPlayer.frame;
    [_myPlayer removeFromSuperview];
    _myPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        _myPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        _myPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    _myPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _myPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [_myPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [_myPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_myPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_myPlayer).with.offset(5);
        
    }];
    
    UIViewController *videoVC = [[UIViewController alloc] init];
    [videoVC.view addSubview:_myPlayer];
    [self presentViewController:videoVC animated:YES completion:nil];

    
    _myPlayer.isFullscreen = YES;
    _myPlayer.fullScreenBtn.selected = YES;
    [_myPlayer bringSubviewToFront:_myPlayer.bottomView];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)playVideoNotification:(NSNotification *)noti
{
    _video = (CZTopicVideo *)noti.object;
    
    
    
    
    _orginY = _video.superview.superview.y + _video.y + _video.height;
    
    
    
    if (_myPlayer)
    {
        _myPlayer.frame = CGRectMake(0, 0, _video.width - 20, _video.height);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_myPlayer setVideoURLStr:_video.topicItem.videouri];
        });

        

        [_myPlayer removeFromSuperview];
        [_video.player addSubview:_myPlayer];
    }
    else
    {
        WMPlayer *myPlayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, 0, _video.width - 20, _video.height) videoURLStr:_video.topicItem.videouri];
        [_video.player addSubview:myPlayer];
        _myPlayer = myPlayer;

    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_myPlayer.player play];
    });
    

    
}



- (void)playVoiceNotification:(NSNotification *)noti
{
    CZTopicVoice *voice = (CZTopicVoice *)noti.object;
    [self playVoiceWith:voice.topicItem];
    
    [self.voiceView.iconView sd_setImageWithURL:[NSURL URLWithString:voice.topicItem.large_image]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark **************************************************************************************************
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_myPlayer)
    {
        
        CGRect curFrame = [_video.player convertRect:_video.player.bounds toView:nil];
        
        NSLog(@"%f----%f --- %f - %f",scrollView.contentOffset.y , _orginY ,curFrame.origin.y,scrollView.contentInset.top);
        
        
        
        if (scrollView.contentOffset.y > (_orginY - 64) && _myPlayer.width !=  _video.width * 0.5)
        {
            [_myPlayer removeFromSuperview];
            [self.parentViewController.view addSubview:_myPlayer];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                _myPlayer.x = self.video.width * 0.5;
                _myPlayer.width = _video.width * 0.5;
                _myPlayer.height = _myPlayer.width * 9/16;
                
                _myPlayer.y = self.view.height - _myPlayer.height-49;

                
            }];
            
        }
        else if (scrollView.contentOffset.y > _orginY - self.view.height  - scrollView.contentInset.top - 49 && scrollView.contentOffset.y <= (_orginY - 64) && _myPlayer.width ==  _video.width * 0.5)
        {
            [_myPlayer removeFromSuperview];
            [_video.player addSubview:_myPlayer];
            [UIView animateWithDuration:0.25 animations:^{
                _myPlayer.frame = CGRectMake(0, 0, _video.width - 20, _video.height);

                
            }];
        }
        else if (scrollView.contentOffset.y < _orginY - self.view.height  - scrollView.contentInset.top - 49 && _myPlayer.width !=  _video.width * 0.5)
        {
            [_myPlayer removeFromSuperview];
            [self.parentViewController.view addSubview:_myPlayer];
            
            
                _myPlayer.x = self.video.width * 0.5;
                _myPlayer.width = _video.width * 0.5;
                _myPlayer.height = _myPlayer.width * 9/16;
                
                _myPlayer.y = self.view.height - _myPlayer.height-49;
                
                
        }
        
    }
}

#pragma mark **************************************************************************************************
#pragma mark  test loading

- (void)test
{
    
    
    //    UIView *loading = [[UIView alloc] init];
    //    loading.backgroundColor = [UIColor orangeColor];
    //    loading.x = 0;
    //    loading.y = -100;
    //    loading.height = 100;
    //    loading.width = self.tableView.width;
    //
    //    UILabel *loadingText = [[UILabel alloc] init];
    //    loadingText.text = @"下拉刷新";
    //    _loadingText = loadingText;
    //    [loadingText sizeToFit];
    //    loadingText.center = CGPointMake(180, 50);
    //    [loading addSubview:loadingText];
    //    [self.tableView addSubview:loading];
    
    
    //- (void)scrollViewDidScroll:(UIScrollView *)scrollView
    //{
    //    //NSLog(@"%f",scrollView.contentOffset.y);
    //
    //    CGFloat  offsetY = scrollView.contentOffset.y;
    //
    //    if (scrollView.contentInset.top == 199)
    //    {
    //        NSLog(@"%@",_loadingText.text);
    //        return;
    //    }
    //    NSLog(@"%f",scrollView.contentInset.top);
    //
    //    if (offsetY <= -199)
    //    {
    //        _loadingText.text = @"松手刷新";
    //    }
    //    else
    //    {
    //        _loadingText.text = @"下拉刷新";
    //    }
    //}
    //
    //
    //- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
    //{
    //   CZFunc()
    //    CGFloat  offsetY = scrollView.contentOffset.y;
    //    if (offsetY <= -199)
    //    {
    //       __block UIEdgeInsets inset = scrollView.contentInset;
    //        inset.top = 199;
    //        scrollView.contentInset = inset;
    //        _loadingText.text = @"刷新中...";
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //
    //            [UIView animateWithDuration:1.0 animations:^{
    //
    //                inset.top = 99;
    //
    //                scrollView.contentInset = inset;
    //
    //            }];
    //
    //
    //        });
    //    }
    //}
    
    
}

#pragma mark **************************************************************************************************
#pragma mark loadNewTopic

- (void)loadNewTopic
{
    
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    static NSString * const urlStr = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(TopicTypeAll);
    
    [self.mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        _tips = [CZTipItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            self.tableView.mj_footer = [CZRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%zd---%@",error.code,error);
    }];
}

#pragma mark **************************************************************************************************
#pragma mark loadMoreTopic

- (void)loadMoreTopic
{
    
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    static NSString * const urlStr = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"type"] = @(TopicTypeAll);
    
    
    [self.mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        NSArray *moreTopics = [CZTipItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tips addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%zd---%@",error.code,error);
    }];
}

#pragma mark **************************************************************************************************
#pragma mark Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tips.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tips[indexPath.row] cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZTipItem *tipItem = _tips[indexPath.row];
    
    CZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topicItem = tipItem;
    
    
    return cell;
}



@end
