//
//  CZHttpViewController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/15.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZHttpViewController.h"

#import <WebKit/WebKit.h>


@interface CZHttpViewController () <UIScrollViewDelegate>



@property (nonatomic, weak) WKWebView*webView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIProgressView *loadProgress;

@end

@implementation CZHttpViewController

#pragma mark **************************************************************************************************
#pragma mark life

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebView*webView = [[WKWebView alloc] init];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    if (url == nil)
    {
        url = [NSURL URLWithString:@"https://www.baidu.com/"];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    [_contentView addSubview:webView];
    _webView = webView;

    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _webView.frame = _contentView.bounds;
}

- (void)dealloc
{

    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark **************************************************************************************************
#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.navigationItem.title = _webView.title;
    if (_webView.estimatedProgress >= 1 || _webView.estimatedProgress <= 0)
    {
        _loadProgress.hidden = YES;
    }
    else
    {
        _loadProgress.hidden = NO;
    }
    _loadProgress.progress = _webView.estimatedProgress;
    

    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
