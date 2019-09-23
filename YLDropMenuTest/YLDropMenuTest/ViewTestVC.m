//
//  ViewTestVC.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewTestVC.h"

#import "OKBMenuView.h"
#import "OKBMenuItemView.h"
#import "OKBMultiLevelMenuView.h"
#import "OKBLabelImageView.h"

#import "DataSourceFactory.h"
#import "PersonModel.h"
#import "OKBMultiLevelMenuNode.h"

#import <Masonry/Masonry.h>

@interface ViewTestVC () <OKBMenuViewDataSource, OKBMenuViewDelegate, OKBMultiLevelMenuViewDelegate>
@property (nonatomic, strong) OKBMenuView *menuView;
@property (nonatomic, strong) OKBMultiLevelMenuView *item1SoureView;
@property (nonatomic, strong) OKBMultiLevelMenuView *item3SoureView;
@end

@implementation ViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.menuView];
    
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(88);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}


#pragma mark - OKBMenuViewDataSource && OKBMenuViewDelegate

- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView {
    return 4;
}

- (OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index {
    OKBLabelImageView *tmp = [[OKBLabelImageView alloc] initWithFrame:CGRectZero];
    tmp.textLbl.text = @"选择";
    if (index == 3) {
        tmp.image = [UIImage imageNamed:@"icon_setting"];
        tmp.highlightedImage = [UIImage imageNamed:@"icon_setting_highlighted"];
    }
    return tmp;
}

- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.item1SoureView;
    }
    else if (index == 1) {
        // 测试释放
        OKBMultiLevelMenuView *view = [[OKBMultiLevelMenuView alloc] initWithFrame:CGRectZero tableViewNum:2 widthWeight:nil];
        [view reloadDataWithRootDataSource:[DataSourceFactory level2DataSource]];
        return view;
    } else if (index == 2) {
        return self.item3SoureView;
    } else if (index == 3) {
        UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
        tmp.backgroundColor = [UIColor grayColor];
        tmp.text = @"自定义视图";
        tmp.textAlignment = NSTextAlignmentCenter;
        return tmp;
    }
    return nil;
}

- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index {
    if (index == 0) {
        return 260;
    }
    else {
        return 160;
    }
}

- (void)menuView:(OKBMenuView *)menuView didSelectItemAtIndexPath:(NSInteger)index {
    
}

#pragma mark - OKBMultiLevelMenuViewDelegate

- (CGFloat)multiLevelMenu:(OKBMultiLevelMenuView *)menuView heightForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    if (index == 0) {
        return 32;
    } else if (index == 1) {
        return 40;
    } else {
        return 20;
    }
}

- (void)multiLevelMenu:(OKBMultiLevelMenuView *)menuView didSelectInTableView:(nonnull OKBMultiLevelMenuNode *)model {
    OKBLabelImageView *tmp = (OKBLabelImageView *)[self.menuView menuItemViewAtIndex:self.menuView.selectedItemIndex];
    tmp.textLbl.text = model.nodeName;
    [self.menuView dismissSourceViewWithAnimation:YES];
    
    // 可以更新数据源
//    if (model.nodeId == 3) {
//        id<OKBMultiLevelMenuProtocol> original = model.par.parent;
//        original.array = [DataSourceFactory level1DataSource].array;
//    }
}

- (nullable UIView *)multiLevelMenu:(OKBMultiLevelMenuView *)menuView viewForHeaderInTableView:(UITableView *)tableView atIndex:(NSInteger)index {
    UILabel *tmp = [[UILabel alloc] initWithFrame:CGRectZero];
    tmp.textAlignment = NSTextAlignmentCenter;
    tmp.font = [UIFont systemFontOfSize:12];
    tmp.textColor = [UIColor colorWithRed:153/255.f green:153/255.f blue:153/255.f alpha:1];
    tmp.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
    if (index == 0) {
        tmp.text = @"标的（高度32）";
    } else if (index == 1) {
        tmp.text = @"到期时间（高度40）";
    } else {
        tmp.text = @"价格（高度20）";
    }
    return tmp;
}

#pragma mark - lazy load

- (OKBMenuView *)menuView {
    if (!_menuView) {
        OKBMenuView *tmp = [[OKBMenuView alloc] initWithFrame:CGRectZero];
        tmp.delegate = self;
        tmp.dataSource = self;
        _menuView = tmp;
    }
    return _menuView;
}

- (OKBMultiLevelMenuView *)item1SoureView {
    if (!_item1SoureView) {
        OKBMultiLevelMenuView *tmp = [[OKBMultiLevelMenuView alloc] initWithFrame:CGRectZero tableViewNum:3 widthWeight:nil];
        tmp.delegate = self;
        [tmp reloadDataWithRootDataSource:[DataSourceFactory level3DataSource]];
        UITableView *firstTableView = [tmp tableViewAtIndex:1];
        firstTableView.backgroundColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:250/255.f alpha:1];
        _item1SoureView = tmp;
    }
    return _item1SoureView;
}

- (OKBMultiLevelMenuView *)item3SoureView {
    if (!_item3SoureView) {
        OKBMultiLevelMenuView *tmp = [[OKBMultiLevelMenuView alloc] initWithFrame:CGRectZero tableViewNum:1 widthWeight:nil];
        [tmp reloadDataWithRootDataSource:[DataSourceFactory level1DataSource]];
        _item3SoureView = tmp;
    }
    return _item3SoureView;
}

@end
