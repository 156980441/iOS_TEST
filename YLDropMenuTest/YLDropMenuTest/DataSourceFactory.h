//
//  DataSourceFactory.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelMenuRootModel;

@interface DataSourceFactory : NSObject

+ (OKBMultiLevelMenuRootModel *)level1DataSource;
+ (OKBMultiLevelMenuRootModel *)level2DataSource;
+ (OKBMultiLevelMenuRootModel *)level3DataSource;

@end

NS_ASSUME_NONNULL_END
