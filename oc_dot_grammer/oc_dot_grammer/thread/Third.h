//
//  Third.h
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class Third;

@protocol ThirdDelegate <NSObject>

- (void)finishedThird:(Third *)second;

@end

@interface Third : NSObject
{
    NSString *_name;
}
- (void)startSelf;
- (void)startWeakSelf;

@property (nonatomic, weak) id<ThirdDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
