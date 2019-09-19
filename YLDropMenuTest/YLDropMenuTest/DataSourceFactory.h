//
//  DataSourceFactory.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelDropDownMenuRootModel;

@interface DataSourceFactory : NSObject
+ (OKBMultiLevelDropDownMenuRootModel *)level3DataSource;
+ (OKBMultiLevelDropDownMenuRootModel *)level1DataSource;
+ (OKBMultiLevelDropDownMenuRootModel *)level2DataSource;
@end

NS_ASSUME_NONNULL_END
