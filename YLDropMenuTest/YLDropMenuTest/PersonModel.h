//
//  DataModel.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OKBMultiLevelMenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN


@interface DistrictModel : NSObject <OKBMultiLevelMenuProtocol>

// 服务器数据
@property (nonatomic, copy) NSString *district;

@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, strong) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end

@interface CompanyModel : NSObject <OKBMultiLevelMenuProtocol>

// 服务器数据
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *bossName;



@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, strong) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end


@interface PersonModel : NSObject <OKBMultiLevelMenuProtocol>

// 服务器数据
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phone;



@property (nonatomic, assign) NSInteger nodeId;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *nodeName;
@property (nonatomic, strong) NSArray<id<OKBMultiLevelMenuProtocol>> *array;

@end

NS_ASSUME_NONNULL_END