//
//  OKBSV_TVVC.m
//  scrollview_tableview
//
//  Created by fanyl on 2020/12/1.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "OKBSV_TVVC.h"
#import "OKBNestedScrollView.h"

@interface OKBSV_TVVC ()  <UITableViewDelegate, UITableViewDataSource>
{
    OKBNestedScrollView *_scrollView;
    UIView *_headerView;
    UIView *_centerView;
    UITableView *_bottomTV;
    
    NSArray<NSString *> *_dataSource;
    
    // 首先加一个手势，阻断 UITableView 自身的手势
    UIPanGestureRecognizer *_pan;
    // 其次知道阈值，即 UIScrollView 可以滑动还是 UITableView 可以滑动的临界点
    CGFloat _threshhold;
}
@end

@implementation OKBSV_TVVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView = [[OKBNestedScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _bottomTV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _centerView = [[UIView alloc] initWithFrame:CGRectZero];
    _headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _headerView.backgroundColor = [UIColor redColor];
    _centerView.backgroundColor = [UIColor yellowColor];
    
    [_scrollView addSubview:_bottomTV];
    [_scrollView addSubview:_centerView];
    [_scrollView addSubview:_headerView];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 100; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    _dataSource = [NSArray arrayWithArray:arr];
    
    _bottomTV.delegate = self;
    _bottomTV.dataSource = self;
    [_bottomTV registerClass:UITableViewCell.class forCellReuseIdentifier:@"id"];
    
    // 1、这里加手势的目的是拦截 tableview 控件自带手势
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_pan:)];
    [_bottomTV addGestureRecognizer:_pan];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = CGRectGetHeight(self.view.frame);
    _scrollView.frame = CGRectMake(0, 0, w, h);
    _headerView.frame = CGRectMake(0, 0, w, 500);
    _centerView.frame = CGRectMake(CGRectGetMinX(_headerView.frame), CGRectGetMaxY(_headerView.frame), CGRectGetWidth(_headerView.frame), 60);
    _bottomTV.frame = CGRectMake(CGRectGetMinX(_centerView.frame), CGRectGetMaxY(_centerView.frame), CGRectGetWidth(_centerView.frame), 800);
    
    _scrollView.contentSize = CGSizeMake(w, CGRectGetHeight(_headerView.frame) + CGRectGetHeight(_centerView.frame) + CGRectGetHeight(_bottomTV.frame));
    
    CGFloat offset = _scrollView.contentOffset.y;
    if (offset < 0) {
        offset = -offset; // 转成正数
    }
    _threshhold = CGRectGetMaxY(_headerView.frame) - offset;
    NSLog(@"最初的 scrollview offset %f，以及阈值 %f", _scrollView.contentOffset.y, _threshhold);
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat svOffset = _scrollView.contentOffset.y;
    CGFloat tvOffset = _bottomTV.contentOffset.y;
    NSLog(@"threshhold %f, sv offset %f, tv offset %f", _threshhold, svOffset, tvOffset);
    
    if (_scrollView == scrollView) {
        if (_pan.enabled) {
            
        } else {
            _scrollView.contentOffset = CGPointMake(0, _threshhold);
        }
    }
    else if (_bottomTV == scrollView) {
        if (_bottomTV.contentOffset.y <= 0) {
            _pan.enabled = YES;
            _scrollView.scrollEnabled = YES;
        }
    }
}

- (void)p_pan:(UIPanGestureRecognizer *)pan {
    CGFloat svOffset = _scrollView.contentOffset.y;
    // 如果 scrollview 的偏移量小于阈值，则 tableview 设置 contentOffset 使 tableview 始终不滑动
    if (svOffset < _threshhold) {
        _bottomTV.contentOffset = CGPointZero;
    }
    // 如果 scrollview 的偏移量大于等于阈值，则 tableview 关闭手势，启用自带手势，同时关闭 scrollview 的滑动
    else {
        _pan.enabled = NO;
        _scrollView.scrollEnabled = NO;
    }
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

@end
