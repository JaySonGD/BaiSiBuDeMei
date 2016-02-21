//
//  CZTagSubController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/21.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZTagSubController.h"

#import "CZTagSubItem.h"
#import "CZTabSubCell.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CZTagSubController ()

@property (nonatomic, strong) NSArray *tabSubItems;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation CZTagSubController

NSString * const ID = @"cell";

#pragma mark **************************************************************************************************
#pragma mark life

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐关注";
    
    [self getTagSubData];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZTabSubCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = 80;
    
    //self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.backgroundColor = Color(206, 206, 206);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    [SVProgressHUD dismiss];
}

#pragma mark **************************************************************************************************
#pragma mark getTagSubData

- (void)getTagSubData
{
    [SVProgressHUD showWithStatus:@"拼命加载中..."];
    
     _mgr = [AFHTTPSessionManager manager];
    
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //    a	true	string	tag_recommend
    //    action	true	string	sub
    //    appname	false	string	参数为baisishequ 分享到朋友圈时候使用
    //    asid	false	string	AC824640-5493-4DAD-B356-F84136BE8A55
    //    c	true	string	topic
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    
    //    @[
    //      @{
    //          @"image_list" : @"http://img.spriteapp.cn/ugc/2016/01/20/163321_13294.jpg",
    //          @"theme_id" : @"10212",
    //          @"theme_name" : @"网友大拜年",
    //          @"is_sub" : @(0),
    //          @"is_default" : @(0),
    //          @"sub_number" : @"700",
    //          }
    //      ];
    
    [_mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
        CZLog( @"%@",responseObject);
        
        [SVProgressHUD dismiss];
        
        _tabSubItems = [CZTagSubItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        CZLog(@"%@",error);
        [SVProgressHUD dismiss];

    }];
}

#pragma mark **************************************************************************************************
#pragma mark UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tabSubItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZTagSubItem *item = _tabSubItems[indexPath.row];
    
    CZTabSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    cell.item = item;
    
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
