//
//  ViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "OKBMenuView.h"
#import "OKBMenuItemView.h"
#import "LabelImageView.h"
#import "PersonModel.h"
#import "OKBMultiLevelDropDownMenuView.h"
#import "OKBMultiLevelDropDownMenuRootModel.h"
#import <Masonry/Masonry.h>
#import "DataSourceFactory.h"

#import "OKBMenuViewController.h"
#import "OKBMultiLevelDropDownMenuVC.h"

#import "ViewTestVC.h"
#import "ViewControllerTestVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, UIViewController *> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Demo";
    
    ViewTestVC *vc = [[ViewTestVC alloc] initWithNibName:nil bundle:nil];
    ViewControllerTestVC *vc2 = [[ViewControllerTestVC alloc] initWithNibName:nil bundle:nil];
    ViewControllerTestVC *vc3 = [[ViewControllerTestVC alloc] initWithNibName:nil bundle:nil];
    self.dataSource = @[@{@"View" : vc}, @{@"Controller" : vc2}, @{@"控件" : vc3}];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row].allKeys.firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary<NSString *, UIViewController *> *dic = (NSDictionary *)self.dataSource[indexPath.row];
    [self.navigationController pushViewController:dic.allValues.firstObject animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tmp = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tmp registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        tmp.dataSource = self;
        tmp.delegate = self;
        _tableView = tmp;
    }
    return _tableView;
}

@end
