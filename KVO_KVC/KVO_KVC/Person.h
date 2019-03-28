//
//  Person.h
//  KVO_KVC
//
//  Created by fanyunlong on 5/27/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  KVO
 *
 *  @since <#version number#>
 */

@interface Person : NSObject

@property(nonatomic,retain)NSString *name;//属性name将被监视
@property(nonatomic,assign)NSInteger age;

-(void)changeName;

@end
