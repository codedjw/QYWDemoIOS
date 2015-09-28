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

@property(nonatomic, strong)NSArray* searchResults;
@property(nonatomic, strong)NSArray* notReadMsgs;
@property(nonatomic, strong)NSArray* hasReadMsgs;
@property(nonatomic, strong)NSArray* originalResults;

enum msgStatus {
    NOTREAD, HASREAD
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
    self.notReadMsgs = @[@{@"title": @"预约挂号提醒", @"detail": @"2015/09/30 临床营养科 XX 预约成功", @"timestamp": @"2015/09/24"},@{@"title": @"预约挂号提醒", @"detail": @"2015/09/30 临床营养科 XX 预约成功", @"timestamp": @"2015/09/24"},@{@"title": @"预约挂号提醒", @"detail": @"2015/09/30 临床营养科 XX 预约成功", @"timestamp": @"2015/09/24"}];
    self.hasReadMsgs = @[@{@"title": @"查卡结果", @"detail": @"中国人民解放军第四五五医院 查卡失败", @"timestamp": @"2015/09/23"}];
    self.status = NOTREAD;
    self.originalResults = self.notReadMsgs;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentedControlChanged:(id)sender {
    NSInteger idx = self.segCtrl.selectedSegmentIndex;
    self.status = (enum msgStatus) idx;
    switch (self.status) {
        case NOTREAD:
            self.originalResults = self.notReadMsgs;
            break;
        case HASREAD:
            self.originalResults = self.hasReadMsgs;
            break;
        default:
            break;
    }
    NSLog(@"%i", self.status);
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (nil == self.originalResults) ? 0 : [self.originalResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", self.originalResults);
    MsgTableCell *cell = (MsgTableCell *)[self.tableView dequeueReusableCellWithIdentifier:kMsgTableCell forIndexPath:indexPath];
    NSInteger idx = indexPath.row;
    cell.titleLabel.text = (self.originalResults[idx])[@"title"];
    cell.detailLabel.text = (self.originalResults[idx])[@"detail"];
    cell.timestampLabel.text = (self.originalResults[idx])[@"timestamp"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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
    NSLog(@"searchDisplayControllerWillBeginSearch");
//    [self.searchDisplayController.searchBar setBackgroundColor:[UIColor colorWithRed:0.13 green:0.56 blue:0.27 alpha:1.0]];
    NSLog(@"SDVC:%@", NSStringFromCGRect(self.searchDisplayController.searchResultsTableView.frame));
    NSLog(@"Table:%@", NSStringFromCGRect(self.tableView.frame));
    [self.searchDisplayController.searchBar setTranslucent:NO];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
//    [self.searchDisplayController.searchBar setBarTintColor:[UIColor whiteColor]];
    [self.searchDisplayController.searchBar setTranslucent:NO];
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    NSLog(@"here");
    NSLog(@"SDVC:%@", NSStringFromCGRect(self.searchDisplayController.searchResultsTableView.frame));
    NSLog(@"Table:%@", NSStringFromCGRect(self.tableView.frame));
    [controller.searchResultsTableView.superview bringSubviewToFront:controller.searchResultsTableView];
    [controller.searchResultsTableView reloadData];
    controller.searchResultsTableView.hidden = NO;
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
