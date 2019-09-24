//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListVC.h"
#import "OKBMultiLevelListView.h"
#import "OKBMultiLevelListTVHeaderView.h"
#import "OKBLabelImageView.h"
#import "OKBMultiLevelListNode.h"
#import <Masonry/Masonry.h>

@implementation OKBMultiLevelMenuViewConfig
@end

@interface OKBMultiLevelListVC () <OKBMultiLevelMenuViewDelegate>
{
    NSInteger _levels;
    OKBMultiLevelListNode *_model;
    NSString *_intColonInt;
    NSArray<OKBMultiLevelListTVHeaderView *> *_headerViewArr;
    OKBMultiLevelMenuViewConfig *_config;
}
@property (nonatomic, strong) OKBMultiLevelListView *multiLeveldropDownMenuView;

@end

@implementation OKBMultiLevelListVC

- (instancetype)initWithConfig:(OKBMultiLevelMenuViewConfig *)config
                     rootModel:(OKBMultiLevelListNode *)model
                         block:(nullable void (^)(OKBMultiLevelListNode *model))block {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSAssert(config.level <= config.headerViews.count, @"levels must equal to or less than headerViews count");
        _levels = config.level;
        _intColonInt = config.widthWeight;
        _model = model;
        _headerViewArr = config.headerViews;
        _selectedBlock = [block copy];
        _config = config;
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
    NSAssert(index < _levels, @"OKBMultiLevelDropDownMenuVC is out of bounds");
    UITableView *tmp = [self.multiLeveldropDownMenuView tableViewAtIndex:index];
    tmp.backgroundColor = color;
}

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    return [self.multiLeveldropDownMenuView tableViewAtIndex:index];
}

#pragma mark - OKBMultiLevelMenuViewDelegate

- (CGFloat)multiLevelList:(OKBMultiLevelListView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_headerViewArr objectAtIndex:index].height;
}

- (void)multiLevelList:(OKBMultiLevelListView *)dropDownMenu didSelectInTableView:(nonnull OKBMultiLevelListNode *)model {
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}

- (nullable UIView *)multiLevelList:(OKBMultiLevelListView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_headerViewArr objectAtIndex:index];
}

#pragma mark -- lazy load

- (OKBMultiLevelListView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        OKBMultiLevelListView *tmp = [[OKBMultiLevelListView alloc] initWithFrame:CGRectZero tableViewNum:_levels widthWeight:_intColonInt];
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
