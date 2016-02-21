//
//  CZAllController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/27.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZPictureController.h"
#import "CZTipItem.h"
#import "CZHTTPSessionManager.h"
#import "CZRefreshHeader.h"
#import "CZRefreshFooter.h"
#import "CZTopicCell.h"


#import <SDWebImage/UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AVFoundation/AVFoundation.h>


@interface CZPictureController () <UIScrollViewDelegate>



@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, weak) UILabel *loadingText ;

@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, weak) CZHTTPSessionManager *mgr;


@end

static  NSString * const ID = @"cell";


@implementation CZPictureController

#pragma mark **************************************************************************************************
#pragma mark load


- (CZHTTPSessionManager *)mgr
{
    if (!_mgr)
    {
        _mgr = [CZHTTPSessionManager manager];
    }
    return _mgr;
}



#pragma mark **************************************************************************************************
#pragma mark life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    
    
    self.tableView.mj_header = [CZRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    [self.tableView.mj_header beginRefreshing];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark **************************************************************************************************
#pragma mark  test loading

- (void)test
{
    
    
    //    UIView *loading = [[UIView alloc] init];
    //    loading.backgroundColor = [UIColor orangeColor];
    //    loading.x = 0;
    //    loading.y = -100;
    //    loading.height = 100;
    //    loading.width = self.tableView.width;
    //
    //    UILabel *loadingText = [[UILabel alloc] init];
    //    loadingText.text = @"下拉刷新";
    //    _loadingText = loadingText;
    //    [loadingText sizeToFit];
    //    loadingText.center = CGPointMake(180, 50);
    //    [loading addSubview:loadingText];
    //    [self.tableView addSubview:loading];
    
    
    //- (void)scrollViewDidScroll:(UIScrollView *)scrollView
    //{
    //    //NSLog(@"%f",scrollView.contentOffset.y);
    //
    //    CGFloat  offsetY = scrollView.contentOffset.y;
    //
    //    if (scrollView.contentInset.top == 199)
    //    {
    //        NSLog(@"%@",_loadingText.text);
    //        return;
    //    }
    //    NSLog(@"%f",scrollView.contentInset.top);
    //
    //    if (offsetY <= -199)
    //    {
    //        _loadingText.text = @"松手刷新";
    //    }
    //    else
    //    {
    //        _loadingText.text = @"下拉刷新";
    //    }
    //}
    //
    //
    //- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
    //{
    //   CZFunc()
    //    CGFloat  offsetY = scrollView.contentOffset.y;
    //    if (offsetY <= -199)
    //    {
    //       __block UIEdgeInsets inset = scrollView.contentInset;
    //        inset.top = 199;
    //        scrollView.contentInset = inset;
    //        _loadingText.text = @"刷新中...";
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //
    //            [UIView animateWithDuration:1.0 animations:^{
    //
    //                inset.top = 99;
    //
    //                scrollView.contentInset = inset;
    //
    //            }];
    //
    //
    //        });
    //    }
    //}
    
    
}

#pragma mark **************************************************************************************************
#pragma mark loadNewTopic

- (void)loadNewTopic
{
    
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    static NSString * const urlStr = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(TopicTypePicture);
    
    [self.mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        _tips = [CZTipItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            self.tableView.mj_footer = [CZRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%zd---%@",error.code,error);
    }];
}

#pragma mark **************************************************************************************************
#pragma mark loadMoreTopic

- (void)loadMoreTopic
{
    
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    static NSString * const urlStr = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    parameters[@"type"] = @(TopicTypePicture);
    
    
    [self.mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        NSArray *moreTopics = [CZTipItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tips addObjectsFromArray:moreTopics];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%zd---%@",error.code,error);
    }];
}

#pragma mark **************************************************************************************************
#pragma mark Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tips.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tips[indexPath.row] cellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZTipItem *tipItem = _tips[indexPath.row];
    
    CZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topicItem = tipItem;
    
    
    return cell;
}



@end
