//
//  MsgViewController.m
//  QYWDemo
//
//  Created by Du Jiawei on 9/27/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "MsgViewController.h"
#import "HelperClass.h"

static NSString* const kMsgTableCell = @"MsgTableCell";

@interface MsgTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation MsgTableCell

@end

@interface MsgViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong)NSMutableArray* searchResults;
@property(nonatomic, strong)NSMutableArray* notReadMsgs;
@property(nonatomic, strong)NSMutableArray* hasReadMsgs;
@property(nonatomic, strong)NSMutableArray* originalResults;

enum msgStatus {
    NONE = 0,
    NOTREAD = 1 << 0,
    HASREAD = 1 << 1,
    SEARCH = 1 << 2
};

@property enum msgStatus status;

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *searchField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
//    [searchField setBackgroundColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.90 alpha:1.0f]];
//    [self.searchDisplayController.searchBar setBarTintColor:[UIColor whiteColor]];
    [searchField setTextColor:[UIColor blackColor]];
    [self segmentedControlChanged:nil];
    [HelperClass setExtraCellLineHidden:self.tableView];
    [HelperClass setExtraCellLineHidden:self.searchDisplayController.searchResultsTableView];
    self.notReadMsgs = [[NSMutableArray alloc] initWithArray:@[@{@"title": @"预约挂号提醒", @"detail": @"2015/09/30 临床营养科 XX 预约成功", @"timestamp": @"2015/09/24"},@{@"title": @"预约挂号提醒", @"detail": @"2015/09/10 内科 XXX 预约成功", @"timestamp": @"2015/09/09"},@{@"title": @"预约挂号提醒", @"detail": @"2015/08/30 骨科 XXXX 预约成功", @"timestamp": @"2014/08/24"}]];
    self.hasReadMsgs = [[NSMutableArray alloc] initWithArray:@[@{@"title": @"查卡结果", @"detail": @"中国人民解放军第四五五医院 查卡失败", @"timestamp": @"2015/09/10"}, @{@"title": @"查卡结果", @"detail": @"江苏省南京市第一医院 查卡失败", @"timestamp": @"2015/08/23"}, @{@"title": @"查卡结果", @"detail": @"上海市闵行区中心医院 查卡失败", @"timestamp": @"2015/08/15"}, @{@"title": @"查卡结果", @"detail": @"江苏省南京市鼓楼医院 查卡失败", @"timestamp": @"2014/07/30"}]];
    self.originalResults = [[NSMutableArray alloc] init];
    self.searchResults = [[NSMutableArray alloc] init];
    self.status = NOTREAD;
    self.originalResults = self.notReadMsgs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentedControlChanged:(id)sender {
    NSInteger idx = self.segCtrl.selectedSegmentIndex;
    enum msgStatus segVal = (enum msgStatus) (idx+1);
    self.status = (self.status & SEARCH ) | segVal;
    if (self.status & NOTREAD) {
         self.originalResults = self.notReadMsgs;
    }
    if (self.status & HASREAD) {
        self.originalResults = self.hasReadMsgs;
    }
    NSLog(@"segmentedControlChanged %i", self.status);
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView != self.tableView) {
        NSString *filterStr = self.searchDisplayController.searchBar.text;
        NSLog(@"predicate");
        NSIndexSet *indexes = [self.originalResults indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if (([obj[@"title"] rangeOfString:filterStr].location != NSNotFound) || ([obj[@"detail"] rangeOfString:filterStr].location != NSNotFound) || ([obj[@"timestamp"] rangeOfString:filterStr].location != NSNotFound)) {
                return YES;
            }
            return NO;
        }];
        self.searchResults = [[self.originalResults objectsAtIndexes:indexes] mutableCopy];
//        NSLog(@"%@", self.searchResults);
        return (nil == self.searchResults) ? 0 : [self.searchResults count];
    } else {
        return (nil == self.originalResults) ? 0 : [self.originalResults count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", self.originalResults);
    MsgTableCell *cell = (MsgTableCell *)[self.tableView dequeueReusableCellWithIdentifier:kMsgTableCell forIndexPath:indexPath];
    NSInteger idx = indexPath.row;
    NSArray *array = self.originalResults;
    if (tableView != self.tableView) {
        array = self.searchResults;
    }
    cell.titleLabel.text = (array[idx])[@"title"];
    cell.detailLabel.text = (array[idx])[@"detail"];
    cell.timestampLabel.text = (array[idx])[@"timestamp"];
    cell.tag = indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.status & NOTREAD) {
        return @"已读";
    } if (self.status & HASREAD) {
        return @"未读";
    } else {
        return @"";
    }
}

- (void)deleteOneNotReadMsg:(NSInteger)tag
{
    
}

- (void)deleteOneHasReadMsg:(NSInteger)tag
{
    
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tmp, *tmp2, *tmp3= nil;
    if (self.status & NOTREAD) {
        if (self.status & SEARCH) {
            tmp = self.searchResults;
            tmp2 = self.hasReadMsgs;
            tmp3 = self.notReadMsgs;
        } else {
            tmp = self.notReadMsgs;
            tmp2 = self.hasReadMsgs;
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSInteger tag = cell.tag;
        [self deleteOneNotReadMsg:tag];
    }
    if (self.status & HASREAD) {
        if (self.status & SEARCH) {
            tmp = self.searchResults;
            tmp2 = self.notReadMsgs;
            tmp3 = self.hasReadMsgs;
        } else {
            tmp = self.hasReadMsgs;
            tmp2 = self.notReadMsgs;
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSInteger tag = cell.tag;
        [self deleteOneNotReadMsg:tag];
    }
    if (tmp) {
        if (editingStyle == UITableViewCellEditingStyleDelete)  {
            [tmp2 addObject:[tmp objectAtIndex:indexPath.row]]; // 添加到另一个数组中
            // need check
            if (tmp3) {
                [tmp3 removeObject:[tmp objectAtIndex:indexPath.row]];
            }
            [tmp removeObjectAtIndex:indexPath.row];  //删除数组里的数据
            if (tableView == self.tableView) {
                [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
            } else {
                ///// search bar ///// -- cannot use the above function
                [tableView reloadData];
            }
        }
    }
}

#pragma mark -
#pragma mark UISearchDisplayDelegate
//===============================================

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | did load table");
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | will unload table");
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | did show table");
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | will hide table");
    self.status = self.status & (~ SEARCH);
    NSLog(@"willHideSearchResultsTableView: %i", self.status);
     [self.tabBarController.tabBar setHidden:NO];
    [self.tableView reloadData];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"🔦 | should reload table for search string?");
    
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
//        self.searchResults = [self.originalResults filteredArrayUsingPredicate:predicate];
    
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    self.searchDisplayController.searchResultsTableView.hidden = NO;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.status = self.status | SEARCH;
    NSLog(@"searchDisplayControllerWillBeginSearch: %i", self.status);
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
//    [self.searchDisplayController.searchBar setBarTintColor:[UIColor whiteColor]];
    [self.searchDisplayController.searchBar setTranslucent:NO];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
//    NSLog(@"here");
//    NSLog(@"SDVC:%@", NSStringFromCGRect(self.searchDisplayController.searchResultsTableView.frame));
//    NSLog(@"Table:%@", NSStringFromCGRect(self.tableView.frame));
    [controller.searchResultsTableView.superview bringSubviewToFront:controller.searchResultsTableView];
    [controller.searchResultsTableView reloadData];
    controller.searchResultsTableView.hidden = NO;
    [self.tabBarController.tabBar setHidden:YES];
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
