//
//  AppDelegate.m
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
{
    UIWindow *_window;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = [[ViewController alloc] init];
    [_window makeKeyAndVisible];
    return YES;
}


@end
