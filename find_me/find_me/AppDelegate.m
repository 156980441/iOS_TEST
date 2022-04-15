//
//  AppDelegate.m
//  find_me
//
//  Created by yunlong on 2022/4/6.
//

#import "AppDelegate.h"
#import "RootVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootVC *vc = [[RootVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
