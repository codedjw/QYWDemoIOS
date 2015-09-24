//
//  HelperClass.m
//  QYWDemoIOS
//
//  Created by Du Jiawei on 9/22/15.
//  Copyright (c) 2015 Du Jiawei. All rights reserved.
//

#import "HelperClass.h"

@implementation HelperClass

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
