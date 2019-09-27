//
//  OKBDropMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBMenuItemView.h"

NS_ASSUME_NONNULL_BEGIN

@class OKBMenuView;

@protocol OKBMenuViewDataSource <NSObject>

@required

/// 几个菜单项
/// @param menuView 菜单
- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView;

/// 菜单项自定义视图，该自定义视图父类必须是 OKBMenuItemView
/// @param menuView 菜单
/// @param index 菜单项索引
- (OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index;


/// 点击菜单项后弹出的自定义视图
/// @param menuView 菜单
/// @param index 菜单项索引
- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index;


/// 每一个菜单项被点击后弹出视图的高度
/// @param menuView 菜单
/// @param index 菜单项索引
- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index;

@end


@protocol OKBMenuViewDelegate <NSObject>

@optional
- (void)menuView:(OKBMenuView *)menuView didSelectItemAtIndexPath:(NSInteger)index;

@end



/// 菜单视图
@interface OKBMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

/// 菜单视图数据源委托
@property (nonatomic, weak) id <OKBMenuViewDataSource> dataSource;

/// 菜单视图委托
@property (nonatomic, weak, nullable) id <OKBMenuViewDelegate> delegate;

/// 当前选中的菜单项
@property (nonatomic, assign) NSInteger selectedItemIndex;

/// 根据菜单项索引获得响应的菜单项
/// @param index 菜单项索引
- (OKBMenuItemView *)menuItemViewAtIndex:(NSInteger)index;

/// 菜单隐藏
/// @param animation YES 显示动画
- (void)dismissSourceViewWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
