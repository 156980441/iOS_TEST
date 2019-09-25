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

@interface OKBMultiLevelListColumnConfig : NSObject

@property (nonatomic, assign) NSInteger widthWeight;
@property (nonatomic, strong, nullable) OKBMultiLevelListColumnHeaderView *columnHeaderView;
@property (nonatomic, strong) Class customTVCellClass;

+ (instancetype)defaultSingleColumnConfig;

@end

NS_ASSUME_NONNULL_END
