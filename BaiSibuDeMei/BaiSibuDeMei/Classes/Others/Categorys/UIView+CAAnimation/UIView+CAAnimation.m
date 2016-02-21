//
//  UIView+CAAnimation.m
//  18 . 彩票
//
//  Created by czljcb on 15/12/17.
//  Copyright © 2015年 czljcb. All rights reserved.
//

#import "UIView+CAAnimation.h"

@implementation UIView (CAAnimation)


+ (void)basicAnimationForView:(UIView *)view
                      keyPath:(NSString *)keyPath
                      toValue:(id)toValue
                    fromValue:(id)fromValue
                      byValue:(id)byValue
          removedOnCompletion:(BOOL)isRemovedOnCompletion
                     fillMode:(NSString *)fillMode
                     duration:(NSTimeInterval)duration
                 animationKey:(NSString*)key

{
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = keyPath;
    basicAnimation.toValue = toValue;     // 动画移动到的位置 endPoint
    basicAnimation.fromValue = fromValue; // 动画开始的位置  startPoint
    basicAnimation.byValue = byValue;     // 动画移动的位置  过程
    basicAnimation.removedOnCompletion = isRemovedOnCompletion;
    basicAnimation.fillMode = fillMode;
    basicAnimation.duration = duration;
    basicAnimation.autoreverses = YES;
    
    [view.layer addAnimation:basicAnimation forKey:key];
    
    
    
}




+ (void)transitionForView:(UIView *)aView
                     type:(TransitionType)type
                  subtype:(TransitionSubtype)subtype
                 duration:(NSTimeInterval)duration
             animationKey:(NSString *)key
               completion:(void (^ __nullable)())completion

{
    
 
    NSString *animationType = nil;
    NSString *animationSubtype = nil;
    
    switch (subtype) {
        case  TransitionSubtypeFromLeft:
            animationSubtype = kCATransitionFromLeft;
            break;
        case  TransitionSubtypeFromRight:
            animationSubtype = kCATransitionFromRight;
            break;
        case  TransitionSubtypeFromTop:
            animationSubtype = kCATransitionFromTop;
            break;
        case  TransitionSubtypeFromBottom:
            animationSubtype = kCATransitionFromBottom;
            break;
        case TransitionSubtype90cw:
            animationSubtype = @"90cw";
            break;
        case TransitionSubtype90ccw:
            animationSubtype = @"90ccw";
            break;
        case TransitionSubtype180cw:
            animationSubtype = @"180cw";
            break;
        case TransitionSubtype180ccw:
            animationSubtype = @"180ccw";
            break;
        default:
            break;
    }
    
    switch (type) {
        case  TransitionFade: {
            animationType = kCATransitionFade;
            break;
        }
        case  TransitionPush: {
            animationType = kCATransitionPush;
            break;
        }
        case  TransitionReveal: {
            animationType = kCATransitionReveal;
            break;
        }
        case  TransitionMoveIn: {
            animationType = kCATransitionMoveIn;
            break;
        }
        case  TransitionCube: {
            animationType = @"cube";
            break;
        }
        case  TransitionSuckEffect: {
            animationType = @"suckEffect";
            break;
        }
        case  TransitionRippleEffect: {
            animationType = @"rippleEffect";
            break;
        }
        case  TransitionPageCurl: {
            animationType = @"pageCurl";
            break;
        }
        case  TransitionPageUnCurl: {
            animationType = @"pageUnCurl";
            break;
        }
        case  TransitionCameraOpen: {
            animationType = @"cameraIrisHollowOpen";
            break;
        }
        case  TransitionCameraClose: {
            animationType = @"cameraIrisHollowClose";
            break;
        }
        case  TransitionCurlDown: {
            [self animationForView:aView type:UIViewAnimationTransitionCurlDown duration:duration];
            break;
        }
        case  TransitionCurlUp: {
            [self animationForView:aView type:UIViewAnimationTransitionCurlUp duration:duration];
            break;
        }
        case  TransitionFlipFromLeft: {
            [self animationForView:aView type:UIViewAnimationTransitionFlipFromLeft duration:duration];
            break;
        }
        case  TransitionFlipFromRight: {
            [self animationForView:aView type:UIViewAnimationTransitionFlipFromRight duration:duration];
            break;
        }
        case  TransitionOglFlip:
            animationType = @"oglFlip";
            break;
        case TransitionRotate:
            animationType = @"rotate";
            break;
        default: {
            break;
        }
    }
    
    if (animationType != nil) {
        CATransition *animation = [CATransition animation];
        animation.duration = duration;
        animation.type = animationType;
        
        if (animationSubtype != nil) {
            animation.subtype = animationSubtype;
        }
        
        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        
        [aView.layer addAnimation:animation forKey:key];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (completion)
        {
            completion();
        }
      
    });
}

+ (void)animationForView:(UIView *)aView
                    type:(UIViewAnimationTransition)type
                duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:type forView:aView cache:YES];
    }];
}






@end
