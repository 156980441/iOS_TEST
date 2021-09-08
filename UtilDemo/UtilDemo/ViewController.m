//
//  ViewController.m
//  UtilDemo
//
//  Created by yunlong on 2021/9/8.
//

#import "ViewController.h"

// 取整 https://blog.csdn.net/aouixh/article/details/53483556
// 计算文本高 https://www.jianshu.com/p/c26c168efe45
// 计算文本高 https://www.jianshu.com/p/7388ef05f32c
// 计算文本宽 https://my.oschina.net/huqiji/blog/961856

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"ceil 向上取整，1.3->2.0，-1.3->-1.0\nfloor 向下取整，1.3->1，-1.3->-2\nround 向下取整，1.3->1，-1.3->-1";
    UIFont *font = [UIFont systemFontOfSize:12];
    CGFloat h1 = [ViewController getSpaceLabelHeight:str withFont:font withWidth:100];
    CGFloat h2 = [ViewController getHeightByWidth:100 title:str font:font];
    CGFloat w1 = [ViewController getWidthByString:str font:font];
    CGFloat w2 = [ViewController getWidthByTitle:str font:font];
    NSLog(@"h1:%f,h2:%f,w1:%f,w2:%f", h1, h2, w1, w2);
}

// 使用场景:计算文本的高度，改变 UITableViewCell 的高度

/// 根据字符串的所占宽度计算高度
/// @param str 字符串
/// @param font 字体
/// @param width 宽
+ (CGFloat)getSpaceLabelHeight:(NSString*)str
                      withFont:(UIFont*)font
                     withWidth:(CGFloat)width
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:dic
                                    context:nil].size;
    return ceil(size.height);
    // CGSizeMake(width, CGFLOAT_MAX) 这样会得到一个指定宽度动态高度的size
    // ceil 向上取整，1.3->2.0，-1.3->-1.0
    // floor 向下取整，1.3->1，-1.3->-2
    // round 向下取整，1.3->1，-1.3->-1
    /**
     1.NSStringDrawingUsesLineFragmentOrigin:绘制文本时使用 line fragement origin 而不是 baseline origin。一般使用这项
     2.NSStringDrawingUsesFontLeading :根据字体计算高度
     3.NSStringDrawingUsesDeviceMetrics:使用象形文字计算高度
     4.NSStringDrawingTruncatesLastVisibleLine :这个目前我没怎么用过
     
     一般使用NSStringDrawingUsesFontLeading和NSStringDrawingUsesLineFragmentOrigin的组合
     */
}

// 同 getSpaceLabelHeight:withFont:withWidth:
+ (CGFloat)getHeightByWidth:(CGFloat)width
                      title:(NSString *)title
                       font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return ceil(height);
}

// 单行文本
// 使用场景:根据文本的长度，设置UILabel的长度，然后UILabel后面跟着其他的UI
+ (CGFloat)getWidthByString:(NSString *)string
                       font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = string;
    label.font = font;
    label.numberOfLines = 1;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    return ceil(width);
}

+ (CGFloat)getWidthByTitle:(NSString *)string
                      font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = string;
    label.font = font;
    label.numberOfLines = 1;
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:font}];
    return ceil(size.width);
}

@end
