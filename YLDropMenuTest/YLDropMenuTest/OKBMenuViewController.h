//
//  OKBMenuViewController.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKBMenuViewController : UIViewController

- (instancetype)initWithMenuItemControllers:(NSArray<UIViewController *> *)controllersArr;

@property (nonatomic, assign) NSInteger selectedItemIndex;

- (void)updateMenuItemTitle:(NSString *)title atIndex:(NSInteger)index;

- (void)dismissSourceViewWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
