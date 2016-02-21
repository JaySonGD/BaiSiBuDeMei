//
//  UIView+CAAnimation.h
//  18 . 彩票
//
//  Created by czljcb on 15/12/17.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>





typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionFade = 1,     // 交叉淡化过渡
    TransitionPush,         // 推进效果
    TransitionReveal,       // 揭开效果
    TransitionMoveIn,       // 慢慢进入并覆盖效果
    
    TransitionCube,         // 立体翻转效果
    TransitionSuckEffect,   // 像被吸入瓶子的效果
    TransitionRippleEffect, // 波纹效果
    TransitionPageCurl,     // 翻页效果
    TransitionPageUnCurl,   // 反翻页效果
    TransitionCameraOpen,   // 开镜头效果
    TransitionCameraClose,  // 关镜头效果
    
    
    TransitionCurlDown,     // 下翻页效果
    TransitionCurlUp,       // 上翻页效果
    TransitionFlipFromLeft, // 左翻转效果
    TransitionFlipFromRight,// 右翻转效果
    
    
    TransitionOglFlip,      // 翻转
    TransitionRotate        // 旋转效果
};

//subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
//------------------------------------------------------
//kCATransitionFromRight;
//kCATransitionFromLeft;
//kCATransitionFromTop;
//kCATransitionFromBottom;
//
//当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
//90cw      逆时针旋转 90°
//90ccw     顺时针旋转 90°
//180cw     逆时针旋转 180°
//180ccw    顺时针旋转 180°


typedef NS_ENUM(NSUInteger, TransitionSubtype) {
    TransitionSubtypeFromLeft = 1,  // 从左边进入
    TransitionSubtypeFromRight,     // 从右边进入
    TransitionSubtypeFromTop,       // 从顶部进入
    TransitionSubtypeFromBottom,    // 从底部进入
    
    TransitionSubtype90cw,
    TransitionSubtype90ccw,
    TransitionSubtype180cw,
    TransitionSubtype180ccw
};




@interface UIView (CAAnimation)

+ (void)transitionForView:( UIView * _Nonnull )aView
                     type:(TransitionType)type
                  subtype:(TransitionSubtype)subtype
                 duration:(NSTimeInterval)duration
             animationKey:(NSString * _Nonnull)key
               completion:(void (^ __nullable)())completion;





@end
