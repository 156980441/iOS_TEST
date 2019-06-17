//
//  ViewController.m
//  UIViewAnimationTest
//
//  Created by fanyl on 2019/6/12.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

// https://blog.csdn.net/sqz316/article/details/52945625

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
    [self timerTransform]; // 不停旋转
    [self changeBackground];
    [self springAnimation]; // spring 动画类型
    [self transitionAnimation]; // 转场动画
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
    CGRect originalFrame = CGRectMake(0, 450, 10, 10);
    view.backgroundColor = [UIColor grayColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    CGAffineTransform originalTran = view.transform;
    [UIView animateWithDuration:2 animations:^{
//        view.transform = CGAffineTransformMakeScale(0.6, 0.6); // 缩放
//        view.transform = CGAffineTransformMakeTranslation(60, -60); // 位置移动 dis_x, dis_y
        view.transform = CGAffineTransformMakeRotation(4.0f); // 旋转，angle 是弧度 M_PI 是3.1415926，会顺时针旋转180。
        view.alpha = 0.1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:2 animations:^{
                view.transform = originalTran;
                view.alpha = 1;
            }];
        }
    }];
}

- (void)timerTransform {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(10, 500, 10, 10);
    view.backgroundColor = [UIColor greenColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(p_transformAction:)
                                   userInfo:view
                                    repeats:YES];
}

CGFloat g_angle = 0;

- (void)p_transformAction:(NSTimer*)timer {
    UIView* view = timer.userInfo;
    g_angle = g_angle + 0.01; // angle 角度 double angle;
    if (g_angle > 6.28) {//大于 M_PI*2(360度) 角度再次从0开始
        g_angle = 0;
    }
    CGAffineTransform transform = CGAffineTransformMakeRotation(g_angle);
    view.transform = transform;
}

- (void)changeBackground {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(30, 500, 10, 10);
    view.backgroundColor = [UIColor greenColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    // 关键帧动画
    [UIView animateKeyframesWithDuration:9.0 // 动画时长
                                   delay:0.f // 动画延迟
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear // 动画效果选项
                              animations:^{ // 动画执行代码
                                 
                                  // 添加关键帧
        [UIView addKeyframeWithRelativeStartTime:0.f     // 动画相对开始时间
                                relativeDuration:1.0 / 4 // 动画相对持续时间
                                      animations:^{      // 动画执行代码
            view.backgroundColor = [UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0 / 4 relativeDuration:1.0 / 4 animations:^{
            view.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0 / 4 relativeDuration:1.0 / 4 animations:^{
            view.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            view.backgroundColor = [UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            view.backgroundColor = [UIColor blackColor];
        }];
    } completion:^(BOOL finished) { // 动画结束执行代码
        if (finished) {
            NSLog(@"动画结束");
        }
        else {
            NSLog(@"动画未结束");
        }
    }];
}

// Spring Animation 本质上是一种特殊的动画曲线，自从 iOS 7开始被广泛应用在系统动画中。此外，Spring Animation不只能对位置使用，它适用于所有可被添加动画效果的属性。
- (void)springAnimation {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(50, 520, 10, 10);
    view.backgroundColor = [UIColor orangeColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    CGRect rect = CGRectMake(originalFrame.origin.x - 30, originalFrame.origin.y, 20, 20);
    
    [UIView animateWithDuration:0.4 // 动画时长
                          delay:0   // 动画延迟
         usingSpringWithDamping:0.5 // 类似弹簧的震动效果 0~1，数值越小「弹簧」的振动效果越明显.
          initialSpringVelocity:4   // 初始速度，数值越大一开始移动越快。值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
                        options:UIViewAnimationOptionCurveLinear // 动画过度效果
                     animations:^{
                         
                         view.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
                                 view.frame = originalFrame;
                             } completion:^(BOOL finished) {
                                 
                             }];
                         }
                     }];
}

- (void)transitionAnimation {
    UIView* view = UIView.new;
    CGRect originalFrame = CGRectMake(70, 500, 10, 10);
    view.backgroundColor = [UIColor purpleColor];
    view.frame = originalFrame;
    [self.view addSubview:view];
    
    [UIView transitionWithView:view
                      duration:3.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
        view.backgroundColor = [UIColor cyanColor];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView transitionWithView:view
                              duration:3.0
                               options:UIViewAnimationOptionTransitionFlipFromRight
                            animations:^{
                view.backgroundColor = [UIColor purpleColor];
            } completion:^(BOOL finished) {
            }];
        }
    }];
}

@end
