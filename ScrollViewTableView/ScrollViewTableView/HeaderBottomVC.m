//
//  BottomVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "HeaderBottomVC.h"

@interface HeaderBottomVC () <UIScrollViewDelegate>
{
    UIView *_headerView;
}
@end

@implementation HeaderBottomVC

- (void)setHeaderView:(UIView *)view {
    _headerView = view;
    _tableView.tableHeaderView = view; // 必须每次重新赋值
    
    [_tableView setNeedsLayout]; // 标记刷新
    [_tableView layoutIfNeeded]; // 使布局立即生效
}

@end
