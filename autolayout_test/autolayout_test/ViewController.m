//
//  ViewController.m
//  autolayout_test
//
//  Created by fanyl on 2020/11/16.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:lbl];
    lbl.backgroundColor = [UIColor redColor];
    lbl.text = @"大于20小于70 大于20小于70 大于20小于70";
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_lessThanOrEqualTo(250).priority(800);
        make.width.mas_equalTo(150).priority(400);
    }];
}


@end
