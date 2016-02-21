//
//  CZLoginRegisterTF.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/22.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZLoginRegisterTF.h"

#import <objc/message.h>

@implementation CZLoginRegisterTF

- (void)awakeFromNib
{
    //UILabel *placeHolder = [self valueForKeyPath:@"_placeholderLabel"];
    //placeHolder.textColor = [UIColor orangeColor];
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    [self setAttributedPlaceholder:att];
    
    self.tintColor = [UIColor redColor];
//    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEnd) name:UITextFieldTextDidEndEditingNotification object:self];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBegin) name:UITextFieldTextDidBeginEditingNotification object:self];
    //[self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    // 监听结束编辑
    //[self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textEnd
{
    NSLog(@"%s", __func__);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    [self setAttributedPlaceholder:att];
}

- (void)textBegin
{
    NSLog(@"%s", __func__);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
    
    [self setAttributedPlaceholder:att];
}

@end
