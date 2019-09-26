//
//  OKBMenuViewController.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMenuItemViewController;


/// 菜单控制器
@interface OKBMenuViewController : UIViewController

/// 菜单控制器初始化
/// @param controllersArr 菜单选项 VC
- (instancetype)initWithMenuItemControllers:(NSArray<OKBMenuItemViewController *> *)controllersArr;

@property (nonatomic, assign) NSInteger selectedItemIndex;


/// 更新菜单选项标题
/// @param title 标题
/// @param index 菜单选项索引
- (void)updateMenuItemTitle:(NSString *)title atIndex:(NSInteger)index;


/// 菜单消失
/// @param animation YES 消失动画
- (void)dismissSourceViewWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
