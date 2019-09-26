//
//  ViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

#import "ViewTestVC.h"
#import "ViewControllerTestVC.h"

#import <Masonry/Masonry.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    ViewControllerTestVC *_vc2;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, UIViewController *> *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Demo";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    _vc2 = [[ViewControllerTestVC alloc] initWithNibName:nil bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ViewTestVC *vc = [[ViewTestVC alloc] initWithNibName:nil bundle:nil];
    

    self.dataSource = @[@{@"View 形式调用" : vc}, @{@"ViewController 形式调用" : _vc2}];
    
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
