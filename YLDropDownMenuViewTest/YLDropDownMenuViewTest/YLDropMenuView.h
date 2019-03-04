//
//  YLDropMenuView.h
//  YLDropDownMenuViewTest
//
//  Created by fanyl on 2019/3/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDropMenuView : UIView


/**
 *  初始化下拉选择视图
 *
 *  @param frame    菜单视图frame
 *  @param titles   要显示的按钮标题数组
 *  @param defImage 按钮没有点击之前右边那个小图片
 *  @param selImage 按钮点击之后右边那个小图片
 *
 *  @return 菜单视图
 */
- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray <NSString *>*)titles
                     defImage:(UIImage *)defImage
                     selImage:(UIImage *)selImage;

@end

NS_ASSUME_NONNULL_END
