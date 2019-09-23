//
//  DataSourceFactory.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelMenuNode;

@interface DataSourceFactory : NSObject

+ (OKBMultiLevelMenuNode *)level1DataSource;
+ (OKBMultiLevelMenuNode *)level2DataSource;
+ (OKBMultiLevelMenuNode *)level3DataSource;

@end

NS_ASSUME_NONNULL_END
