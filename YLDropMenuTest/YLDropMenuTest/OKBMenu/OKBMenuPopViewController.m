//
//  OKBMenuPopViewController.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/27.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuPopViewController.h"
#import "OKBMenuPopViewPrivateHeader.h"

@interface OKBMenuPopViewController ()
{
    __weak id<OKBMenuPopViewControllerDelegate> _menuViewDelegate;
    __weak OKBMenuViewController *_menuVC;
}
@end

@implementation OKBMenuPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setMenuViewDelegate:(id<OKBMenuPopViewControllerDelegate>)delegte {
    _menuViewDelegate = delegte;
}

- (void)setBelongToMenuVC:(OKBMenuViewController *)menuVC {
    _menuVC = menuVC;
}

- (OKBMenuViewController *)menuVC {
    return _menuVC;
}

- (OKBMenuItemView *)menuItemView {
    NSAssert(0, @"implement");
    return nil;
}

- (UIView *)menuPopView {
    NSAssert(0, @"implement");
    return nil;
}

- (CGFloat)menuPopViewHeight {
    return 300;
}

- (void)reloadMenuView:(id)userInfo {
    [_menuViewDelegate menuPopViewController:self renderMenuItemView:[self menuItemView] userInfo:userInfo];
}

@end
