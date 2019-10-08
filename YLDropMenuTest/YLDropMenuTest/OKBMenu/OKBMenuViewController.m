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
#import "OKBMenuPopViewPrivateHeader.h"


#import <Masonry/Masonry.h>

@interface OKBMenuViewController () <OKBMenuViewDelegate, OKBMenuViewDataSource, OKBMenuPopViewControllerDelegate>
{
    NSArray<OKBMenuPopViewController *> *_items;
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

- (instancetype)initWithMenuPopVCs:(NSArray<OKBMenuPopViewController *> *)items {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _items = items;
        for (OKBMenuPopViewController *vc in items) {
            [vc setMenuViewDelegate:self];
            [vc setBelongToMenuVC:self];
        }
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

#pragma mark - OKBMenuPopViewControllerDelegate

- (void)menuPopViewController:(OKBMenuPopViewController *)vc
           renderMenuItemView:(OKBMenuItemView *)menuItemView
                     userInfo:(id)userdata {
    [menuItemView renderMenuItemViewWithUserInfo:userdata];
}

#pragma mark - OKBMenuViewDataSource && OKBMenuViewDelegate

- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView {
    return _items.count;
}

- (OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index {
    return [_items objectAtIndex:index].menuItemView;
}

- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index {
    
    OKBMenuPopViewController *vc = [_items objectAtIndex:index];
    
    if (vc.parentViewController) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    
    [self addChildViewController:vc];
    [self didMoveToParentViewController:self];
    [self.view insertSubview:vc.view belowSubview:self.menuView];
    
    return vc.menuPopView;
}

- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index {
    return [_items objectAtIndex:index].menuPopViewHeight;
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
    [[_items objectAtIndex:index].menuItemView renderMenuItemViewWithUserInfo:title];;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
