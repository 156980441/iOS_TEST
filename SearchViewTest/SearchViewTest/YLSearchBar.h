//
//  YLSearchBar.h
//  SearchViewTest
//
//  Created by fanyl on 2019/3/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 自定义搜索栏
 */
@interface YLSearchBar : UIView
// 搜索框
@property(nonatomic, strong) UITextField *searchBarTF;
// 输入框中自定义的光标颜色
@property(nonatomic, strong) UIColor *cursorColor;
// 黑夜模式，默认关闭 NO
@property(nonatomic, assign) BOOL nightMode;

@end

NS_ASSUME_NONNULL_END
