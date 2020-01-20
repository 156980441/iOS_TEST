//
//  ViewController.m
//  TradeDemo
//
//  Created by fanyl on 2020/1/20.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "StrategyFactory.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AbsStrategyVC *vc = [StrategyFactory createStrategyVC:StrategyVCTypeLimitPrice];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
}


@end
