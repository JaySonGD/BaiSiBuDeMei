//
//  CZSeePictureController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/3.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZSeePictureController.h"
#import "CZTipItem.h"

#import <UIImageView+WebCache.h>

@interface CZSeePictureController () <UIScrollViewDelegate , UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation CZSeePictureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [_contentView addSubview:imageView];
    _imageView = imageView;
    CGFloat height = [_item.height floatValue] / [_item.width floatValue] * iPhoneSize.width;
    
    imageView.height = height;
    imageView.width = iPhoneSize.width;
    
    if (height <= iPhoneSize.height)
    {
        imageView.center = CGPointMake(iPhoneSize.width * 0.5, iPhoneSize.height * 0.5);
    }
    else
    {
        _contentView.contentSize = CGSizeMake(iPhoneSize.width, height);
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.item.large_image]];
    imageView.userInteractionEnabled = YES;
    [_contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)]];
    
    CGFloat scale = [_item.width floatValue]/ iPhoneSize.width;
    
    if (scale > 1.0)
    {
        _contentView.maximumZoomScale = scale;
    }
    
    _contentView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark **************************************************************************************************
#pragma mark delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

#pragma mark **************************************************************************************************
#pragma mark events



- (IBAction)backClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveClick:(UIButton *)sender
{
    UIImage *image = _imageView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (IBAction)repostClick:(UIButton *)sender
{
    
}

#pragma mark **************************************************************************************************
#pragma mark didFinishSavingWithError

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"%s", __func__);
}

@end
