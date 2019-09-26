//
//  OKBMultiLevelMenuNode.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/23.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 多级列表结点，理解成树
@interface OKBMultiLevelListNode : NSObject

@property (nonatomic, strong, readonly, nullable) OKBMultiLevelListNode *parentNode;
@property (nonatomic, strong) id data;

@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, strong, readonly, nullable) NSArray<OKBMultiLevelListNode *> *childNodes;

+ (instancetype)defaultRootModel;

- (void)addChild:(OKBMultiLevelListNode *)childNode;
- (void)removeChild:(OKBMultiLevelListNode *)childNode;

@end

NS_ASSUME_NONNULL_END
