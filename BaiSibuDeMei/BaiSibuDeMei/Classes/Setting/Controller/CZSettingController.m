//
//  CZSettingController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//
#import "CZSettingController.h"
#import "CZHttpViewController.h"

#import <SDWebImage/SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "CZFileTool.h"
#import "CZCachesCell.h"
#import "CZSettingCell.h"
#import "CZFontCell.h"

@interface CZSettingController ()

@property (nonatomic, assign) NSInteger totalSize;

@end

static NSString * const CachesID = @"Cachescell";
static NSString * const FontID = @"Fontcell";

static NSString * const SettingID = @"SettingCell";
static NSString * const NorID = @"cell";



@implementation CZSettingController

#pragma mark **************************************************************************************************
#pragma mark life cylce

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self.tableView registerClass:[CZCachesCell class] forCellReuseIdentifier:CachesID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NorID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZSettingCell class]) bundle:nil] forCellReuseIdentifier:SettingID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZFontCell class]) bundle:nil] forCellReuseIdentifier:FontID];
    
    
    self.navigationItem.title = @"设置";
    
    //    self.automaticallyAdjustsScrollViewInsets = YES;
    //
    //
    //    NSLog(@"%f",self.tableView.contentInset.top);
    //    NSLog(@"%f",self.tableView.contentOffset.y);
    //
    //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.sectionFooterHeight = 0;
    //    self.tableView.sectionHeaderHeight = 0;
    self.tableView.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark **************************************************************************************************
#pragma mark  Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)srection
{
    if (srection == 0)
    {
        return 6;
    }
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0)
    {
        if (row == 0)
        {
            return [tableView dequeueReusableCellWithIdentifier:FontID];
        }
        else if (row == 1)
        {
            CZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingID];
            
            cell.title.text = @"顶部导航自动隐藏";
            cell.rightView.on = NO;
            return cell;
        }
        else if (row == 2)
        {
            CZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingID];
            
            cell.title.text = @"低部导航自动隐藏";
            cell.rightView.on = NO;
            
            return cell;
        }
        else if (row == 3)
        {
            CZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingID];
            cell.rightView.on = NO;
            
            cell.title.text = @"保存浏览进度";
            
            return cell;
        }
        else if (row == 4)
        {
            CZSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingID];
            
            cell.title.text = @"转发时收藏";
            cell.rightView.on = YES;
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"通知设置";
            
            return cell;
        }
    }
    else
    {
        if (row == 0)
        {
            return [tableView dequeueReusableCellWithIdentifier:CachesID];
        }
        else if (row == 1)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"推荐给朋友";
            return cell;
        }
        else if (row == 2)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"意见反馈";
            
            return cell;
        }
        else if (row == 3)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"帮助";
            
            return cell;
        }
        else if (row == 4)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"当前版本:1.0.0";
            
            return cell;
        }
        else if (row == 5)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"推荐下载安装360助手";
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NorID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.text = @"关于我们";
            
            return cell;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CZHttpViewController *aboutMeVC = [[CZHttpViewController alloc] init];

    if (section == 1 && row == 6)
    {
        aboutMeVC.urlString = @"http://www.budejie.com/budejie/aboutus.html?uid=&ver=6.3.1&client=android&market=360zhushou&udid=863575020819998&appname=baisibudejie&mac=e8:d4:e0:d0:8c:7ftime=1455426894570";
        [self.navigationController pushViewController:aboutMeVC animated:YES];
    }
    else if (section == 1 && row == 3)

    {
        aboutMeVC.urlString = @"http://www.budejie.com/budejie/help.html?ver=6.3.1&client=android&market=360zhushou&udid=863575020819998&appname=baisibudejie&mac=e8:d4:e0:d0:8c:7ftime=1455429317705";
        [self.navigationController pushViewController:aboutMeVC animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:aboutMeVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  @"功能设置";
    }
    else
    {
        
        return  @"其它";
        
    }
}


@end
