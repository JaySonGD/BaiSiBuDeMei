//
//  CZLocalVideo.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/16.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZLocalVideo;
@protocol LocalVideoDelegate <NSObject>

@optional



- (void)DidSelectDownloadlocalVideo :(CZLocalVideo *)localVideo;

- (void)DidSelectFinishedlocalVideo :(CZLocalVideo *)localVideo;


@end

@interface CZLocalVideo : UIView

@property (nonatomic, copy) void (^downloadingClick)(void);
@property (nonatomic, copy) void (^finishedClick)(void);

@property (nonatomic, weak) id<LocalVideoDelegate> delegate;

@end
