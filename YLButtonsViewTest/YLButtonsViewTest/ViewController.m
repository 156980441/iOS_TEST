//
//  ViewController.m
//  YLButtonsViewTest
//
//  Created by fanyl on 2019/3/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "YLButtonsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YLButtonsView *buttonsView = [[YLButtonsView alloc] initWithButtons:5];
    buttonsView.frame = CGRectMake(50, 100, 300, 20);
    [self.view addSubview:buttonsView];
    
    YLButtonsView *buttonsView1 = [[YLButtonsView alloc] initWithFrame:CGRectZero titles:@[@"国产", @"美剧", @"韩剧"] images:nil internalSpace:5];
    [self.view addSubview:buttonsView1];
    [buttonsView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonsView.mas_left);
        make.right.equalTo(buttonsView.mas_right);
        make.top.equalTo(buttonsView.mas_bottom).offset(5);
    }];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor blueColor];
    [bt setTitle:@"动漫" forState:UIControlStateNormal];
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.backgroundColor = [UIColor yellowColor];
    [bt1 setTitle:@"电影" forState:UIControlStateNormal];
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.backgroundColor = [UIColor redColor];
    [bt2 setTitle:@"电视剧" forState:UIControlStateNormal];
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt3.backgroundColor = [UIColor grayColor];
    [bt3 setTitle:@"综艺" forState:UIControlStateNormal];
    YLButtonsView *buttonsView2 = [[YLButtonsView alloc] initWithFrame:CGRectZero buttons:@[bt, bt1, bt2, bt3] internalSpace:10];
    [self.view addSubview:buttonsView2];
    [buttonsView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonsView1.mas_left);
        make.right.equalTo(buttonsView1.mas_right);
        make.top.equalTo(buttonsView1.mas_bottom).offset(5);
    }];
    buttonsView2.block = ^(UIButton * _Nonnull btn, NSInteger index) {
        NSLog(@"%zd", index);
        NSLog(@"%@", btn.titleLabel.text);
        
        if (index == 0) {
            buttonsView2.verticalDisplay = !buttonsView2.verticalDisplay;
        }
    };
}


@end
