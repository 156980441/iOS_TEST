//
//  OKBMenuViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuViewController.h"
#import "OKBMenuView.h"
#import "OKBMenuItem.h"
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
        }
    }
    return self;
}

- (void)menuPopViewController:(OKBMenuPopViewController *)vc
           renderMenuItemView:(OKBMenuItemView *)menuItemView
                     userInfo:(id)userdata {
    [menuItemView renderMenuItemViewWithUserInfo:userdata];
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
    return _items.count;
}

- (OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index {
    return [_items objectAtIndex:index].menuItemView;
}

- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index {
    
    UIViewController *vc = [_items objectAtIndex:index];
    
    if (vc.view.superview) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    
    [self addChildViewController:vc];
    [self didMoveToParentViewController:self];
    
    return vc.view;
}

- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index {
    return [_items objectAtIndex:index].popViewHeight;
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
    OKBLabelImageView *itemView = (OKBLabelImageView *)[_items objectAtIndex:index].menuItemView;
    itemView.textLbl.text = title;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
