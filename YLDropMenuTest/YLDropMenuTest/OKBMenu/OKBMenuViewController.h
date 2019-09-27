//
//  OKBMenuViewController.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

/// 菜单控制器
@interface OKBMenuViewController : UIViewController

/// 菜单控制器初始化
/// @param items 菜单项数组
- (instancetype)initWithMenuItems:(NSArray<OKBMenuItem *> *)items;

/// 当前选择的菜单项
@property (nonatomic, readonly) NSInteger selectedItemIndex;

/// 更新菜单选项标题
/// @param title 标题
/// @param index 菜单选项索引
- (void)updateMenuItemTitle:(NSString *)title atIndex:(NSInteger)index;

/// 菜单消失
/// @param animation YES 消失动画
- (void)dismissSourceViewWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
