//
//  CZSquareHeader.h
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/8.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZTagItem;
@interface CZSquareHeader : UICollectionReusableView
@property (nonatomic, strong) NSArray <CZTagItem *> *tagItems;
@property (nonatomic, assign) CGFloat tagH;
@end
