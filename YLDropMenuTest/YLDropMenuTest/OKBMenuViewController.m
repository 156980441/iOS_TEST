//
//  OKBMenuViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuViewController.h"
#import "OKBMenuView.h"
#import "OKBLabelImageView.h"

#import <Masonry/Masonry.h>

@interface OKBMenuViewController () <OKBMenuViewDelegate, OKBMenuViewDataSource>
{
    NSArray<UIViewController *> *_controllersArr;
}
@property (nonatomic, strong) OKBMenuView *menuView;

@end

@implementation OKBMenuViewController

- (NSInteger)selectedItemIndex {
    return self.menuView.selectedItemIndex;
}

- (void)dismissSourceViewWithAnimation:(BOOL)animation {
    [self.menuView dismissSourceViewWithAnimation:animation];
}

- (instancetype)initWithMenuItemControllers:(NSArray<UIViewController *> *)controllersArr {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _controllersArr = controllersArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}


#pragma mark - OKBMenuViewDataSource && OKBMenuViewDelegate

- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView {
    return _controllersArr.count;
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
    
    UIViewController *vc = [_controllersArr objectAtIndex:index];
    
    if (vc.view.superview) {
        [vc removeFromParentViewController];
    }
    
    [self addChildViewController:vc];
    [self didMoveToParentViewController:self];
    return vc.view;
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

- (OKBMenuView *)menuView {
    if (!_menuView) {
        OKBMenuView *tmp = [[OKBMenuView alloc] initWithFrame:CGRectZero];
        tmp.delegate = self;
        tmp.dataSource = self;
        _menuView = tmp;
    }
    return _menuView;
}

- (void)updateMenuItemTitle:(NSString *)title atIndex:(NSInteger)index {
    OKBLabelImageView *itemView = (OKBLabelImageView *)[self.menuView menuItemViewAtIndex:index];
    itemView.textLbl.text = title;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
