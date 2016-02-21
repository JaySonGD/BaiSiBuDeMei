
//
//  CZTopicVideo.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/2.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTopicVideo.h"
#import "CZTipItem.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

#import "WMPlayer.h"


@interface CZTopicVideo ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;
@property (weak, nonatomic) IBOutlet UIButton *play;



@end


@implementation CZTopicVideo


- (void)awakeFromNib
{
    _playCountLable.layer.cornerRadius = _playCountLable.height/5;
    _playCountLable.layer.masksToBounds = YES;
    
    _videoTimeLable.layer.cornerRadius = _videoTimeLable.height/5;
    _videoTimeLable.layer.masksToBounds = YES;
    _player.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeTheVideo) name:@"closeTheVideo" object:nil];
    
}

- (void)closeTheVideo
{
    
    
    _player.hidden = YES;
    _play.selected = !_play.selected;
    _topicItem.playing = _play.selected;
    _play.hidden = NO;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)playClick:(UIButton *)sender
{

    
    sender.selected = !sender.selected;
    _topicItem.playing = sender.selected;
    sender.hidden = YES;

    [[NSNotificationCenter defaultCenter] postNotificationName: @"playVideo" object:self userInfo:nil];
    
    _player.hidden = NO;
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@---%@",keyPath,change);
}



-(void)setTopicItem:(CZTipItem *)topicItem
{
    _topicItem =topicItem;
    
    _videoTimeLable.text = topicItem.videotime;
    
    _playCountLable.text = topicItem.playcount;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
    }];
}

@end
