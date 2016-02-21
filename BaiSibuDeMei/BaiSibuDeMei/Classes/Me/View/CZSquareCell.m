//
//  CZSquareCell.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/22.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZSquareCell.h"
#import "CZSquareItem.h"

#import <UIImageView+WebCache.h>

@interface CZSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation CZSquareCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setItem:(CZSquareItem *)item
{
    _item = item;
    _name.text = item.name;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
}

@end
