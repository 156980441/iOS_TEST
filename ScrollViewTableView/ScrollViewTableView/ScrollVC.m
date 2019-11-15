//
//  ViewController.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/10/29.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ScrollVC.h"
#import "LeftVC.h"
#import "RightVC.h"
#import "ScrollViewBottomVC.h"

#import "OKBScrollView.h"

@interface ScrollVC () <UIScrollViewDelegate>
{
    BOOL _scrollEnabled;
}
//@property (nonatomic, strong) UIScrollView *scrollView; // BottomVC 的 scrollview delegate 收不到回调
@property (nonatomic, strong) OKBScrollView *scrollView; // BottomVC 的 scrollview delegate 可以收到回调
@property (nonatomic, strong) LeftVC *leftVC;
@property (nonatomic, strong) RightVC *rightVC;
@property (nonatomic, strong) ScrollViewBottomVC *bottomVC;

@end

@implementation ScrollVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scrollEnabled = YES;
        // 接收底部视图离开顶端的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(acceptMsg:)
                                                     name:kHomeLeaveTopNotification
                                                   object:nil];
        // 背景橘黄
        // scrollView 蓝色
        // 容器视图灰色
        // tableview 绿色
        // 子控制器左边黄色
        // 子控制器左边红色
        self.view.backgroundColor = [UIColor orangeColor];
        
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView = [[OKBScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        
        UIView *wrapper = UIView.new;
        wrapper.backgroundColor = [UIColor grayColor];
        [_scrollView addSubview:wrapper]; // 先把容器视图放入
        [wrapper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView).insets(UIEdgeInsetsZero);
            make.width.equalTo(self.scrollView); // 不能少！
        }];
        
        _leftVC = [[LeftVC alloc] initWithNibName:nil bundle:nil];
        _rightVC = [[RightVC alloc] initWithNibName:nil bundle:nil];
        _bottomVC = [[ScrollViewBottomVC alloc] initWithNibName:nil bundle:nil];
        
        // 相关视图放入容器
        [wrapper addSubview:_bottomVC.view];
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
        [_bottomVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftVC.view.mas_bottom);
            make.left.right.equalTo(wrapper);
        }];
        
        [wrapper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomVC.view.mas_bottom);
        }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notification

- (void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"scrollEnabled"];
    if ([canScroll isEqualToString:@"1"]) {
        _scrollEnabled = YES;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"scrollView的偏移量：=== %f", contentOffsetY);
    CGFloat maxOffsetY = CGRectGetMaxY(self.leftVC.view.frame);
    if (contentOffsetY > maxOffsetY) { // 滑到顶端了
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)]; // 设置最大偏移
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomeGoTopNotification
                                                            object:nil
                                                          userInfo:@{@"scrollEnabled" : @"1"}]; // 告诉底部，内容视图能进行滑动了
        _scrollEnabled = NO;   // 自己不能滑动了
    } else {
        if (_scrollEnabled == NO) {
            [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
        }
    }
}

@end
