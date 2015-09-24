//
//  AppDelegate.m
//  QYWDemo
//
//  Created by dujialin on 9/23/15.
//  Copyright (c) 2015 DJW. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)]) {
        
        [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
        
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Second
    UITabBarController *tabViewController = (UITabBarController *) self.window.rootViewController;
    UITabBar *tabBar = tabViewController.tabBar;
    [tabBar setTintColor:[UIColor colorWithRed:0.13 green:0.56 blue:0.27 alpha:1.0]];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UIImage* tabBarItem2Image = [UIImage imageNamed:@"mail30x30.png"];
    UIImage* tabBarItem2SelectedImage = [UIImage imageNamed:@"mail_on30x30.png"];
    (void)[tabBarItem2 initWithTitle:@"消息中心" image:tabBarItem2Image selectedImage:tabBarItem2SelectedImage];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
