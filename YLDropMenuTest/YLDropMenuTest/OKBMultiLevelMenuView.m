//
//  OKBMultiLevelDropDownMenuView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuView.h"
#import "OKB1LabelTVCell.h"
#import <Masonry/Masonry.h>

@interface OKBMultiLevelMenuView () <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _tableViewNum;
    id<OKBMultiLevelMenuProtocol> _dataSource;
    NSInteger _selectedRow[3];
    NSArray<NSString *> *_widthWeightArr;
}
@property (nonatomic, strong) NSArray<UITableView *> *tableViewArr;

@end

@implementation OKBMultiLevelMenuView

- (instancetype)initWithFrame:(CGRect)frame
                 tableViewNum:(NSInteger)num
                  widthWeight:(nullable NSString *)intColonInt {
    NSAssert(num < 4, @"OKBMultiLevelDropDownMenuView support 3 table views at most");
    
    self = [super initWithFrame:frame];
    if (self) {
        _tableViewNum = num;
        if (intColonInt) {
            NSArray<NSString *> *arr = [intColonInt componentsSeparatedByString:@":"];
            NSAssert(arr.count == num, @"OKBMultiLevelDropDownMenuView init parameter error");
            _widthWeightArr = arr;
        }
        [self p_resetSelectedRow];
        [self p_setupUI];
        [self p_layoutUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)p_resetSelectedRow {
    memset(_selectedRow, 0, 3);
}

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    NSAssert(index < _tableViewNum, @"The tableview is out of bounds");
    return [_tableViewArr objectAtIndex:index];
}

- (void)p_layoutUI {
    UITableView *cursor = self.tableViewArr.firstObject;
    NSArray<NSString *> *arr = _widthWeightArr;
    NSNumber *sum = [arr valueForKeyPath:@"@sum.doubleValue"];
    [cursor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.top.equalTo(self);
        if (sum.integerValue != 0) {
            make.width.equalTo(self.mas_width).multipliedBy(arr.firstObject.integerValue / sum.doubleValue); // 强转成 double
        }
    }];
    
    for (int i = 1; i < _tableViewNum; i++) {
        UITableView *tmp = _tableViewArr[i];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cursor.mas_right);
            make.bottom.top.equalTo(self);
            if (sum.integerValue != 0) {
                make.width.equalTo(self.mas_width).multipliedBy(arr[i].integerValue / sum.doubleValue);
            }
            else {
                make.width.equalTo(cursor);
            }
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

- (void)p_saveSelectedRow {
    __weak typeof(self) weak_self = self;
    [_tableViewArr enumerateObjectsUsingBlock:^(UITableView *tableView, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(self) strong_self = weak_self;
        strong_self->_selectedRow[idx] = tableView.indexPathForSelectedRow.row;
    }];
}

- (void)p_loadSelectedRow {
    __weak typeof(self) weak_self = self;
    [self.tableViewArr enumerateObjectsUsingBlock:^(UITableView *tableView, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(self) strong_self = weak_self;
        [tableView reloadData]; // 好奇怪，和下面的代码不能颠倒位置
        [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:strong_self->_selectedRow[idx] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }];
}

- (void)reloadDataWithRootDataSource:(id<OKBMultiLevelMenuProtocol>)rootDataSource {
    _dataSource = rootDataSource;
    [self p_resetSelectedRow];
    [self p_loadSelectedRow];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(multiLevelMenu:heightForHeaderInTableView:atIndex:)]) {
        NSInteger index = [_tableViewArr indexOfObject:tableView];
        height = [self.delegate multiLevelMenu:self heightForHeaderInTableView:tableView atIndex:index];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [_tableViewArr indexOfObject:tableView];
    for (NSInteger i = index + 1; i < _tableViewNum; i++) {
        UITableView *nextTV = [_tableViewArr objectAtIndex:i];
        _selectedRow[i] = 0;
        [nextTV reloadData];
        [nextTV selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedRow[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    [self p_saveSelectedRow];
    
    if (tableView == _tableViewArr.lastObject) {
        if ([self.delegate respondsToSelector:@selector(multiLevelMenu:didSelectInTableView:)]) {
            id<OKBMultiLevelMenuProtocol> model = nil;
            if (_tableViewNum == 1) {
                model = _dataSource.array[indexPath.row];
            } else if (_tableViewNum == 2) {
               NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
                    NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[firstSelectRow].array;
                    model = arr[indexPath.row];
            } else if (_tableViewNum == 3) {
                
                NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
                NSInteger secondSelectRow = _tableViewArr[1].indexPathForSelectedRow.row;
                
                NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[firstSelectRow].array;
                NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[secondSelectRow].array;
                model = arrLevel3[indexPath.row];
            }
            [self.delegate multiLevelMenu:self didSelectInTableView:model];
        }
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = nil;
    if ([self.delegate respondsToSelector:@selector(multiLevelMenu:viewForHeaderInTableView:atIndex:)]) {
        NSInteger index = [_tableViewArr indexOfObject:tableView];
        view = [self.delegate multiLevelMenu:self viewForHeaderInTableView:tableView atIndex:index];
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
    } else if (_tableViewNum == 3) {
        
        if (tableView == _tableViewArr[0]) {
            count = _dataSource.array.count;
        }
        else if (tableView == _tableViewArr[1]) {
            NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[firstSelectRow].array;
            count = arr.count;
        }
        else if (tableView == _tableViewArr[2]) {
            NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
            NSInteger secondSelectRow = _tableViewArr[1].indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[firstSelectRow].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[secondSelectRow].array;
            count = arrLevel3.count;
        }
    }
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OKB1LabelTVCell *cell = [tableView dequeueReusableCellWithIdentifier:g_1LabelViewTVCellId forIndexPath:indexPath];
    if (_tableViewNum == 1) {
        cell.innerLbl.text = _dataSource.array[indexPath.row].nodeName;
    } else if (_tableViewNum == 2) {
        if (tableView == _tableViewArr[0]) {
            cell.innerLbl.text = _dataSource.array[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[1]) {
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[0].array;
            cell.innerLbl.text = arr[indexPath.row].nodeName;
        }
    } else if (_tableViewNum == 3) {
        
        if (tableView == _tableViewArr[0]) {
            cell.innerLbl.text = _dataSource.array[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[1]) {
            NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arr = _dataSource.array[firstSelectRow].array;
            cell.innerLbl.text = arr[indexPath.row].nodeName;
        }
        else if (tableView == _tableViewArr[2]) {
            
            NSInteger firstSelectRow = _tableViewArr[0].indexPathForSelectedRow.row;
            NSInteger secondSelectRow = _tableViewArr[1].indexPathForSelectedRow.row;
            
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel2 = _dataSource.array[firstSelectRow].array;
            NSArray<id<OKBMultiLevelMenuProtocol>> *arrLevel3 = arrLevel2[secondSelectRow].array;
            cell.innerLbl.text = arrLevel3[indexPath.row].nodeName;
        }
    }
    
    return cell;
}

- (NSArray<UITableView *> *)tableViewArr {
    if (!_tableViewArr) {
        NSMutableArray *arr = NSMutableArray.new;
        for (int i = 0; i < _tableViewNum; i++) {
            UITableView *tmp = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tmp.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tmp registerClass:OKB1LabelTVCell.class forCellReuseIdentifier:g_1LabelViewTVCellId];
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
