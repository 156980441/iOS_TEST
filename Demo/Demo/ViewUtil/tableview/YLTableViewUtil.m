//
//  YLTableViewUtil.m
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import "YLTableViewUtil.h"

@implementation YLTableViewUtil

+ (UITableView*)getTableView:(UITableViewStyle)style
                   cellClass:(Class)cellClass
                  identifier:(NSString*)identifier {
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    [tableView registerClass:[cellClass class] forCellReuseIdentifier:identifier];
    tableView.tableFooterView = UIView.new; // 去掉 cell 或者 section 的多余线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉 cell 分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.separatorColor = [UIColor grayColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动后让键盘消失
    return tableView;
}

@end
