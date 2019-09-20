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

@property (nonatomic, strong, nullable) id<OKBMultiLevelMenuProtocol> parent;

@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, strong, nullable) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end

NS_ASSUME_NONNULL_END
