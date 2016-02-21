//
//  CZTopicPicture.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/1.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTopicPicture.h"
#import "CZTipItem.h"

#import "CZSeePictureController.h"


#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>

@interface CZTopicPicture ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progress;

@end

@implementation CZTopicPicture

- (void)awakeFromNib
{
    _imageView.userInteractionEnabled = YES;
    [_seeBigPicture addTarget:self action:@selector(seePicture) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seePicture)]];
}

- (void)seePicture
{
    CZSeePictureController *seeVC = [[CZSeePictureController alloc] init];
    seeVC.item = _topicItem;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeVC animated:YES completion:nil];
}

- (void)setTopicItem:(CZTipItem *)topicItem
{
    _topicItem = topicItem;
    
    _gifView.hidden = ![topicItem.is_gif boolValue];
    
    
    CGFloat height = [topicItem.height integerValue] * (iPhoneSize.width - 2 * 10) / [topicItem.width integerValue];
    
    if (height >= iPhoneSize.height)
    {
        _seeBigPicture.hidden = NO;
        _imageView.contentMode = UIViewContentModeTop;
        _imageView.layer.masksToBounds = YES;
    }
    else
    {
        _seeBigPicture.hidden = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = NO;
    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _progress.hidden = NO;
        _progress.roundedCorners = 5;
        _progress.progressLabel.textColor = [UIColor whiteColor];
        CGFloat progress =  1.0 * receivedSize / expectedSize;
        _progress.progress = progress;
        _progress.progressLabel.text = [NSString stringWithFormat:@"%.01f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        _progress.hidden = YES;
    }];
}

@end
