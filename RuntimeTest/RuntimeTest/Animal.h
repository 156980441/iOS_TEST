//
//  Animal.h
//  RuntimeTest
//
//  Created by fanyunlong on 2017/5/26.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
- (void)breath;
- (void)sleep;
@end

// 通过runtime添加动态属性
@interface Animal (AnimalExtention)
@property (copy, nonatomic) NSString *name;
-(void)eat;
@end
