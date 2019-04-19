//
//  AppDelegate.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/17.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "AppDelegate.h"
#import "XBDemoListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    UIViewController *vc = [XBDemoListViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    return YES;
}

@end
