//
//  ViewController.m
//  SearchViewTest
//
//  Created by fanyl on 2019/3/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "YLSearchBar.h"

static inline UIEdgeInsets yl_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

static NSString *identifier = @"cellId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIEdgeInsets insets = yl_safeAreaInset(self.view);
    
    YLSearchBar *searchBar = [[YLSearchBar alloc] initWithFrame:CGRectMake(0, insets.top, CGRectGetWidth(self.view.frame), 50)];
    searchBar.nightMode = YES;
    [self.view addSubview:searchBar];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    tableView.backgroundColor = [UIColor grayColor];; // 背景黑夜模式白色
    tableView.tableFooterView = UIView.new; // 去掉 cell 或者 section 的多余线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉 cell 分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.separatorColor = [UIColor yellowColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动后让键盘消失
    tableView.frame = CGRectMake(0, searchBar.frame.origin.y + CGRectGetHeight(searchBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.dataSource = @[@"Jerry", @"Tom"];
}


#pragma mark -- UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

@end
