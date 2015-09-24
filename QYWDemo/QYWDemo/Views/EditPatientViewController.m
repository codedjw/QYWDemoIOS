//
//  EditPatientViewController.m
//  QYWDemo
//
//  Created by Du Jiawei on 9/24/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "EditPatientViewController.h"

@interface EditPatientViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *editCellID = @"editCellID";
//    XYBookInfoMainCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
//    if (cell == nil) {
//        // XYSaleItemCell.xib as NibName
//        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XYBookInfoMainCell" owner:nil options:nil];
//        //第一个对象就是BookInfoCellIdentifier了（xib所列子控件中的最高父控件，BookInfoCellIdentifier）
//        cell = [nib objectAtIndex:0];
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:editCellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editCellID];
    }
    return cell;
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
