//
//  BlueVC.m
//  AddChildVCTest
//
//  Created by fanyl on 2019/4/2.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "BlueVC.h"

@interface BlueVC ()

@end

@implementation BlueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s", __func__);
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s", __func__);
}

@end
