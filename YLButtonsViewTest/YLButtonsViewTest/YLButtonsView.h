//
//  YLButtonsView.h
//  YLButtonsViewTest
//
//  Created by fanyl on 2019/3/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 多 Button 视图，可以是自定义的 UISegmentControl
 */
@interface YLButtonsView : UIView

/**
 构造多个 Button

 @param buttonNums 按钮个数
 @return 多按钮视图
 */
- (instancetype)initWithButtons:(NSUInteger)buttonNums;

/**
 构造多个 Button

 @param frame 大小
 @param buttons 自定义的按钮数组
 @param space 按钮之间的间隙
 @return 多按钮视图
 */
- (instancetype)initWithFrame:(CGRect)frame buttons:(const NSArray<UIButton*>*)buttons internalSpace:(CGFloat)space;

/**
 构造多个 Button

 @param frame 大小
 @param titles 按钮显示的标题
 @param images 按钮显示的图片
 @param space 按钮之间的间隙
 @return 多按钮视图
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(const NSArray<NSString*>*)titles images:(nullable NSArray<UIImage*>*)images internalSpace:(CGFloat)space;


/**
 点击不同 Button 不同响应
 */
@property (nonatomic, copy) void (^block)(UIButton* btn, NSInteger index);


/**
 竖直排列显示，默认横向排列显示
 */
@property (nonatomic, assign) BOOL verticalDisplay;



/**
 更新 Button 的显示文案

 @param title 文案
 @param index 索引
 @param state Button 状态
 */
- (void)setButtonTitle:(NSString*)title index:(NSUInteger)index forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
