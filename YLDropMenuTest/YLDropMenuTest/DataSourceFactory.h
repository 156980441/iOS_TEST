//
//  DataSourceFactory.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/19.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMultiLevelListNode;

@interface DataSourceFactory : NSObject

+ (OKBMultiLevelListNode *)level1DataSource;
+ (OKBMultiLevelListNode *)level2DataSource;
+ (OKBMultiLevelListNode *)level3DataSource;

@end

NS_ASSUME_NONNULL_END
