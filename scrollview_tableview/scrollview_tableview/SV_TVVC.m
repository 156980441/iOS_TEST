//
//  SV_TVVC.m
//  scrollview_tableview
//
//  Created by fanyl on 2020/12/1.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "SV_TVVC.h"

@interface SV_TVVC ()  <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
{
    UIScrollView *_scrollView;
       UIView *_headerView;
       UIView *_centerView;
       UITableView *_bottomTV;
       
       NSArray<NSString *> *_dataSource;
       
       BOOL _scrollViewCanScroll;
       BOOL _tableViewCanScroll;
       
       CGFloat _currOffsetY;
       
       CGFloat _dragCriticalY;
       CGFloat _lastPositionY;
}
@end

@implementation SV_TVVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//    _scrollView.panGestureRecognizer.delegate = self;
    _scrollView.delegate = self;
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
//    _bottomTV.panGestureRecognizer.delegate = self;
    _bottomTV.dataSource = self;
    [_bottomTV registerClass:UITableViewCell.class forCellReuseIdentifier:@"id"];
    
    _bottomTV.panGestureRecognizer.cancelsTouchesInView = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
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
}

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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _bottomTV) {
        _currOffsetY = scrollView.contentOffset.y;
    }
    if (scrollView == _scrollView) {
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _scrollView) {
        
        
        
        
        CGFloat currentPostion = scrollView.contentOffset.y;
        /*
         当 底层滚动式图滚动到指定位置时，
         停止滚动，开始滚动子视图
         */
        if (currentPostion >= _dragCriticalY) {
            scrollView.contentOffset = CGPointMake(0, _dragCriticalY);
            if (_scrollViewCanScroll) {
                _scrollViewCanScroll = NO;
                _tableViewCanScroll = YES;
            }
            else{
                if (_lastPositionY - currentPostion > 0){
                    if (_bottomTV.contentOffset.y > 0) {
                        _tableViewCanScroll = YES;
                        _scrollViewCanScroll = NO;
                    }
                    else {
                        _tableViewCanScroll = NO;
                        _scrollViewCanScroll = YES;
                    }
                }
            }
        }else{
            if (!_scrollViewCanScroll && scrollView.contentOffset.y ==  _dragCriticalY ) {
                scrollView.contentOffset = CGPointMake(0, _dragCriticalY);
            }
            else{
                if (_tableViewCanScroll &&
                    _bottomTV.contentOffset.y != 0) {
                    scrollView.contentOffset = CGPointMake(0, _dragCriticalY);
                }
                else{
                    
                }
            }
        }
        
        _lastPositionY = currentPostion;
        
        
        
        
        
        
        
        
    }
    
    
    if (scrollView == _bottomTV) {
        if (!_tableViewCanScroll) {
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y == 0 ? 0 : _currOffsetY);
        }
        _currOffsetY = scrollView.contentOffset.y;
        if (scrollView.contentOffset.y < 0 ) {
            _tableViewCanScroll = NO;
            scrollView.contentOffset = CGPointZero;
            //         到顶通知父视图改变状态
            
            _scrollViewCanScroll = YES;
            _tableViewCanScroll = NO;
            //        if (self.slideDragBlock) {
            //            self.slideDragBlock();
            //        }
        }
        scrollView.showsVerticalScrollIndicator = _tableViewCanScroll ? YES : NO;
    }
    
}

@end
