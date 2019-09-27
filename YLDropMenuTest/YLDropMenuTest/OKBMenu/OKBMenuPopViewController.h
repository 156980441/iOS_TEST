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

/// 抽象方法
- (OKBMenuItemView *)menuItemView;
/// 默认 300
- (CGFloat)popViewHeight;


/// 子类可以随时调用
- (void)reloadMenuView:(id)userInfo;

@end

@class OKBMenuViewController;

@interface OKBMenuPopViewController (OKBMenuRelation)
@property (nonatomic, readonly) OKBMenuViewController *menuVC;
@end

NS_ASSUME_NONNULL_END
