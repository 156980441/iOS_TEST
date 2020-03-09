//
//  FoldTableViewCtrler.m
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/6.
//  Copyright © 2020 fanyl. All rights reserved.
//

/*
 知识点：
 早期的操作系统是16位系统，
 int用2字节表示，范围是-32768~32767；
 long用4字节表示，范围是-2147483648~2147483647。
 后来发展到32位操作系统，
 int 用4字节表示，与long相同。
 目前的操作系统已发展到64位操作系统，但因程序编译工艺的不同，两者表现出不同的差别：
 32位编译系统：int占4字节，与long相同。
 64位编译系统：int占4字节，long占8字节，long数据范围变为：-2^63~2^63-1
 **/

#import "FoldTableViewCtrler.h"

@implementation FoldTableViewDataSource
@end

@implementation FoldTableViewCtrlerParams
@end

@interface FoldTableViewCtrler () <UITableViewDelegate, UITableViewDataSource> {
    FoldTableViewCtrlerParams *_params;
    BOOL *_status; // YES 打开
}
@end

@implementation FoldTableViewCtrler

- (instancetype)initWithParams:(FoldTableViewCtrlerParams *)params {
    self = [super init];
    if (self) {
        _params = params;
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:params.style];
        for (FoldTableViewDataSource *tmp in _params.dataSource) {
            [_tableView registerClass:tmp.cellClass forCellReuseIdentifier:tmp.cellId];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        unsigned long num = _params.dataSource.count;
        _status = malloc(sizeof(BOOL) * num);
        memset(_status, 0, num);
        
        _tableView.tableFooterView = UIView.new; // 在 _status 之前会崩溃
    }
    return self;
}

- (instancetype)init {
    FoldTableViewCtrlerParams *params = [[FoldTableViewCtrlerParams alloc] init];
    params.dataSource = nil;
    params.style = UITableViewCellStyleSubtitle;
    return [self initWithParams:params];
}

- (void)dealloc {
    free(_status);
    _status = NULL;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _params.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

/// 如果不写以下两个方法会有默认值造成headerView之间有间隙

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

///

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = _params.dataSource[section].sectionView;
    view.tag = section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_sectionAction:)];
    [view addGestureRecognizer:tap];
    return view;
}

- (void)p_sectionAction:(UITapGestureRecognizer *)sender {
    UIView<SectionHeaderViewProtocol> *view = (UIView<SectionHeaderViewProtocol> *)sender.view;
    NSInteger section = view.tag;
    _status[section] = !_status[section];
    [view setHighlight:_status[section]];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [_tableView reloadSections:indexSet
              withRowAnimation:UITableViewRowAnimationFade];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    BOOL open = _status[section];
    // 关闭显示为0行
    if (open == YES) {
        num = _params.dataSource[section].items.count;
    }
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldTableViewDataSource *tmp = _params.dataSource[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tmp.cellId forIndexPath:indexPath];
    tmp.renderCell(cell, indexPath, tmp.dataType);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoldTableViewDataSource *tmp = _params.dataSource[indexPath.section];
    id item = tmp.items[indexPath.row];
    tmp.didSelectRow(item);
}

@end
