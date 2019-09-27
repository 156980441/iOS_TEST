//
//  OKBMultiLevelDropDownMenuVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListVC.h"

#import "OKBMenuItemView.h"
#import "OKBMenuViewController.h"

#import "OKBMultiLevelListView.h"
#import "OKBLabelImageView.h"

#import "OKBMultiLevelListNode.h"
#import "OKBMultiLevelListColumnConfig.h"

#import <Masonry/Masonry.h>


@interface OKBMultiLevelListVC () <OKBMultiLevelMenuViewDelegate>
{
    OKBMultiLevelListNode *_model;
    NSArray<OKBMultiLevelListColumnConfig *> *_configs;
    OKBMenuItemView *_menuItemView;
}
@property (nonatomic, strong) OKBMultiLevelListView *multiLevelListView;

@end

@implementation OKBMultiLevelListVC

- (instancetype)initWithConfigs:(NSArray<OKBMultiLevelListColumnConfig *> *)configs
                     rootModel:(OKBMultiLevelListNode *)model {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _model = model;
        _configs = configs;
        _menuItemView = [[OKBLabelImageView alloc] init];
        OKBLabelImageView *tmp = (OKBLabelImageView *)_menuItemView;
        tmp.textLbl.text = @"选择";
    }
    return self;
}


- (instancetype)initSingleListWithConfig:(OKBMultiLevelListColumnConfig *)config
                               listNodes:(NSArray<OKBMultiLevelListNode *> *)nodes {
    OKBMultiLevelListNode *root = [OKBMultiLevelListNode defaultRootModel];
    for (OKBMultiLevelListNode *tmp in nodes) {
        [root addChild:tmp];
    }
    return [self initWithConfigs:@[config] rootModel:root];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.multiLevelListView];
    [self.multiLevelListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.multiLevelListView reloadDataWithRootDataSource:_model];
}

- (void)setMultiLevelViewBackgroundColor:(UIColor *)color atIndex:(NSInteger)index {
    NSAssert(index < _configs.count, @"OKBMultiLevelDropDownMenuVC is out of bounds");
    UITableView *tmp = [self.multiLevelListView tableViewAtIndex:index];
    tmp.backgroundColor = color;
}

- (void)setSelectedNode:(OKBMultiLevelListNode *)node {
    [self.multiLevelListView setSelectedNode:node];
}

- (OKBMultiLevelListNode *)rootModel {
    return _model;
}

- (void)updateMenuItemView:(OKBMenuItemView *)menuItemView {
    _menuItemView = menuItemView;
}

- (UITableView *)tableViewAtIndex:(NSInteger)index {
    return [self.multiLevelListView tableViewAtIndex:index];
}

#pragma mark - OKBMultiLevelMenuViewDelegate

- (CGFloat)multiLevelList:(OKBMultiLevelListView *)multiLevelListView heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_configs objectAtIndex:index].headerViewHeight;
}

- (void)multiLevelList:(OKBMultiLevelListView *)multiLevelListView didSelectInTableView:(nonnull OKBMultiLevelListNode *)model {
    [_menuItemView renderMenuItemViewWithUserInfo:model.nodeName];
    
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
    
    [self.menuVC dismissSourceViewWithAnimation:YES];
}

- (nullable UIView *)multiLevelList:(OKBMultiLevelListView *)multiLevelListView viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    return [_configs objectAtIndex:index].columnHeaderView;
}

#pragma mark -- lazy load

- (OKBMultiLevelListView *)multiLevelListView {
    if (!_multiLevelListView) {
        NSMutableString *intColonInt = [NSMutableString string];
        NSMutableArray *cellArr = [NSMutableArray array];
        for (OKBMultiLevelListColumnConfig *config in _configs) {
            
            [cellArr addObject:config.customTVCellClass];
            
            if (config.widthWeight == 0) {
                [intColonInt appendString:@"1"];
            }
            else {
                [intColonInt appendString:[NSString stringWithFormat:@"%ld", config.widthWeight]];
            }
            [intColonInt appendString:@":"];
        }
        [intColonInt deleteCharactersInRange:NSMakeRange(intColonInt.length - 1, 1)];
        
        
        OKBMultiLevelListView *tmp = [[OKBMultiLevelListView alloc] initWithFrame:CGRectZero
                                                                   tableViewCells:cellArr
                                                                      widthWeight:intColonInt];
        tmp.delegate = self;
        _multiLevelListView = tmp;
    }
    return _multiLevelListView;
}


- (OKBMenuItemView *)menuItemView {
    return _menuItemView;
}

- (CGFloat)popViewHeight {
    return 300;
}

@end
