//
//  ViewController.m
//  UIViewAnimationTest
//
//  Created by fanyl on 2019/6/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self changeFrame]; // 大小动画（改变frame）
    [self changeBounds]; // 拉伸动画 (改变bounds)
    [self changeCenter]; // 中心
    [self changeTransform]; // 旋转
}

- (void)changeFrame {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(150, 150, 100, 100);
    view.backgroundColor = [UIColor redColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    CGRect rect = CGRectMake(originalFrame.origin.x - 20, originalFrame.origin.y - 120, 50, 50);
    
    [UIView animateWithDuration:1 animations:^{
        view.frame = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 animations:^{
                view.frame = originalFrame;
            }];
        }
    }];
}

- (void)changeBounds {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(150, 300, 100, 100);
    view.backgroundColor = [UIColor yellowColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    // 尽管这个 rect 的 x，y 跟原始的不同，动画也只是改变了宽高
    CGRect rect = CGRectMake(0, 0, 50, 50);
    
    [UIView animateWithDuration:1 animations:^{
        view.bounds = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 animations:^{
                view.bounds = originalFrame;
            }];
        }
    }];
}

- (void)changeCenter {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(0, 300, 100, 100);
    view.backgroundColor = [UIColor blueColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    CGPoint originalP = view.center;
    CGPoint p = CGPointMake(view.center.x, view.center.y + 20);
    
    
    [UIView animateWithDuration:1 animations:^{
        view.center = p;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 animations:^{
                view.center = originalP;
            }];
        }
    }];
}

- (void)changeTransform {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(0, 450, 100, 100);
    view.backgroundColor = [UIColor grayColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    CGAffineTransform originalTran = view.transform;
    [UIView animateWithDuration:2 animations:^{
//        view.transform = CGAffineTransformMakeScale(0.6, 0.6); // 缩放
//        view.transform = CGAffineTransformMakeTranslation(60, -60); // 位置移动 dis_x, dis_y
        view.transform = CGAffineTransformMakeRotation(4.0f); // 旋转，angle 是弧度 M_PI 是3.1415926，会顺时针旋转180。
        
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:2 animations:^{
                view.transform = originalTran;
            }];
        }
    }];
}


@end
