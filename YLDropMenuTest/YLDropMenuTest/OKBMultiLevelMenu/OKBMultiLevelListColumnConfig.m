//
//  OKBMultiLevelListColumnConfig.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/25.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMultiLevelListColumnConfig.h"
#import "OKBMultiLevelListBaseTVCell.h"

@implementation OKBMultiLevelListColumnConfig

+ (instancetype)defaultSingleColumnConfig {
    OKBMultiLevelListColumnConfig *config = [[OKBMultiLevelListColumnConfig alloc] init];
    config.widthWeight = 1;
    config.customTVCellClass = OKBMultiLevelListBaseTVCell.class;
    config.columnHeaderView = nil;
    return config;
}

@end
