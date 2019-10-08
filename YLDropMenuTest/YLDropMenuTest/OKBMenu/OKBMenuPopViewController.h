//
//  OKBMenuPopViewController.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/27.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBMenuItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKBMenuPopViewController : UIViewController

/// 抽象方法：菜单选项
- (OKBMenuItemView *)menuItemView;

/// 抽象方法：弹框视图
- (UIView *)menuPopView;

/// 默认 300
- (CGFloat)menuPopViewHeight;

/// 子类可以随时调用
- (void)reloadMenuItemView:(id)userInfo;

@end



@class OKBMenuViewController;

@interface OKBMenuPopViewController (OKBMenuRelation)

/// 被加入到菜单的 VC 可以获取到该属性
@property (nonatomic, readonly) OKBMenuViewController *menuVC;

@end

NS_ASSUME_NONNULL_END
