//
//  Children+age.m
//  InitializeTest
//
//  Created by fanyunlong on 6/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "Children+age.h"

@implementation Children (age)

// 从该实例可以看出，分类的 +initialize 方法会覆盖原类中 +initialize 方法。

+ (void)initialize
{
    NSLog(@"%s", __FUNCTION__);
}

+ (void)load {
    NSLog(@"%@, %s", [self class], __FUNCTION__);
}

@end
