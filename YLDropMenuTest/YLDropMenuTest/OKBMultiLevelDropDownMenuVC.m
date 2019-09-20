//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelDropDownMenuVC.h"
#import "OKBMultiLevelDropDownMenuView.h"
#import "OKBMultiLevelDropDownMenuRootModel.h"
#import "OKBLabelImageView.h"
#import <Masonry/Masonry.h>

@interface OKBMultiLevelDropDownMenuVC () <OKBMultiLevelDropDownMenuViewDelegate>
{
    NSInteger _levels;
    OKBMultiLevelDropDownMenuRootModel *_model;
    NSString *_intColonInt;
}
@property (nonatomic, strong) OKBMultiLevelDropDownMenuView *multiLeveldropDownMenuView;

@end

@implementation OKBMultiLevelDropDownMenuVC

- (instancetype)initWithMultiLevel:(NSInteger)levels
                levelOfWidthWeight:(nullable NSString *)intColonInt
                         rootModel:(OKBMultiLevelDropDownMenuRootModel *)model
                             block:(nullable void (^)(id<OKBMultiLevelMenuProtocol> _Nonnull))block {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _levels = levels;
        _intColonInt = intColonInt;
        _model = model;
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

- (void)setMultLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index {
    NSAssert(index < _levels, @"OKBMultiLevelDropDownMenuVC is out of bounds");
    UITableView *tmp = [self.multiLeveldropDownMenuView tableViewAtIndex:index];
    tmp.backgroundColor = color;
}

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    return [self.multiLeveldropDownMenuView tableViewAtIndex:index];
}

#pragma mark - OKBMultiLevelDropDownMenuViewDelegate

- (CGFloat)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return 32;
}

- (void)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu didSelectInTableView:(nonnull id<OKBMultiLevelMenuProtocol>)model {
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}

- (nullable UIView *)multiLevelDropDownMenu:(OKBMultiLevelDropDownMenuView *)dropDownMenu viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:12];
    tmp.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
    tmp.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
    if (index == 0) {
        tmp.text = @"姓名";
    } else if (index == 1) {
        tmp.text = @"班级";
    } else {
        tmp.text = @"学校";
    }
    return tmp;
}

#pragma mark -- lazy load

- (OKBMultiLevelDropDownMenuView *)multiLeveldropDownMenuView {
    if (!_multiLeveldropDownMenuView) {
        OKBMultiLevelDropDownMenuView *tmp = [[OKBMultiLevelDropDownMenuView alloc] initWithFrame:CGRectZero tableViewNum:_levels widthWeight:_intColonInt];
        tmp.delegate = self;
        _multiLeveldropDownMenuView = tmp;
    }
    return _multiLeveldropDownMenuView;
}

- (CGFloat)soureViewHeight {
    return 200.f;
}

- (UIView *)sourceView {
    return self.view;
}

- (OKBMenuItemView *)menuItemView {
    OKBLabelImageView *tmp = [[OKBLabelImageView alloc] initWithFrame:CGRectZero];
    tmp.textLbl.text = @"选择";
    return tmp;
}

@end
