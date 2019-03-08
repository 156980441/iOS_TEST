//
//  YLButtonUtil.h
//  ButtonTest
//
//  Created by fanyl on 2019/3/8.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OKGSLayoutButtonStyle) {
    OKGSLayoutButtonStyleLeftImageRightTitle,
    OKGSLayoutButtonStyleLeftTitleRightImage,
    OKGSLayoutButtonStyleUpImageDownTitle,
    OKGSLayoutButtonStyleUpTitleDownImage
};


@interface YLButtonUtil : NSObject

/**
 设置 Button 图片以及字体位置
 
 @param button 要设置的 Button
 @param style 样式
 @param space 图片和字体间距
 */
void setButtonLabelImageStyle(UIButton* button, OKGSLayoutButtonStyle style, CGFloat space);

@end

NS_ASSUME_NONNULL_END
