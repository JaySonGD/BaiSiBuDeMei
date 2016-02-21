//
//  CZSquareHeader.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/8.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZSquareHeader.h"
#import "CZTagItem.h"

@implementation CZSquareHeader



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        
    }
    return self;
}

- (void)setTagItems:(NSArray<CZTagItem *> *)tagItems
{
    _tagItems = tagItems;
    
    NSInteger count = tagItems.count;
    NSInteger sectionCount = 2;
    CGFloat h = 32;
    CGFloat w = (self.width - (sectionCount  - 1))/ sectionCount;
    
    for (NSInteger i = 0; i < count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger row =  i/sectionCount;// h
        NSInteger section = i%sectionCount;// l
        
        btn.y = 0 + row * (h + 1);
        btn.x = 0 + section * (w + 1);
        btn.width = w;
        btn.height = h;
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        [btn setTitle:[NSString stringWithFormat:@"#%@#",tagItems[i].theme_name] forState:UIControlStateNormal];
    }
    
    self.height = ( count + (sectionCount - 1) ) / sectionCount * h * (( count + (sectionCount - 1) ) / sectionCount - 1) ;
    
}



@end
