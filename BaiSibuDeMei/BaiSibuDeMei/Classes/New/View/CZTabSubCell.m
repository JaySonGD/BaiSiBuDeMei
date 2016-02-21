//
//  CZTabSubCell.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTabSubCell.h"
#import "CZTagSubItem.h"
#import "UIImage+icon.h"
#import "UIImage+Antialias.h"

#import <SDWebImage/UIImageView+WebCache.h>


@interface CZTabSubCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UILabel *readNumber;

@end

@implementation CZTabSubCell

- (void)awakeFromNib
{
    // Initialization code
    //_iconView.layer.cornerRadius = _iconView.width * 0.5;
    //_iconView.layer.masksToBounds = YES;
    //self.layoutMargins = UIEdgeInsetsZero;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subscribesubscribesubscribesubscribesubscribesubscribeClick:(UIButton *)sender
{
    
}




#pragma mark **************************************************************************************************
#pragma mark setting
-(void)setItem:(CZTagSubItem *)item
{
    _item = item;
    
    _titleName.text = item.theme_name;
    
    CGFloat sub_number = 0;
    
    if ([item.sub_number integerValue] > 10000)
    {
        sub_number = 1.0 * [item.sub_number integerValue] / 10000;
        _readNumber.text = [NSString stringWithFormat:@"%0.1f万人订阅",sub_number];

    }
    else
    {
        _readNumber.text = [NSString stringWithFormat:@"%zd人订阅",[item.sub_number integerValue]];

    }
    
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        [path addClip];
        
        [image drawAtPoint:CGPointZero];
        
        _iconView.image = [UIGraphicsGetImageFromCurrentImageContext() imageAntialias];
        
        UIGraphicsEndImageContext();
        
        

    }];
    
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}
@end
