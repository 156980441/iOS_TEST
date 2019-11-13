//
//  BottomVC.m
//  ScrollViewTableView
//
//  Created by fanyl on 2019/11/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "BaseBottomVC.h"

@interface BaseBottomVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BaseBottomVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    }
    return self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
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
