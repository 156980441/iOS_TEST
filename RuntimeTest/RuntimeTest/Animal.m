//
//  Animal.m
//  RuntimeTest
//
//  Created by fanyunlong on 2017/5/26.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "Animal.h"

#import <objc/runtime.h>

@implementation Animal
- (void)breath
{
    NSLog(@"Animal breath...");
}
- (void)sleep {
    NSLog(@"Animal sleep...");
}
@end

@implementation Animal (AnimalExtention)

// 定义常量 必须是C语言字符串，因为都是 C 借口
static char *AnimalNameKey = "AnimalNameKey";

/*
 OBJC_ASSOCIATION_ASSIGN;            // assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    // copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 */

/*
 
 id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 
 */

-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, AnimalNameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name{
    return objc_getAssociatedObject(self, AnimalNameKey);
}

-(void)eat
{
    NSLog(@"Animal eat...");
}

@end
