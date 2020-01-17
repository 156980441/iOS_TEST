//
//  Father.m
//  PrivateTest
//
//  Created by fanyl on 2020/1/17.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "Father.h"

@implementation Father {
    NSString *_name;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

// 私有方法
- (void)run:(NSString *)param {
    NSLog(@"Father run with %@", param);
}

@end
