//
//  BottomVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ScrollViewBottomVC.h"

@interface ScrollViewBottomVC () <UIScrollViewDelegate>
{
    BOOL _scrollEnabled;
}
@end

@implementation ScrollViewBottomVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scrollEnabled = NO;
        // 进入置顶通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(acceptMsg:)
                                                     name:kHomeGoTopNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
                make.height.mas_equalTo(self->_tableView.contentSize.height);
            }];
        }
    }
}

#pragma mark - notification

- (void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kHomeGoTopNotification]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"scrollEnabled"];
        if ([canScroll isEqualToString:@"1"]) {
            _scrollEnabled = YES; // 如果滑动到了顶部TableView就能滑动了
            _tableView.showsVerticalScrollIndicator = YES;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_scrollEnabled == NO) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"TableView的偏移量：%f", offsetY);
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomeLeaveTopNotification
                                                            object:nil
                                                          userInfo:@{@"scrollEnabled":@"1"}];
        //        self.tableView.contentOffset = CGPointZero;
        _scrollEnabled = NO; // 如果没有滑动到了顶部TableView就不能滑动了
        _tableView.showsVerticalScrollIndicator = NO;
    }
}

@end
