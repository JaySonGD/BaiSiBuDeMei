//
//  CZTopicVideo.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/2.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZTipItem;
@interface CZTopicVideo : UIView
@property (nonatomic, strong) CZTipItem *topicItem;
@property (weak, nonatomic) IBOutlet UIView *player;

@end
