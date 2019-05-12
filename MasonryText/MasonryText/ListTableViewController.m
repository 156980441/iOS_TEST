//
//  ListTableViewController.m
//  MasonryText
//
//  Created by fanyl on 2019/5/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ListTableViewController.h"

static NSString* identifier = @"cell_identifier";

@interface ListTableViewController ()
@property (nonatomic, strong) NSArray<NSString*> *dataSource;
@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView* tableView = self.tableView;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:identifier];
    tableView.backgroundColor = [UIColor redColor];
    tableView.tableFooterView = UIView.new; // 去掉 cell 或者 section 的多余线
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine; // cell 分割线
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.separatorColor = [UIColor blueColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动后让键盘消失
    
    self.dataSource = @[@"base", @"advance", @"animation"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSString *str = self.dataSource[indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

@end
