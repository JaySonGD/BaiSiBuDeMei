//
//  CZHUD.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/14.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(void);

@interface CZHUD : UIView

@property (nonatomic, copy) block doEvent ;

@property (nonatomic, copy) block cancelEvent ;


@end
