//
//  OKBMultiLevelMenuProtocol.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/10.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OKBMultiLevelMenuProtocol <NSObject>

@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *nodeName;

@property (nonatomic, strong) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end

NS_ASSUME_NONNULL_END
