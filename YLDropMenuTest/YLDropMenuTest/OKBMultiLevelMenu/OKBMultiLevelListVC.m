//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListVC.h"
#import "OKBMultiLevelListView.h"
#import "OKBMultiLevelListColumnHeaderView.h"
#import "OKBLabelImageView.h"
#import "OKBMultiLevelListNode.h"
#import <Masonry/Masonry.h>

@implementation OKBMultiLevelListColumnConfig
@end

@interface OKBMultiLevelListVC () <OKBMultiLevelMenuViewDelegate>
{
    OKBMultiLevelListNode *_model;
    NSArray<OKBMultiLevelListColumnConfig *> *_configs;
}
@property (nonatomic, strong) OKBMultiLevelListView *multiLeveldropDownMenuView;

@end

@implementation OKBMultiLevelListVC

- (instancetype)initWithConfig:(NSArray<OKBMultiLevelListColumnConfig *> *)configs
                     rootModel:(OKBMultiLevelListNode *)model
                         block:(nullable void (^)(OKBMultiLevelListNode *model))block {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _model = model;
        _selectedBlock = [block copy];
        _configs = configs;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.multiLeveldropDownMenuView];
    [self.multiLeveldropDownMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.multiLeveldropDownMenuView reloadDataWithRootDataSource:_model];
}

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index {
    NSAssert(index < _configs.count, @"OKBMultiLevelDropDownMenuVC is out of bounds");
    UITableView *tmp = [self.multiLeveldropDownMenuView tableViewAtIndex:index];
    tmp.backgroundColor = color;
}

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    return [self.multiLeveldropDownMenuView tableViewAtIndex:index];
}

#pragma mark - OKBMultiLevelMenuViewDelegate

- (CGFloat)multiLevelList:(OKBMultiLevelListView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_configs objectAtIndex:index].headerViews.height;
}

- (void)multiLevelList:(OKBMultiLevelListView *)dropDownMenu didSelectInTableView:(nonnull OKBMultiLevelListNode *)model {
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}

- (nullable UIView *)multiLevelList:(OKBMultiLevelListView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_configs objectAtIndex:index].headerViews;
}

#pragma mark -- lazy load

- (OKBMultiLevelListView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        NSMutableString *intColonInt = [NSMutableString string];
        NSMutableArray *cellArr = [NSMutableArray array];
        for (OKBMultiLevelListColumnConfig *config in _configs) {
            
            [cellArr addObject:config.customTVCellClass];
            
            if (config.widthWeight == nil) {
                [intColonInt appendString:@"1"];
            }
            else {
                [intColonInt appendString:config.widthWeight];
            }
            [intColonInt appendString:@":"];
        }
        [intColonInt deleteCharactersInRange:NSMakeRange(intColonInt.length - 1, 1)];
        
        
        OKBMultiLevelListView *tmp = [[OKBMultiLevelListView alloc] initWithFrame:CGRectZero
                                                                   tableViewCells:cellArr
                                                                      widthWeight:intColonInt];
        tmp.delegate = self;
        _multiLeveldropDownMenuView = tmp;
    }
    return _multiLeveldropDownMenuView;
}

- (CGFloat)soureViewHeight {
    return 200.f;
}

- (OKBMenuItemView *)menuItemView {
    if (!_menuItemView) {
        OKBLabelImageView *tmp = [[OKBLabelImageView alloc] initWithFrame:CGRectZero];
        tmp.textLbl.text = @"选择";
        _menuItemView = tmp;
    }
    return _menuItemView;
    
}

@end
