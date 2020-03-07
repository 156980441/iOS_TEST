//
//  Currency.h
//  TreeDemo
//
//  Created by fanyl on 2020/3/4.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Currency : NSObject
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, strong) NSArray<NSString *> *filterWord;
@end

NS_ASSUME_NONNULL_END
