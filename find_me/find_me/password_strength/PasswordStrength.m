//
//  PasswordStrength.m
//  find_me
//
//  Created by yunlong on 2022/4/19.
//

#import "PasswordStrength.h"

@implementation PasswordStrength

+ (NSInteger)strengther:(NSString*)password {
    //数字条件
    NSRegularExpression *numRegularExp = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger numMatchCount = [numRegularExp numberOfMatchesInString:password
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, password.length)];
    
    //小写英文字条件
    NSRegularExpression *lowLetterRegularExp = [NSRegularExpression regularExpressionWithPattern:@"[a-z]" options:0 error:nil];
    
    //符合小写英文字条件的有几个字节
    NSUInteger lowLetterMatchCount = [lowLetterRegularExp numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    //大写英文字条件
    NSRegularExpression *upperLetterRegularExp = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]" options:0 error:nil];
    
    //符合大写英文字条件的有几个字节
    NSUInteger upperLetterMatchCount = [upperLetterRegularExp numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    //特殊字符条件
    NSRegularExpression *specialRegularExp = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger specialMatchCount = [specialRegularExp numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    if (numMatchCount == password.length) {
        // 全部符合数字，表示沒有英文
    } else if (lowLetterMatchCount == password.length) {
        // 全部符合英文，表示沒有数字
    } else if (specialMatchCount == password.length) {
        // 全部符合特殊字符，表示沒有数字，英文
    } else if (numMatchCount + lowLetterMatchCount + specialMatchCount == password.length) {
        // 符合条件的相加等于密码长度
    } else {
    }
    
    BOOL base = numMatchCount >= 1 && lowLetterMatchCount >= 1 && specialMatchCount >= 1 && upperLetterMatchCount >= 1;
    if (password.length >= 10 && base && (numMatchCount >= 2 || lowLetterMatchCount >= 2 || upperLetterMatchCount >= 2 || specialMatchCount >= 2)) {
        return 3;
    } else if (password.length >= 9 && base) {
        return 2;
    } else if (password.length >= 8 && base) {
        return 1;
    } else {
        return 0;
    }
}

@end
