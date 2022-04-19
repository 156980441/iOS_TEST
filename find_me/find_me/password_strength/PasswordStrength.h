//
//  PasswordStrength.h
//  find_me
//
//  Created by yunlong on 2022/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordStrength : NSObject
+ (NSInteger)strengther:(NSString*)password;
@end

NS_ASSUME_NONNULL_END
