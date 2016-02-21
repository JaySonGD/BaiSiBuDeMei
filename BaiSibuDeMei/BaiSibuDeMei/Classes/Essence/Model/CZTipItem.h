//
//  CZTipItem.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/28.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CZCommentItem;

typedef enum : NSInteger {
    TopicTypeAll = 1,
    TopicTypePicture = 10,
    TopicTypeWord = 29,
    TopicTypeVoice = 31,
    TopicTypeVideo = 41
} TopicType;

@interface CZTipItem : NSObject


/** 发帖时间 */
@property (nonatomic, copy)   NSString *created_at;
/** 最热评论 */
@property (nonatomic, strong) NSArray<CZCommentItem *> *top_cmt;
/** 帖子内容 */
@property (nonatomic, copy)   NSString *text;
/** 顶人数 */
@property (nonatomic, copy)   NSString *ding;
/** 昵称 */
@property (nonatomic, copy)   NSString *name;
/** 踩人数 */
@property (nonatomic, copy)   NSString *cai;
/** 头像 */
@property (nonatomic, copy)   NSString *profile_image;

/** 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, copy)   NSString *type;

@property (nonatomic, copy)   NSString *height;
@property (nonatomic, copy)   NSString *width;

@property (nonatomic, copy)   NSString *is_gif;
@property (nonatomic, copy)   NSString *comment;
@property (nonatomic, copy)   NSString *repost;
@property (nonatomic, copy)   NSString *playcount;
@property (nonatomic, copy)   NSString *videotime;
@property (nonatomic, copy)   NSString *voicetime;
@property (nonatomic, copy)   NSString *voiceuri;






@property (nonatomic, copy)   NSString *small_image; //small
@property (nonatomic, copy)   NSString *large_image; //large
@property (nonatomic, copy)   NSString *middle_image; //middle

//@property (nonatomic, copy)   NSString *image0; //small
//@property (nonatomic, copy)   NSString *image1; //large
//@property (nonatomic, copy)   NSString *image2; //middle


//@property (nonatomic, copy)   NSString *voicelength;
//@property (nonatomic, assign) NSInteger cache_version;
//@property (nonatomic, copy)   NSString *id;
//@property (nonatomic, copy)   NSString *bimageuri;
//@property (nonatomic, copy)   NSString *theme_type;
//@property (nonatomic, copy)   NSString *hate;
//@property (nonatomic, copy)   NSString *passtime;
//@property (nonatomic, copy)   NSString *tag;
//@property (nonatomic, copy)   NSString *cdn_img;
//@property (nonatomic, copy)   NSString *theme_name;
//@property (nonatomic, copy)   NSString *create_time;
//@property (nonatomic, copy)   NSString *favourite;
//@property (nonatomic, strong) NSArray *themes;
//@property (nonatomic, copy)   NSString *status;
//@property (nonatomic, copy)   NSString *bookmark;
//@property (nonatomic, copy)   NSString *screen_name;
//@property (nonatomic, copy)   NSString *love;
//@property (nonatomic, copy)   NSString *user_id;
//@property (nonatomic, copy)   NSString *theme_id;
//@property (nonatomic, copy)   NSString *original_pid;
//@property (nonatomic, copy)   NSString *gifFistFrame;
//@property (nonatomic, assign) NSInteger t;
//@property (nonatomic, copy)   NSString *weixin_url;
@property (nonatomic, copy)   NSString *videouri;


/** 对应模型cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign ,getter=isPlaying) BOOL playing;

@end
