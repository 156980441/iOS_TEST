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
#import "OKBMultiLevelDropMenuTVHeaderView.h"
#import "OKBMultiLevelDropDownMenuLabelTVHeader.h"

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
        OKBMultiLevelDropDownMenuLabelTVHeader *header0 = OKBMultiLevelDropDownMenuLabelTVHeader.new;
        header0.textLbl.text = @"姓名";
        OKBMultiLevelDropDownMenuLabelTVHeader *header1 = OKBMultiLevelDropDownMenuLabelTVHeader.new;
        header1.textLbl.text = @"班级";
        OKBMultiLevelDropDownMenuLabelTVHeader *header2 = OKBMultiLevelDropDownMenuLabelTVHeader.new;
        header2.textLbl.text = @"学校";
        NSArray *arr = @[header0, header1, header2];
        
        OKBMultiLevelDropDownMenuVC *vc1 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:1 levelOfWidthWeight:nil tableViewHeaders:arr rootModel:[DataSourceFactory level1DataSource] block:nil];
        OKBMultiLevelDropDownMenuVC *vc2 = [[OKBMultiLevelDropDownMenuVC alloc] initWithMultiLevel:2 levelOfWidthWeight:@"1:2" tableViewHeaders:arr rootModel:[DataSourceFactory level2DataSource] block:nil];
        [vc2 setMultiLevelViewBackgroundColor:[UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1] atIndex:0];
        
        
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


- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
