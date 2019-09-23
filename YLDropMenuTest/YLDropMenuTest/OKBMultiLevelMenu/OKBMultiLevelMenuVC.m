//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelMenuVC.h"
#import "OKBMultiLevelMenuView.h"
#import "OKBMultiLevelMenuTVHeaderView.h"
#import "OKBLabelImageView.h"
#import "OKBMultiLevelMenuNode.h"
#import <Masonry/Masonry.h>

@interface OKBMultiLevelMenuVC () <OKBMultiLevelMenuViewDelegate>
{
    NSInteger _levels;
    OKBMultiLevelMenuNode *_model;
    NSString *_intColonInt;
    NSArray<OKBMultiLevelMenuTVHeaderView *> *_headerViewArr;
}
@property (nonatomic, strong) OKBMultiLevelMenuView *multiLeveldropDownMenuView;

@end

@implementation OKBMultiLevelMenuVC

- (instancetype)initWithMultiLevel:(NSInteger)levels
                levelOfWidthWeight:(nullable NSString *)intColonInt
                  tableViewHeaders:(nonnull NSArray<OKBMultiLevelMenuTVHeaderView *> *)headerViews
                         rootModel:(OKBMultiLevelMenuNode *)model
                             block:(nullable void (^)(OKBMultiLevelMenuNode * _Nonnull))block {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSAssert(levels <= headerViews.count, @"levels must equal to or less than headerViews count");
        _levels = levels;
        _intColonInt = intColonInt;
        _model = model;
        _headerViewArr = headerViews;
        _selectedBlock = [block copy];
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

- (CGFloat)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_headerViewArr objectAtIndex:index].height;
}

- (void)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu didSelectInTableView:(nonnull OKBMultiLevelMenuNode *)model {
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}

- (nullable UIView *)multiLevelMenu:(OKBMultiLevelMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_headerViewArr objectAtIndex:index];
}

#pragma mark -- lazy load

- (OKBMultiLevelMenuView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        OKBMultiLevelMenuView *tmp = [[OKBMultiLevelMenuView alloc] initWithFrame:CGRectZero tableViewNum:_levels widthWeight:_intColonInt];
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