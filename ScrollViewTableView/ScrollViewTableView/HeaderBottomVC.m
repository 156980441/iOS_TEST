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
    _tableView.tableHeaderView = view;
    
    [_tableView setNeedsLayout];
    [_tableView layoutIfNeeded];
}

@end
