//
//  ViewController.m
//  shadow_corner
//
//  Created by yunlong on 2021/8/9.
//

#import "ViewController.h"

// 阴影，圆角

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat space = 10;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = [UIColor grayColor];
    view.layer.cornerRadius = 16;
    [self.view addSubview:view];
    // 这里不需要调佣以下方法
    // view.clipsToBounds = YES;
    
    
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectZero];
    shadowView.frame = CGRectMake(100, CGRectGetMaxY(view.frame) + space, 100, 100);
    shadowView.backgroundColor = [UIColor redColor];
    shadowView.layer.shadowOffset = CGSizeMake(10, 10); // default (0, -3);
    shadowView.layer.shadowColor = [UIColor blueColor].CGColor;
    shadowView.layer.shadowOpacity = 1; // default 0，0 就看不到阴影
    shadowView.layer.shadowRadius = 16; // 阴影的圆角
    [self.view addSubview:shadowView];
}


@end
