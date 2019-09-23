//
//  DataModel.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface DistrictModel : NSObject

// 服务器数据
@property (nonatomic, copy) NSString *district;


@end


#pragma mark --

@interface CompanyModel : NSObject

// 服务器数据
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *bossName;



@end

#pragma mark --

@interface PersonModel : NSObject

// 服务器数据
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phone;


@end

NS_ASSUME_NONNULL_END
