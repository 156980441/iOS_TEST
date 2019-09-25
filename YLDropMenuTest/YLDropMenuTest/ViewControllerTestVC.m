//
//  ViewControllerTestVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewControllerTestVC.h"

#import "OKBMenuView.h"
#import "OKBMenuItemView.h"
#import "OKBMultiLevelListView.h"
#import "OKBMultiLevelListColumnHeaderView.h"
#import "OKBMultiLevelListLabelTVHeader.h"
#import "OKBMultiLevelListBaseTVCell.h"

#import "OKBMultiLevelListNode.h"

#import "OKBMenuViewController.h"
#import "OKBMultiLevelListVC.h"

#import "DataSourceFactory.h"
#import "OKBLabelImageView.h"
#import "PersonModel.h"

#import <Masonry/Masonry.h>

@interface ViewControllerTestVC ()
@property (nonatomic, strong) OKBMenuViewController *menuVC;
@end

@implementation ViewControllerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.menuVC];
    [self.view addSubview:self.menuVC.view];
    [self didMoveToParentViewController:self];
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(88);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.menuVC dismissSourceViewWithAnimation:YES];
    self.menuVC = nil;
}

- (OKBMenuViewController *)menuVC {
    if (!_menuVC) {
        // 一级
        
        // 一级列 header
        OKBMultiLevelListLabelTVHeader *header01 = OKBMultiLevelListLabelTVHeader.new;
        header01.textLbl.text = @"姓名";
        
        // 一级列宽比例，列头视图，列内 cell 样式配置
        OKBMultiLevelListColumnConfig *config01 = [[OKBMultiLevelListColumnConfig alloc] init];
        config01.widthWeight = 0;
        config01.columnHeaderView = header01;
        config01.customTVCellClass = OKBMultiLevelListBaseTVCell.class;
        
        // 初始化一级下拉列表
        OKBMultiLevelListVC *vc01 = [[OKBMultiLevelListVC alloc] initWithConfig:@[config01] rootModel:[DataSourceFactory level1DataSource] block:nil];
        
        // 便捷方法初始化一级
        OKBMultiLevelListLabelTVHeader *header00 = OKBMultiLevelListLabelTVHeader.new;
        header00.textLbl.text = @"姓名";
        
        OKBMultiLevelListColumnConfig *config00 = [[OKBMultiLevelListColumnConfig alloc] init];
        config00.widthWeight = 0;
        config00.columnHeaderView = header00;
        config00.customTVCellClass = OKBMultiLevelListBaseTVCell.class;
        
        OKBMultiLevelListVC *vc00 = [[OKBMultiLevelListVC alloc] initSingleListWithConfig:config00 listNodes:[DataSourceFactory level1DataSource].childNodes block:nil];
        
        
        // 二级
        OKBMultiLevelListLabelTVHeader *header02 = OKBMultiLevelListLabelTVHeader.new;
        header02.textLbl.text = @"地域";
        
        OKBMultiLevelListColumnConfig *config02 = [[OKBMultiLevelListColumnConfig alloc] init];
        config02.widthWeight = 1;
        config02.columnHeaderView = nil;
        config02.customTVCellClass = OKBMultiLevelListBaseTVCell.class;
        
        OKBMultiLevelListColumnConfig *config03 = [[OKBMultiLevelListColumnConfig alloc] init];
        config03.widthWeight = 2;
        config03.columnHeaderView = header02;
        config03.customTVCellClass = OKBMultiLevelListBaseTVCell.class;
        
        
        OKBMultiLevelListVC *vc02 = [[OKBMultiLevelListVC alloc] initWithConfig:@[config02, config03] rootModel:[DataSourceFactory level2DataSource] block:nil];
        
        [vc02 setMultiLevelViewBackgroundColor:[UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1] atIndex:0];
        
        // 将一级，二级列表插入菜单，成为下拉视图
        OKBMenuViewController *tmp = [[OKBMenuViewController alloc] initWithMenuItemControllers:@[vc00, vc01, vc02]];
        vc01.selectedBlock = ^(OKBMultiLevelListNode *model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        vc02.selectedBlock = ^(OKBMultiLevelListNode *model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        
        _menuVC = tmp;
    }
    return _menuVC;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
