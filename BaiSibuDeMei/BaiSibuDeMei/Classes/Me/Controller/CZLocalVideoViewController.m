//
//  CZLocalVideoViewController.m
//  BaiSibuDeMei
//
//  Created by czljcb on 16/2/16.
//  Copyright © 2016年 czljcb. All rights reserved.
//

#import "CZLocalVideoViewController.h"

#import "CZLocalVideo.h"

@interface CZLocalVideoViewController () <LocalVideoDelegate>

@property (nonatomic, weak) UIButton *rightBtn;

@end

@implementation CZLocalVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CZLocalVideo *titleView = [CZLocalVideo viewFromXib];
    self.navigationItem.titleView = titleView;
    titleView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonTiemWithNormalImage:[UIImage imageNamed:@"iconfont-iconfontdelete (2)" ] highlightedImage:[UIImage imageNamed:@"iconfont-iconfontdelete (3)" ] addTarget:self action:@selector(trashClick)];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)trashClick
{
    
}

#pragma mark **************************************************************************************************
#pragma mark LocalVideoDelegate

- (void)DidSelectDownloadlocalVideo:(CZLocalVideo *)localVideo
{
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
}

- (void)DidSelectFinishedlocalVideo:(CZLocalVideo *)localVideo
{
    self.navigationItem.rightBarButtonItem.customView.hidden=NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    
    cell.backgroundColor = RandomColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.navigationItem.rightBarButtonItem);
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
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
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
