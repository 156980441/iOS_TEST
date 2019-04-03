//
//  ViewController.m
//  AddChildVCTest
//
//  Created by fanyl on 2019/4/2.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "RedVC.h"
#import "BlueVC.h"

/*
 苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
 对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
 这样做的好处：
 
 1.无疑，对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
 2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
 3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
 */

/**
 *  在iOS5中，ViewController中新添加了下面几个方法：
 *  addChildViewController:
 *  removeFromParentViewController
 *  transitionFromViewController:toViewController:duration:options:animations:completion:
 *  willMoveToParentViewController:
 *  didMoveToParentViewController:
 */

@interface ViewController ()

@property (nonatomic, strong) RedVC *red;
@property (nonatomic, strong) BlueVC *blue;
@property (nonatomic ,strong) UIViewController *currentVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BlueVC *blue = BlueVC.new;
    blue.view.frame = CGRectMake(100, 200, 200, 300); // 触发 BlueVC 的 viewDidLoad
    [self addChildViewController:blue];
    self.blue = blue;
    
    RedVC *red = RedVC.new;
    red.view.frame = CGRectMake(100, 200, 200, 300); // 触发 RedVC 的 viewDidLoad
    [self addChildViewController:red];
    self.red = red;
    
    [self.view addSubview:self.blue.view]; // 默认,第一个视图(你会发现,全程就这一个用了addSubview)，触发 BlueVC 的 viewWillAppear
    self.currentVC = self.blue;
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bt setTitle:@"change color" forState:UIControlStateNormal];
    bt.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(p_changeVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_changeVC:(UIButton*)bt {
    bt.tag = ++bt.tag % 2;
    if (bt.tag == 0) { // 从 red 到 blue
        [self transitionFromViewController:self.red
                          toViewController:self.blue
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:nil
                                completion:^(BOOL finished) {
                                    if (finished) {
                                        [self.blue didMoveToParentViewController:self];
                                        [self.red willMoveToParentViewController:nil];
                                        self.currentVC = self.blue;
                                    }
                                }];
    }
    else {
        [self transitionFromViewController:self.blue
                          toViewController:self.red
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:nil
                                completion:^(BOOL finished) {
                                    [self.red didMoveToParentViewController:self]; // 触发 View Controller 生命周期
                                    [self.blue willMoveToParentViewController:nil];
                                    self.currentVC = self.red;
                                }];
    }
    
}


@end
