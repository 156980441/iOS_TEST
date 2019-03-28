//
//  Father.m
//  InitializeTest
//
//  Created by fanyunlong on 6/6/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import "Father.h"

@implementation Father

// initialize是在类或者其子类的第一个方法被调用前调用
+(void) initialize {
    NSLog(@"%@,%s", [self class], __FUNCTION__);
}

// load是只要类所在文件被引用就会被调用
+ (void)load {
    NSLog(@"%@, %s", [self class], __FUNCTION__);
}

@end
