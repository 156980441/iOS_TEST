//
//  ViewController.m
//  find_me
//
//  Created by yunlong on 2022/4/6.
//

#import "ViewController.h"
#import "RootVC.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RootVC *vc = [[RootVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    nav.view.frame = self.view.frame;
}

@end
