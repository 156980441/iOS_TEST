//
//  OKBMultiLevelDropDownMenuView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelDropDownMenuView.h"
#import <Masonry/Masonry.h>

@interface OKBMultiLevelDropDownMenuView () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _tableViewNum;
    id<OKBMultiLevelMenuProtocol> _dataSource;
}
@property (nonatomic, strong) NSArray<UITableView *> *tableViewArr;

@end

@implementation OKBMultiLevelDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num {
    self = [super initWithFrame:frame];
    if (self) {
        _tableViewNum = num;
        
        [self p_setupUI];
        [self p_layoutUI];
    }
    return self;
}

- (void)p_layoutUI {
    UITableView *cursor = self.tableViewArr.firstObject;
    [cursor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.top.equalTo(self);
    }];
    
    for (int i = 1; i < _tableViewNum; i++) {
        UITableView *tmp = _tableViewArr[i];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cursor.mas_right);
            make.bottom.top.equalTo(self);
            make.width.equalTo(cursor);
        }];
        cursor = tmp;
    }
    
    [cursor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}

- (void)p_setupUI {
    for (UITableView *tmp in self.tableViewArr) {
        [self addSubview:tmp];
    }
}

- (void)reloadDataWithDataSource:(id<OKBMultiLevelMenuProtocol>)dataSource {
    _dataSource = dataSource;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    if (_tableViewNum == 1) {
        count = _dataSource.array.count;
    } else if (_tableViewNum == 2) {
        if (tableView == _tableViewArr[0]) {
            count = _dataSource.array.count;
        }
        else if (tableView == _tableViewArr[1]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[0].array;
            count = arr.count;
        }
    } else if (_tableViewNum == 3){
        
        if (tableView == _tableViewArr[0]) {
            count = _dataSource.array.count;
        }
        else if (tableView == _tableViewArr[1]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[0].array;
            count = arr.count;
        }
        else if (tableView == _tableViewArr[2]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[0].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[0].array;
            count = arrLevel3.count;
        }
    }
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    if (_tableViewNum == 1) {
        cell.textLabel.text = _dataSource.array[indexPath.row].nodeName;
    } else if (_tableViewNum == 2) {
        if (tableView == _tableViewArr[0]) {
            cell.textLabel.text = _dataSource.array[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[1]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[0].array;
            cell.textLabel.text = arr[indexPath.row].nodeName;
        }
    } else if (_tableViewNum == 3) {
        
        if (tableView == _tableViewArr[0]) {
            cell.textLabel.text = _dataSource.array[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[1]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[0].array;
            cell.textLabel.text = arr[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[2]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[0].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[0].array;
            cell.textLabel.text = arrLevel3[indexPath.row].nodeName;
        }
    }
    
    
    return cell;
    
    
}

- (NSArray<UITableView *> *)tableViewArr {
    if (!_tableViewArr) {
        NSMutableArray *arr = NSMutableArray.new;
        for (int i = 0; i < _tableViewNum; i++) {
            UITableView *tmp = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [tmp registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
            tmp.dataSource = self;
            tmp.delegate = self;
            tmp.rowHeight = 44.0f;
            [arr addObject:tmp];
        }
        _tableViewArr = [NSArray arrayWithArray:arr];
    }
    return _tableViewArr;
}

@end
