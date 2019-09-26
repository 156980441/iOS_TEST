//
//  LabelImageView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuItemView.h"

NS_ASSUME_NONNULL_BEGIN


/// 自定义的菜单选项视图
@interface OKBLabelImageView : OKBMenuItemView

@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage;

@end

NS_ASSUME_NONNULL_END
