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
    NSInteger _selectedRow[3];
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

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    NSAssert(index < _tableViewNum, @"Tableview do not exist.");
    return [_tableViewArr objectAtIndex:index];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(multiLevelDropDownMenu:heightForHeaderInTableView:atIndex:)]) {
        NSInteger index = [_tableViewArr indexOfObject:tableView];
        height = [self.delegate multiLevelDropDownMenu:self heightForHeaderInTableView:tableView atIndex:index];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(multiLevelDropDownMenu:didSelectInTableView:atIndex:row:)]) {
        NSInteger index = [_tableViewArr indexOfObject:tableView];
        for (NSInteger i = index + 1; i < _tableViewNum; i++) {
            [[_tableViewArr objectAtIndex:i] reloadData];
        }
        [self.delegate multiLevelDropDownMenu:self didSelectInTableView:tableView atIndex:index row:indexPath.row];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = nil;
    if ([self.delegate respondsToSelector:@selector(multiLevelDropDownMenu:viewForHeaderInTableView:atIndex:)]) {
        NSInteger index = [_tableViewArr indexOfObject:tableView];
        view = [self.delegate multiLevelDropDownMenu:self viewForHeaderInTableView:tableView atIndex:index];
    }
    return view;
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
            NSInteger firstSelectRow = ((UITableView *)_tableViewArr[0]).indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[firstSelectRow].array;
            count = arr.count;
        }
        else if (tableView == _tableViewArr[2]) {
            NSInteger firstSelectRow = ((UITableView *)_tableViewArr[0]).indexPathForSelectedRow.row;
            NSInteger secondSelectRow = ((UITableView *)_tableViewArr[1]).indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[firstSelectRow].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[secondSelectRow].array;
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
            NSInteger firstSelectRow = ((UITableView *)_tableViewArr[0]).indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[firstSelectRow].array;
            cell.textLabel.text = arr[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[2]) {
            
            NSInteger firstSelectRow = ((UITableView *)_tableViewArr[0]).indexPathForSelectedRow.row;
            NSInteger secondSelectRow = ((UITableView *)_tableViewArr[1]).indexPathForSelectedRow.row;
            
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[firstSelectRow].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[secondSelectRow].array;
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
            tmp.rowHeight = 44.0f; // 默认高度
            [arr addObject:tmp];
        }
        _tableViewArr = [NSArray arrayWithArray:arr];
    }
    return _tableViewArr;
}

@end
