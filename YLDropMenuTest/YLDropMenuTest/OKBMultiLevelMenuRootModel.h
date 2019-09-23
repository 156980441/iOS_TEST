//
//  OKBMultiLevelDropDownMenuRootModel.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/16.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKBMultiLevelMenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKBMultiLevelMenuRootModel : NSObject <OKBMultiLevelMenuProtocol>

+ (instancetype)defaultRootModel;

@property (nonatomic, strong, nullable) id<OKBMultiLevelMenuProtocol> parent;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, strong, nullable) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end

NS_ASSUME_NONNULL_END
