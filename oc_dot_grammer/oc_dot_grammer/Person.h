//
//  Person.h
//  oc_dot_grammer
//
//  Created by fanyl on 2021/1/8.
//  Copyright © 2021 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
// 默认 readwrite
@property NSString *name;
@property int age;
// 只生成 getter
@property (readonly) NSString *sex;
@property (getter=showWeight, nonatomic) float weight;
@end

NS_ASSUME_NONNULL_END
