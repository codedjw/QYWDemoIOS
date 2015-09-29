//
//  PatientsTableViewController.m
//  QYWDemo
//
//  Created by Du Jiawei on 9/25/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "PatientListTableViewController.h"

static NSString * const kPatientItemCellID = @"PatientItemCell";
@interface PatientItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation PatientItemCell
@end


@interface PatientListTableViewController ()
@property NSInteger selectedPID;
//@property (nonatomic, strong) NSArray *patients;
@end

@implementation PatientListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.patients = @[@{@"name":@"张三", @"idcardID":@"32011019850415XXXX", @"phone": @"138XXXXXXXX", @"gender":@"男"}, @{@"name":@"李四", @"idcardID":@"51012319900216XXXX", @"phone": @"139XXXXXXXX", @"gender":@"女"}];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] != nil && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"][@"name"] isEqualToString:@"李四"]) {
        self.selectedPID = 1;
    } else {
        self.selectedPID = 0;
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientItemCell *cell = (PatientItemCell *)[tableView dequeueReusableCellWithIdentifier:kPatientItemCellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"张三";
        cell.detailLabel.text = @"男 / 30岁";
    }
    if (indexPath.row == 1) {
        cell.nameLabel.text = @"李四";
        cell.detailLabel.text = @"女 / 25岁";
    }
    
    if (indexPath.row == self.selectedPID) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *preCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedPID inSection:indexPath.section]];
    [preCell setAccessoryType:UITableViewCellAccessoryNone];
    
    UITableViewCell *curCell = [tableView cellForRowAtIndexPath:indexPath];
    [curCell setAccessoryType:UITableViewCellAccessoryCheckmark];
    self.selectedPID = indexPath.row;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.selectedPID == 0) {
        [defaults setObject:@{@"name":@"张三", @"idcardID":@"32011019850415XXXX", @"phone": @"138XXXXXXXX", @"gender":@"男"} forKey:@"userInfo"];
        [defaults setObject:@"张三，欢迎您！" forKey:@"welcomeMsg"];
    } else {
        [defaults setObject:@{@"name":@"李四", @"idcardID":@"51012319900216XXXX", @"phone": @"139XXXXXXXX", @"gender":@"女"} forKey:@"userInfo"];
         [defaults setObject:@"李四，欢迎您！" forKey:@"welcomeMsg"];
    }
    [defaults synchronize];
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
