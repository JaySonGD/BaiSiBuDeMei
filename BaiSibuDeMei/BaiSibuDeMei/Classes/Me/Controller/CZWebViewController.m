//
//  CZWebViewController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/23.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZWebViewController.h"

#import <WebKit/WebKit.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface CZWebViewController ()


@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwork;

@property (nonatomic, weak) WKWebView*webView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIProgressView *loadProgress;

@end

@implementation CZWebViewController

#pragma mark **************************************************************************************************
#pragma mark life

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebView*webView = [[WKWebView alloc] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    [webView loadRequest:request];
    [_contentView addSubview:webView];
    _webView = webView;
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];

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
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
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
    
    _back.enabled = _webView.canGoBack;
    _forwork.enabled = _webView.canGoForward;
    
}

#pragma mark **************************************************************************************************
#pragma mark events
- (IBAction)backClick:(UIBarButtonItem *)sender
{
    [_webView goBack];
}
- (IBAction)forwork:(UIBarButtonItem *)sender
{
    [_webView goForward];
}
- (IBAction)refreshClick:(UIBarButtonItem *)sender
{
    [_webView reload];
}

@end
