//
//  ViewController.m
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/6.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "Currency.h"
#import "CurrencyPair.h"

#import "MJExtension.h"

#import "FoldTableViewCtrler.h"

#import "SelectTVCell.h"
#import "SectionHeaderView.h"

@interface ViewController ()
{
    NSArray<Currency *> *_currencies;
    NSArray<CurrencyPair *> *_currencyPairs;
    FoldTableViewCtrler *_ctrler;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadFile];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (Currency *c in _currencies) {
        FoldTableViewDataSource *dataSource = [[FoldTableViewDataSource alloc] init];
        dataSource.cellClass = [SelectTVCell class];
        SectionHeaderView *headerView = [[SectionHeaderView alloc] initWithFrame:CGRectZero];
        headerView.label.text = c.groupName;
        dataSource.sectionView = headerView;
        dataSource.cellId = @"cellId";
        dataSource.dataType = c;
        dataSource.items = c.filterWord;
        dataSource.renderCell = ^(UITableViewCell * _Nonnull cell, NSIndexPath *indexPath, id dataType) {
            SelectTVCell *selectCell = (SelectTVCell *)cell;
            Currency *data = (Currency *)dataType;
            selectCell.label.text = [data.filterWord objectAtIndex:indexPath.row];
        };
        dataSource.didSelectRow = ^(NSString *item) {
            NSLog(@"点击了%@", item);
        };
        [arr addObject:dataSource];
    }
    
    FoldTableViewCtrlerParams *params = [[FoldTableViewCtrlerParams alloc] init];
    params.dataSource = arr;
    params.style = UITableViewStyleGrouped;
    
    FoldTableViewCtrler *ctrler = [[FoldTableViewCtrler alloc] initWithParams:params];
    
    [self.view addSubview:ctrler.tableView];
    ctrler.tableView.frame = self.view.frame;
    
    _ctrler = ctrler;
}

// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)loadFile {
    NSDictionary *dic1 = [self readLocalFileWithName:@"tree"];
    NSDictionary *dic2 = [self readLocalFileWithName:@"tree2"];
    
    NSArray<Currency *> *currencies = [Currency mj_objectArrayWithKeyValuesArray:dic1[@"data"]];
    
    NSArray<CurrencyPair *> *currencyPairs = [CurrencyPair mj_objectArrayWithKeyValuesArray:dic2[@"data"]];
    
    _currencies = currencies;
    _currencyPairs = currencyPairs;
    
    [_currencies sortedArrayUsingComparator:^NSComparisonResult(Currency *obj1, Currency *obj2) {
        if (obj1.sort.intValue < obj2.sort.intValue) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
}


@end
