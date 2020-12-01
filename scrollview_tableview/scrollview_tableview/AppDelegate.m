//
//  AppDelegate.m
//  scrollview_tableview
//
//  Created by fanyl on 2020/11/26.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
{
    UIWindow *_window;
}
@end

@implementation AppDelegate

// https://www.jianshu.com/p/e255303d11b8?utm_campaign=shakespeare


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [_window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    _window.rootViewController = nav;
    return YES;
}

@end
