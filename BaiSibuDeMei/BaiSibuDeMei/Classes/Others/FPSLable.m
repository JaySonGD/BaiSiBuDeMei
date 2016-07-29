//
//  FPSLable.m
//  FPSDemo
//
//  Created by czljcb on 16/6/10.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "FPSLable.h"





//#import "YYFPSLabel.h"
//#import <YYKit/YYKit.h>
//#import "YYText.h"
//#import "YYWeakProxy.h"

#define kSize CGSizeMake(55, 20)

@implementation FPSLable {
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    
    NSTimeInterval _llll;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
//    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    _font = [UIFont systemFontOfSize:12];//[UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont systemFontOfSize:10];;//[UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont systemFontOfSize:14];;//[UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont systemFontOfSize:4];//[UIFont fontWithName:@"Courier" size:4];
    }
    
    __weak typeof(self) weakSelf = self;
    
    _link = [CADisplayLink displayLinkWithTarget: weakSelf selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = color;
    att[NSFontAttributeName] = _font;

    [text setAttributes:att range:NSMakeRange(0, text.length - 3)];
//    [text yy_setColor:color range:NSMakeRange(0, text.length - 3)];
    att[NSForegroundColorAttributeName] = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    att[NSFontAttributeName] = _subFont;

    [text setAttributes:att range:NSMakeRange(text.length - 3, 3)];

//    [text yy_setColor:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
//    text.yy_font = _font;
//    [text yy_setFont:_subFont range:NSMakeRange(text.length - 4, 1)];
    
    self.attributedText = text;
}

@end