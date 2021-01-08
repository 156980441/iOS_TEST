//
//  Second.h
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Second;

@protocol SecondDelegate <NSObject>

- (void)finishedSecond:(Second *)second;

@end

@interface Second : NSObject
- (void)start;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, weak) id<SecondDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
