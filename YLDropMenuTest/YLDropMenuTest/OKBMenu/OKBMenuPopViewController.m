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

- (OKBMenuItemView *)menuItemView {
    NSAssert(0, @"implement");
    return nil;
}

- (CGFloat)popViewHeight {
    return 300;
}

- (void)reloadMenuView:(id)userInfo {
    [_menuViewDelegate menuPopViewController:self renderMenuItemView:[self menuItemView] userInfo:userInfo];
}

@end
