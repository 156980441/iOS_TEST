//
//  OKBMultiLevelListColumnConfig.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/25.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelListColumnHeaderView;


/// 多级列表列的配置
@interface OKBMultiLevelListColumnConfig : NSObject

/// 单个列表的宽度权重
@property (nonatomic, assign) NSInteger widthWeight;
/// 单个列表的头部视图
@property (nonatomic, strong, nullable) OKBMultiLevelListColumnHeaderView *columnHeaderView;
/// 单个列表内 Cell 样式
@property (nonatomic, strong) Class customTVCellClass;


/// 默认单个列配置：单列铺满整个多级列表视图，没有列的头部视图，cell 样式 OKBMultiLevelListBaseTVCell
+ (instancetype)defaultSingleColumnConfig;

@end

NS_ASSUME_NONNULL_END
