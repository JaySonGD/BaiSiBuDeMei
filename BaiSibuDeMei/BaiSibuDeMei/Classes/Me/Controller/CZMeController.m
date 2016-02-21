//
//  CZMeController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/1/19.
//  Copyright © 2016年 czljcb. All rights reserved.
//
#import "CZLocalVideoViewController.h"
#import "CZLoginRegisterController.h"
#import "CZMeController.h"
#import "CZSettingController.h"
#import "CZSquareItem.h"
#import "CZTagItem.h"
#import "CZSquareCell.h"
#import "CZWebViewController.h"
#import "CZSquareHeader.h"
#import "CZErrorView.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>


#import <MJExtension/MJExtension.h>
#import <SafariServices/SafariServices.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CZMeController () <UICollectionViewDataSource , UICollectionViewDelegate , SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *tags;


@property (nonatomic, weak) UICollectionView *footView;

@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

static NSString *const ID = @"cell";

@implementation CZMeController
CGFloat spacing = 1;
NSInteger count = 4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AFNetworkReachabilityManager *mgr= [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络3G|4G");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            default:
                break;
        }
    }];
    
    [mgr startMonitoring];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"nav_coin_icon"] highlightedImage:[UIImage imageNamed:@"nav_coin_icon_click"] addTarget:self action:@selector(coinClick)];
    
    UIBarButtonItem *setBtn = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(settingClick)];
    
    UIBarButtonItem *modeBtn = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(modeClick:)];
    
    self.navigationItem.rightBarButtonItems = @[setBtn,modeBtn];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat hw = 1.0 * (iPhoneSize.width - 3 * spacing )/ count;
    
    
    layout.itemSize = CGSizeMake(hw, hw);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    UICollectionView *footView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    footView.backgroundColor = self.tableView.backgroundColor;
    footView.dataSource = self;
    footView.delegate = self;
    _footView = footView;
    footView.scrollEnabled = NO;
    self.tableView.tableFooterView = footView;
    
    [footView registerNib:[UINib nibWithNibName:NSStringFromClass([CZSquareCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    //    //注册headerView Nib的view需要继承UICollectionReusableView
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    //    //注册footerView Nib的view需要继承UICollectionReusableView
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    //
    //    [footView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader"];
    [footView registerClass:[CZSquareHeader class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader"];
    //[footView registerNib:[UINib nibWithNibName:NSStringFromClass([CZSquareHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader"];
    
    [self loadData];
    
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        CZLocalVideoViewController *localVC = [[CZLocalVideoViewController alloc] init];
        [self.navigationController pushViewController:localVC animated:YES];
    }
    else
    {
        CZLoginRegisterController *loginRegister = [[CZLoginRegisterController alloc] init];
        [self presentViewController:loginRegister animated:YES completion:nil];
    }
}

#pragma mark **************************************************************************************************
#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZSquareItem *item = _squares[indexPath.row];
    
    if (![item.url hasPrefix:@"http"]) {
        return;
    }
    
    CZWebViewController *webVC = [[CZWebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
    
    //    SFSafariViewController *sfsVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:item.url]]; // ios9
    //    self.navigationController.navigationBarHidden = YES;
    //    sfsVC.delegate = self;
    //    [self.navigationController pushViewController:sfsVC animated:YES];
    //[self presentViewController:sfsVC animated:YES completion:nil];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = @"UICollectionReusableViewFooter";
    }else{
        reuseIdentifier = @"UICollectionReusableViewHeader";
    }
    
    CZSquareHeader *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind
                                                                withReuseIdentifier:reuseIdentifier
                                                                       forIndexPath:indexPath
                             ];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        view.tagItems = self.tags;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        
    }
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    NSInteger count = self.tags.count;
    NSInteger sectionCount = 2;
    CGFloat h = 32;
    
    
    CGFloat tagHeight = ( count + (sectionCount - 1) ) / sectionCount * h * (( count + (sectionCount - 1) ) / sectionCount - 1) ;
    CGSize size={self.view.width,tagHeight};
    return size;
}

#pragma mark **************************************************************************************************
#pragma mark SFSafariViewControllerDelegate

//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
//{
//    NSLog(@"%s", __func__);
//    [self.navigationController popViewControllerAnimated:YES];
//}


#pragma mark **************************************************************************************************
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _squares.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CZSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    CZSquareItem *item = _squares[indexPath.item];
    cell.item = item;
    return cell;
}

#pragma mark **************************************************************************************************
#pragma mark events

- (void)coinClick
{
    CZLoginRegisterController *loginRegister = [[CZLoginRegisterController alloc] init];
    [self presentViewController:loginRegister animated:YES completion:nil];
}

- (void)settingClick
{
    CZSettingController *setVC = [[CZSettingController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)modeClick:(UIButton *)mode
{
    mode.selected = !mode.selected;
}


#pragma mark **************************************************************************************************
#pragma mark
//http://api.budejie.com/api/api_open.php?a=square&c=topic
- (void)loadData
{
    [SVProgressHUD showWithStatus:@"拼命加载中..."];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //    a	true	string	square
    //    appname	false	string	参数为baisishequ 分享到朋友圈时候使用
    //    asid	false	string	AC824640-5493-4DAD-B356-F84136BE8A55
    //    c	true	string	topic
    static NSString * const urlStr = @"http://api.budejie.com/api/api_open.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    CGFloat hw = 1.0 * (iPhoneSize.width - 3 * spacing )/ count;
    
    [mgr GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *square = responseObject[@"square_list"];
        
        NSArray *tag = responseObject[@"tag_list"];
        
        _squares = [CZSquareItem mj_objectArrayWithKeyValuesArray:square];
        _tags = [CZTagItem mj_objectArrayWithKeyValuesArray:tag];
        
        NSInteger rows = (_squares.count + count -1 )/ count;
        
        
        NSInteger count = tag.count;
        NSInteger sectionCount = 2;
        CGFloat h = 32;
        
        
        CGFloat tagHeight = ( count + (sectionCount - 1) ) / sectionCount * h * (( count + (sectionCount - 1) ) / sectionCount - 1) ;
        
        _footView.height = hw * rows   + 15 + tagHeight;
        
        NSInteger lastCount =count -( _squares.count % count);
        
        for (NSInteger i = 0; i < lastCount; i ++)
        {
            [_squares addObject:[CZSquareItem  new]];
        }
        
        [_footView reloadData];
        self.tableView.tableFooterView = _footView;
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        
        CZErrorView *errorBtn = [CZErrorView viewFromXib];
        
        [self.view addSubview:errorBtn];
        errorBtn.center = self.view.center;
        
        errorBtn.errorClick = ^{
          
            NSLog(@"555");
            //[self loadData];
        };
        
    }];
    
}


@end
