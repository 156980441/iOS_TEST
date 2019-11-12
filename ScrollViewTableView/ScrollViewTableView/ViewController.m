//
//  ViewController.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/10/29.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "LeftVC.h"
#import "RightVC.h"
#import "Masonry.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    BOOL _scrollEnabled;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LeftVC *leftVC;
@property (nonatomic, strong) RightVC *rightVC;

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 背景橘黄
        // scrollView 蓝色
        // 容器视图灰色
        // tableview 绿色
        // 子控制器左边黄色
        // 子控制器左边红色
        self.view.backgroundColor = [UIColor orangeColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor greenColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CELL"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView addObserver:self
                     forKeyPath:@"contentSize"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:NULL];
        
        [wrapper addSubview:_tableView]; // 相关视图放入容器
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
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftVC.view.mas_bottom);
            make.left.right.equalTo(wrapper);
            make.height.equalTo(@0);
        }];
        
        [wrapper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.tableView.mas_bottom);
        }];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"] && object == _tableView) {
        CGSize oldSize, newSize;
        [change[@"new"] getValue:&newSize];
        [change[@"old"] getValue:&oldSize];
        if (oldSize.height != newSize.height) {
            [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.tableView.contentSize.height);
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = @"TEST";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.text = @"我要吸顶";
    return tmp;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"scrollView的偏移量：===%f", contentOffsetY);
    CGFloat maxOffsetY = 200 - 64;  // 简单的代码，没有适配 iphoneX
    if (contentOffsetY > maxOffsetY) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)]; // 设置最大偏移
        [[NSNotificationCenter defaultCenter] postNotificationName:@"contentCanMove" object:nil]; // 告诉底部      内容视图能进行滑动了
        _scrollEnabled = NO;   // 自己不能滑动了
    }
    if (_scrollEnabled == NO) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
    }
}

@end
