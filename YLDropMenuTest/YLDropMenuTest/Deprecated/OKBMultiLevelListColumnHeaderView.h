//
//  OKBMultiLevelDropMenuTVHeaderView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 干掉了一曾继承，放在了 OKBMultiLevelListColumnConfig

/// 多级列表列的头部视图，使用方法参见子类 OKBMultiLevelListLabelTVHeader
@interface OKBMultiLevelListColumnHeaderView : UIView

@property (nonatomic, readonly) UIView *contentView;

@property (nonatomic, assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
