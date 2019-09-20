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

@interface OKBMenuItemViewController : UIViewController
@property (nonatomic, strong) OKBMenuItemView *menuItemView;
@property (nonatomic, strong) UIView *sourceView;
@property (nonatomic, assign) CGFloat soureViewHeight;
@end

NS_ASSUME_NONNULL_END
