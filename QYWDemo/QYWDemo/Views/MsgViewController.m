//
//  MsgViewController.m
//  QYWDemo
//
//  Created by Du Jiawei on 9/27/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "MsgViewController.h"

@interface MsgViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) NSArray *viewControllerIDs;
@property (nonatomic, weak) UIViewController *currentSubViewController;

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllerIDs = @[@"NotReadTableID", @"HasReadTableID"];
    [self segmentedControlChanged:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentedControlChanged:(id)sender {
    NSInteger idx = self.segCtrl.selectedSegmentIndex;
    if (idx < self.viewControllerIDs.count) {
        [self showChildTableViewControllerWithIdentifier:self.viewControllerIDs[idx]];
    }
}

- (void)showChildTableViewControllerWithIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* ctrl = [storyboard instantiateViewControllerWithIdentifier:identifier];
    if (ctrl) {
        [self.currentSubViewController removeFromParentViewController];
        [self.currentSubViewController.view removeFromSuperview];
        self.currentSubViewController = ctrl;
        [self addChildViewController:ctrl];
        [self.containerView addSubview:ctrl.view];
        ctrl.view.frame = self.containerView.bounds;
    }
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
