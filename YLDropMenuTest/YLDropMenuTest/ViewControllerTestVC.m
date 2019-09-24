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
#import "OKBMultiLevelMenuView.h"
#import "OKBMultiLevelMenuTVHeaderView.h"
#import "OKBMultiLevelMenuLabelTVHeader.h"

#import "OKBMultiLevelMenuNode.h"

#import "OKBMenuViewController.h"
#import "OKBMultiLevelMenuVC.h"

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
        OKBMultiLevelMenuLabelTVHeader *header0 = OKBMultiLevelMenuLabelTVHeader.new;
        header0.textLbl.text = @"姓名";
        OKBMultiLevelMenuLabelTVHeader *header1 = OKBMultiLevelMenuLabelTVHeader.new;
        header1.textLbl.text = @"班级";
        OKBMultiLevelMenuLabelTVHeader *header2 = OKBMultiLevelMenuLabelTVHeader.new;
        header2.textLbl.text = @"学校";
        NSArray *arr = @[header0, header1, header2];
        
        OKBMultiLevelMenuLabelTVHeader *header00 = OKBMultiLevelMenuLabelTVHeader.new;
        header00.textLbl.text = @"姓名";
        OKBMultiLevelMenuLabelTVHeader *header10 = OKBMultiLevelMenuLabelTVHeader.new;
        header10.textLbl.text = @"地域";
        OKBMultiLevelMenuLabelTVHeader *header20 = OKBMultiLevelMenuLabelTVHeader.new;
        header20.textLbl.text = @"学校";
        NSArray *arr2 = @[header00, header10, header20];
        
        OKBMultiLevelMenuViewConfig *config1 = [[OKBMultiLevelMenuViewConfig alloc] init];
        config1.level = 1;
        config1.widthWeight = nil;
        config1.headerViews = arr;
        
        OKBMultiLevelMenuViewConfig *config2 = [[OKBMultiLevelMenuViewConfig alloc] init];
        config2.level = 2;
        config2.widthWeight = nil;
        config2.headerViews = arr2;
        
        // 这里要整两个arr，有没有方便的方法？
        OKBMultiLevelMenuVC *vc1 = [[OKBMultiLevelMenuVC alloc] initWithConfig:config1 rootModel:[DataSourceFactory level1DataSource] block:nil];
        OKBMultiLevelMenuVC *vc2 = [[OKBMultiLevelMenuVC alloc] initWithConfig:config2 rootModel:[DataSourceFactory level2DataSource] block:nil];
        
        [vc2 setMultiLevelViewBackgroundColor:[UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1] atIndex:0];
        
        OKBMenuViewController *tmp = [[OKBMenuViewController alloc] initWithMenuItemControllers:@[vc1, vc2]];
        vc1.selectedBlock = ^(OKBMultiLevelMenuNode *model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        vc2.selectedBlock = ^(OKBMultiLevelMenuNode *model) {
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
