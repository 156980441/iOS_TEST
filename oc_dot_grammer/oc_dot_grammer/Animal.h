//
//  Animal.h
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// OC 基础

@interface Animal : NSObject
{
    // 默认 protect，外界不能直接访问。所以想要设置，访问，要提供方法
    int _age;
    NSString *_name;
}

- (void)setAge:(int)age;
- (int)age;

@end

NS_ASSUME_NONNULL_END
