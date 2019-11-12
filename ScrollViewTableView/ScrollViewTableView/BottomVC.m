//
//  BottomVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "BottomVC.h"
#import "Masonry.h"

@interface BottomVC () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    BOOL _scrollEnabled;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BottomVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _scrollEnabled = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor greenColor];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"CELL"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView addObserver:self
                     forKeyPath:@"contentSize"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                        context:NULL];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
        
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
                make.height.mas_equalTo(self.tableView.contentSize.height);
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
            self.tableView.showsVerticalScrollIndicator = YES;
        }
    }
    else if ([notificationName isEqualToString:kHomeLeaveTopNotification]) {
//        self.tableView.contentOffset = CGPointZero;
        _scrollEnabled = NO; // 如果没有滑动到了顶部TableView就不能滑动了
        self.tableView.showsVerticalScrollIndicator = NO;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_scrollEnabled == NO) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"TableView的偏移量：%f", offsetY);
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomeLeaveTopNotification
                                                            object:nil
                                                          userInfo:@{@"scrollEnabled":@"1"}];
    }
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
    return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.text = @"我要吸顶";
    return tmp;
}

@end
