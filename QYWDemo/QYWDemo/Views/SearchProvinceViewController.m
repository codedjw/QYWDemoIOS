//
//  SearchProvinceViewController.m
//  QYWDemo
//
//  Created by Du Jiawei on 9/29/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "SearchProvinceViewController.h"

@interface SearchProvinceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation SearchProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectAction:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"南京" forKey:@"selectPlace"];
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
