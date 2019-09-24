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
        
        OKBMultiLevelListLabelTVHeader *header0 = OKBMultiLevelListLabelTVHeader.new;
        header0.textLbl.text = @"姓名";
        
        OKBMultiLevelListColumnConfig *config0 = [[OKBMultiLevelListColumnConfig alloc] init];
        config0.widthWeight = nil;
        config0.headerViews = header0;
        
        
        OKBMultiLevelListVC *vc1 = [[OKBMultiLevelListVC alloc] initWithConfig:@[config0] rootModel:[DataSourceFactory level1DataSource] block:nil];
        
        
        OKBMultiLevelListLabelTVHeader *header00 = OKBMultiLevelListLabelTVHeader.new;
        header00.textLbl.text = @"姓名";
        OKBMultiLevelListLabelTVHeader *header10 = OKBMultiLevelListLabelTVHeader.new;
        header10.textLbl.text = @"地域";
        
        OKBMultiLevelListColumnConfig *config00 = [[OKBMultiLevelListColumnConfig alloc] init];
        config00.widthWeight = @"1";
        config00.headerViews = header00;
        
        OKBMultiLevelListColumnConfig *config10 = [[OKBMultiLevelListColumnConfig alloc] init];
        config10.widthWeight = @"2";
        config10.headerViews = header10;
        
        
        OKBMultiLevelListVC *vc2 = [[OKBMultiLevelListVC alloc] initWithConfig:@[config00, config10] rootModel:[DataSourceFactory level2DataSource] block:nil];
        
        [vc2 setMultiLevelViewBackgroundColor:[UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1] atIndex:0];
        
        
        OKBMenuViewController *tmp = [[OKBMenuViewController alloc] initWithMenuItemControllers:@[vc1, vc2]];
        vc1.selectedBlock = ^(OKBMultiLevelListNode *model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        vc2.selectedBlock = ^(OKBMultiLevelListNode *model) {
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
