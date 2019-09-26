//
//  OKBMenuItemViewController.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/20.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMenuItemView;


/// 菜单选项响应控制器，客户端自定义 VC 继承后，可以被加入到菜单中
@interface OKBMenuItemViewController : UIViewController
{
    @protected
    OKBMenuItemView *_menuItemView;
}
@property (nonatomic, strong) OKBMenuItemView *menuItemView;
@property (nonatomic, assign) CGFloat soureViewHeight;
@end

NS_ASSUME_NONNULL_END
