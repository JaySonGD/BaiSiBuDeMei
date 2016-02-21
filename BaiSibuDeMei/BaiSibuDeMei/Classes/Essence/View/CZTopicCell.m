//
//  CZTopicCell.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/31.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTopicCell.h"
#import "CZTipItem.h"
#import "CZCommentItem.h"
#import "CZUserItem.h"

#import "CZTopicVideo.h"
#import "CZTopicVoice.h"
#import "CZTopicPicture.h"

#import <UIImageView+WebCache.h>

@interface CZTopicCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *created_at_Lable;
@property (weak, nonatomic) IBOutlet UIView *top_cmt_View;
@property (weak, nonatomic) IBOutlet UILabel *top_cmt_Lable;

@property (nonatomic, strong) CZTopicPicture *pictureView;
@property (nonatomic, strong) CZTopicVideo *videoView;
@property (nonatomic, strong) CZTopicVoice *voiceView;


@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@end


@implementation CZTopicCell

#pragma mark **************************************************************************************************
#pragma mark load

- (CZTopicPicture *)pictureView
{
    if (!_pictureView)
    {
        CZTopicPicture *pictureView = [CZTopicPicture viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (CZTopicVideo *)videoView
{
    if (!_videoView)
    {
        CZTopicVideo *videoView = [CZTopicVideo viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}


- (CZTopicVoice *)voiceView
{
    if (!_voiceView)
    {
        CZTopicVoice *voiceView = [CZTopicVoice viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}



- (void)awakeFromNib
{
    // Initialization code
    _profile_imageView.layer.cornerRadius = _profile_imageView.width * 0.5;
    _profile_imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
    
}

- (void)setTopicItem:(CZTipItem *)topicItem
{
    _topicItem = topicItem;
    
    _textLable.text = topicItem.text;
    
    [_profile_imageView sd_setImageWithURL: [NSURL URLWithString:topicItem.profile_image]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    _nameLable.text = topicItem.name;
    
    _created_at_Lable.text = topicItem.created_at;
    
    if (topicItem.top_cmt.count)
    {
        _top_cmt_View.hidden = NO;
        _top_cmt_Lable.text =
        [NSString stringWithFormat:@"%@:%@",[topicItem.top_cmt lastObject].user.username ,[topicItem.top_cmt lastObject].content];
    }
    else
    {
        _top_cmt_View.hidden = YES;
    }
    
    CGSize textMaxSize = CGSizeMake(iPhoneSize.width - 2 * 10, MAXFLOAT);
    CGSize textSize = [topicItem.text boundingRectWithSize:textMaxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName :     [UIFont systemFontOfSize:15]
                                                             }
                                                   context:nil
                       ].size;

    
    if ([topicItem.type integerValue] == TopicTypePicture)
    {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.pictureView.x = 0;
        self.pictureView.y = 55 + textSize.height + 10;
        self.pictureView.width = iPhoneSize.width ;
        self.pictureView.height = [topicItem.height integerValue] * (iPhoneSize.width - 2 * 10) / [topicItem.width integerValue];
        self.pictureView.topicItem = topicItem;
        
        if (self.pictureView.height >= iPhoneSize.height)
        {
            self.pictureView.height = (iPhoneSize.width - 2 * 10) * 9 / 16;
        }
    }
    else if ([topicItem.type integerValue] == TopicTypeVideo)
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        
        self.videoView.x = 0;
        self.videoView.y = 55 + textSize.height + 10;
        self.videoView.width = iPhoneSize.width ;
        self.videoView.height = [topicItem.height integerValue] * (iPhoneSize.width - 2 * 10) / [topicItem.width integerValue];
        self.videoView.topicItem = topicItem;
    }
    else if ([topicItem.type integerValue] == TopicTypeVoice)
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        
        self.voiceView.x = 0;
        self.voiceView.y = 55 + textSize.height + 10;
        self.voiceView.width = iPhoneSize.width ;
        self.voiceView.height = [topicItem.height integerValue] * (iPhoneSize.width - 2 * 10) / [topicItem.width integerValue];
        self.voiceView.topicItem = topicItem;
    }
    else
    {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    
    [_caiBtn setTitle:topicItem.cai forState:UIControlStateNormal];
    [_dingBtn setTitle:topicItem.ding forState:UIControlStateNormal];
    [_shareBtn setTitle:topicItem.repost forState:UIControlStateNormal];
    [_commentBtn setTitle:topicItem.comment forState:UIControlStateNormal];
    
}

- (IBAction)moreClick:(UIButton *)sender
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    
    
}


@end
