//
//  ViewController.m
//  SearchViewTest
//
//  Created by fanyl on 2019/3/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "YLSearchBar.h"
#import <Masonry/Masonry.h>

#define YLRandColor [UIColor colorWithRed:arc4random() % 255 / 255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]

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
    
    self.view.backgroundColor = YLRandColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIEdgeInsets insets = yl_safeAreaInset(self.view);
    
    YLSearchBar *searchBar = [[YLSearchBar alloc] initWithFrame:CGRectZero];
    searchBar.backgroundColor = YLRandColor;
    searchBar.searchBarTF.backgroundColor = YLRandColor;
    searchBar.cancel.backgroundColor = YLRandColor;
    searchBar.nightMode = NO;
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.height.mas_equalTo(44);
        }
        else {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(44);
        }
    }];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    tableView.backgroundColor = [UIColor grayColor];
    tableView.tableFooterView = UIView.new; // 去掉 cell 或者 section 的多余线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉 cell 分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    tableView.separatorColor = [UIColor grayColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动后让键盘消失
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(searchBar.mas_bottom).offset(10);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }
        else {
            make.top.equalTo(searchBar.mas_bottom).offset(10);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }
    }];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

@end
