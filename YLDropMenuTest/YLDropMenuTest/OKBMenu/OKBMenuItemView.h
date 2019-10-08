//
//  OKBDropMenuItemView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 类似 UITableViewCell 的封装，菜单选项 UI，使用方法参考 OKBLabelImageView 类，客户端可以自定义菜单选项样式
@interface OKBMenuItemView : UIView

/// 菜单选项自定义视图
@property (nonatomic, readonly) UIView *contentView;

/// default: NO
@property (nonatomic, assign) BOOL selected;

/// 抽象方法，子类实现
/// @param userInfo 用户自定义参数
- (void)renderMenuItemViewWithUserInfo:(id)userInfo;

@end

NS_ASSUME_NONNULL_END
