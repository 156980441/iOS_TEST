//
//  HeaderViewVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/13.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "HeaderViewVC.h"
#import "LeftVC.h"
#import "RightVC.h"
#import "HeaderBottomVC.h"

@interface HeaderViewVC ()
@property (nonatomic, strong) LeftVC *leftVC;
@property (nonatomic, strong) RightVC *rightVC;
@property (nonatomic, strong) HeaderBottomVC *bottomVC;
@end

@implementation HeaderViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 背景橘黄
        // 容器视图灰色
        // tableview 绿色
        // 子控制器左边黄色
        // 子控制器左边红色
        self.view.backgroundColor = [UIColor orangeColor];
        
        _leftVC = [[LeftVC alloc] initWithNibName:nil bundle:nil];
        _rightVC = [[RightVC alloc] initWithNibName:nil bundle:nil];
        _bottomVC = [[HeaderBottomVC alloc] initWithNibName:nil bundle:nil];
        
        [self.view addSubview:_bottomVC.view];
        [_bottomVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        
        
        UIView *wrapper = UIView.new;
        wrapper.backgroundColor = [UIColor grayColor];
        // 相关视图放入容器
        [wrapper addSubview:_leftVC.view];
        [wrapper addSubview:_rightVC.view];
        
        [_leftVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wrapper);
            make.left.equalTo(wrapper);
            make.width.equalTo(wrapper.mas_width).multipliedBy(0.5);
            make.height.equalTo(@600);
        }];
        [_rightVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wrapper);
            make.right.equalTo(wrapper);
            make.width.equalTo(wrapper.mas_width).multipliedBy(0.5);
        }];
        
        [wrapper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_leftVC.view.mas_bottom);
            make.width.mas_equalTo(CGRectGetWidth(_bottomVC.view.frame));
        }];
        
        [_bottomVC setHeaderView:wrapper];
    }
    return self;
}

@end
