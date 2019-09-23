//
//  OKBMultiLevelMenuNode.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKBMultiLevelMenuNode : NSObject

@property (nonatomic, strong, nullable) OKBMultiLevelMenuNode *parentNode;
@property (nonatomic, strong) id data;

@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) NSInteger nodeId; // 目前没用
@property (nonatomic, strong, nullable) NSArray<OKBMultiLevelMenuNode *> *childNodes;

+ (instancetype)defaultRootModel;

@end

NS_ASSUME_NONNULL_END
