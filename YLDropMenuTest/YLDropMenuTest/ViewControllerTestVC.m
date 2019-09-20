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
#import "OKBMultiLevelDropDownMenuView.h"
#import "OKBMultiLevelDropDownMenuRootModel.h"
#import "OKBMenuViewController.h"
#import "OKBMultiLevelDropDownMenuVC.h"

#import "DataSourceFactory.h"
#import "OKBLabelImageView.h"
#import "PersonModel.h"

#import <Masonry/Masonry.h>

@interface ViewControllerTestVC ()
@property (nonatomic, strong) OKBMenuViewController *menuVC;
@end

@implementation ViewControllerTestVC

- (void)dealloc {
    NSLog(@"%s", __func__);
}

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

- (OKBMenuViewController *)menuVC {
    if (!_menuVC) {
        OKBMultiLevelDropDownMenuVC *vc1 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:1 levelOfWidthWeight:nil rootModel:[DataSourceFactory level1DataSource] block:nil];
        OKBMultiLevelDropDownMenuVC *vc2 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:2 levelOfWidthWeight:@"1:2" rootModel:[DataSourceFactory level2DataSource] block:nil];
        [vc2 setMultLevelViewBackgroundColor:[UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1] atIndex:0];
        
        
        OKBMenuViewController *tmp = [[OKBMenuViewController alloc] initWithMenuItemControllers:@[vc1, vc2]];
        vc1.selectedBlock = ^(id<OKBMultiLevelMenuProtocol>  _Nonnull model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        vc2.selectedBlock = ^(id<OKBMultiLevelMenuProtocol>  _Nonnull model) {
            [tmp updateMenuItemTitle:model.nodeName atIndex:tmp.selectedItemIndex];
            [tmp dismissSourceViewWithAnimation:YES];
        };
        _menuVC = tmp;
    }
    return _menuVC;
}

@end
