//
//  CZTopicVoice.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/2.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTopicVoice.h"
#import "CZTipItem.h"

#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>


@interface CZTopicVoice ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voiceLengthLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progress;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *playBackroundView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation CZTopicVoice

#pragma mark **************************************************************************************************
#pragma mark load



- (void)awakeFromNib
{
    _playCountLable.layer.cornerRadius = _playCountLable.height/5;
    _playCountLable.layer.masksToBounds = YES;
    
    _voiceLengthLable.layer.cornerRadius = _voiceLengthLable.height/5;
    _voiceLengthLable.layer.masksToBounds = YES;
}




#pragma mark **************************************************************************************************
#pragma mark 
-(void)setTopicItem:(CZTipItem *)topicItem
{
    _topicItem =topicItem;
    
    _voiceLengthLable.text = topicItem.voicetime;
    
    _playCountLable.text = topicItem.playcount;
    
     _playBtn.selected = topicItem.isPlaying;
    
    _contentView.hidden = YES;
    _contentView.alpha = 0.0;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        _progress.hidden = NO;
        _progress.roundedCorners = 5;
        _progress.progressLabel.textColor = [UIColor whiteColor];
        CGFloat progress =  1.0 * receivedSize / expectedSize;
        _progress.progress = progress;
        _progress.progressLabel.text = [NSString stringWithFormat:@"%.01f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _progress.hidden = YES;

        _contentView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            _contentView.alpha = 1.0;
        }];
    }];
}

#pragma mark **************************************************************************************************
#pragma mark events
- (IBAction)playVoice:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _topicItem.playing = sender.selected;
    _playBackroundView.selected = sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"playVoice" object:self userInfo:nil];
}




@end
