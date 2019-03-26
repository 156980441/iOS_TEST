//
//  Person.h
//  GenericsTest
//
//  Created by fanyl on 2018/12/12.
//  Copyright © 2018年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 声明一个Generics的格式如下：
 
 @interface 类名 <占位类型名称>
 @end
 
 */

// 第一步 声明泛型，首先是没有协变和逆变
@interface Person<ObjectType> : NSObject
@property (nonatomic, strong) ObjectType language; // 该人语言
@end
