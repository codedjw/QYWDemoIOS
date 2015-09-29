//
//  HomeViewController.m
//  QYWDemo
//
//  Created by dujialin on 9/23/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchResultTableViewCell.h"
#import "HomeTableViewController.h"
static NSString* const kSearchResultTableViewCellId = @"SearchResultTableViewCell";

@interface HomeViewController ()<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property(nonatomic, strong)NSArray* searchResults;
@property(nonatomic, strong)NSArray* originalResults;
@property (weak, nonatomic) IBOutlet UIButton *selectPlace;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchDisplayController.searchBar.delegate = self;
    UITextField *searchField = [self.searchDisplayController.searchBar valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.originalResults = @[@"江苏省人民医院", @"江苏省中医院", @"南京鼓楼医院", @"南京军区南京总医院", @"南京市儿童医院", @"南京市妇幼保健院", @"南京解放军81医院", @"南京脑科医院", @"南京同仁医院", @"江苏省口腔医院"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *select = [defaults objectForKey:@"selectPlace"];
    if (select != nil) {
        [self.selectPlace setTitle:select forState:UIControlStateNormal];
    } else {
        [self.selectPlace setTitle:@"请选择" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//===============================================
#pragma mark -
#pragma mark Helper
//===============================================

- (void)configureTableView:(UITableView *)tableView {
    
    tableView.separatorInset = UIEdgeInsetsZero;
    
    [tableView registerNib:[UINib nibWithNibName:kSearchResultTableViewCellId bundle:nil] forCellReuseIdentifier:@"SearchResultTableViewCell"];
    
    UIView *tableFooterViewToGetRidOfBlankRows = [[UIView alloc] initWithFrame:CGRectZero];
    tableFooterViewToGetRidOfBlankRows.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = tableFooterViewToGetRidOfBlankRows;
}

//===============================================
#pragma mark -
#pragma mark UITableView
//===============================================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *filterStr = self.searchDisplayController.searchBar.text;
    if (filterStr != nil && ![filterStr isEqualToString:@""]) {
        NSLog(@"predicate");
        NSIndexSet *indexes = [self.originalResults indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj rangeOfString:filterStr].location != NSNotFound) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchResultTableViewCell *cell = (SearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kSearchResultTableViewCellId forIndexPath:indexPath];
    
    NSArray * array = self.searchResults;
    NSString *filterStr = self.searchDisplayController.searchBar.text;
    if (filterStr == nil || [filterStr isEqualToString:@""]) {
        array = self.originalResults;
    }
    NSString *name = array[indexPath.row];
    cell.titleLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    SearchResultTableViewCell *cell = (SearchResultTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    [defaults setObject:cell.titleLabel.text forKey:@"SelectHospital"];
    [defaults synchronize];
    [self.searchDisplayController setActive:NO animated:YES];
}

//===============================================
#pragma mark -
#pragma mark UISearchDisplayDelegate
//===============================================

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | did load table");
    [self configureTableView:tableView];
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | will unload table");
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | did show table");
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView {
    NSLog(@"🔦 | will hide table");
    [self.tabBarController.tabBar setHidden:NO];
}

// ------------ remove later ----------
#pragma mark UISearchBarDelegate------点击搜索button
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@"上海市闵行区中心医院"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索到“上海市闵行区中心医院”在上海市，是否切换定位？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        [alert show];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"🔦 | should reload table for search string?");
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
//    self.searchResults = [self.names filteredArrayUsingPredicate:predicate];
    
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    self.searchDisplayController.searchResultsTableView.hidden = NO;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    [controller.searchResultsTableView.superview bringSubviewToFront:controller.searchResultsTableView];
    [controller.searchResultsTableView reloadData];
    controller.searchResultsTableView.hidden = NO;
    [self.tabBarController.tabBar setHidden:YES];
}
@end
