//
//  AttributeStringEventVC.m
//  find_me
//
//  Created by yunlong on 2022/4/21.
//

#import "AttributeStringEventVC.h"
#import <YYKit/YYKit.h>
#import <Masonry/Masonry.h>

@interface AttributeStringEventVC ()
@property (nonatomic, strong) YYLabel *label;
@end

@implementation AttributeStringEventVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [[YYLabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    NSString *str = @"By continuing, I agree to Terms of Service, Risk & Compliance Disclosures, and Privacy Policy.";
    NSString *str1 = @"Terms of Service";
    NSString *str2 = @"Risk & Compliance Disclosures";
    NSString *str3 = @"Privacy Policy";
    
    NSRange range1 = [str rangeOfString:str1];
    NSRange range2 = [str rangeOfString:str2];
    NSRange range3 = [str rangeOfString:str3];
    NSRange contentRange = {0, str.length};
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:str];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:contentRange];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:contentRange];
    [content addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range1];
    [content addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range2];
    [content addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:range3];
    [content addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range1];
    [content addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range2];
    [content addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range3];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range3];
    
    __weak typeof(self) wself = self;
    [content setTextHighlightRange:range1 color:[UIColor redColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strong typeof(wself) sself = wself;
        sself.label.backgroundColor = [UIColor grayColor];
    }];
    [content setTextHighlightRange:range2 color:[UIColor redColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strong typeof(wself) sself = wself;
        sself.label.backgroundColor = [UIColor blueColor];
    }];
    [content setTextHighlightRange:range3 color:[UIColor redColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __strong typeof(wself) sself = wself;
        sself.label.backgroundColor = [UIColor yellowColor];
    }];
    
    
    self.label.attributedText = content;
    self.label.userInteractionEnabled = YES;
    self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.view.bounds) - 40;
    self.label.numberOfLines = 0;
    
}

@end
