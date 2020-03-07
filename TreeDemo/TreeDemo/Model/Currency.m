//
//  Currency.m
//  TreeDemo
//
//  Created by fanyl on 2020/3/4.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "Currency.h"
#import "MJExtension.h"

@implementation Currency
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"filterWord" : NSStringFromClass([NSString class])};
}
@end
