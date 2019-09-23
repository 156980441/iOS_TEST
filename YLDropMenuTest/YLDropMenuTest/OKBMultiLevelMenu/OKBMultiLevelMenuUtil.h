//
//  OKBMultiLevelMenuUtil.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/18.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKBMultiLevelMenuNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKBMultiLevelMenuUtil : NSObject
+ (OKBMultiLevelMenuNode *)search:(OKBMultiLevelMenuNode *)source withNodeId:(NSInteger)nodeId;

@end

NS_ASSUME_NONNULL_END
