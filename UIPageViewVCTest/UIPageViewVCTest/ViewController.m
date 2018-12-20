//
//  ViewController.m
//  UIPageViewVCTest
//
//  Created by fanyl on 2018/12/19.
//  Copyright © 2018年 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    UIPageViewController* temp = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    temp.dataSource = self;
    
    UIViewController *page1ViewController = [[UIViewController alloc] init];
    UIViewController *page2ViewController = [[UIViewController alloc] init];
    UIViewController *page3ViewController = [[UIViewController alloc] init];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView1.image = [UIImage imageNamed:@"emotarShit"];
    [page1ViewController.view addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView2.image = [UIImage imageNamed:@"emotarSmile"];
    [page2ViewController.view addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView3.image = [UIImage imageNamed:@"emotarSmirk"];
    [page3ViewController.view addSubview:imageView3];
    
    NSArray* arr = @[page1ViewController, page2ViewController, page3ViewController];
    
    [temp setViewControllers:@[arr.firstObject]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    
    [self addChildViewController:temp];
    [self.view addSubview:temp.view];
    temp.view.frame = self.view.frame;
    [temp didMoveToParentViewController:self];
    
    self.arr = arr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.arr indexOfObject:viewController];
    // index 为 0 表示已经翻到最前页
    if (index == 0 ||
        index == NSNotFound) {
        return  nil;
    }
    
    // 下标自减
    index--;
    return self.arr[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.arr indexOfObject:viewController];
    // index为数组最末表示已经翻至最后页
    if (index == NSNotFound ||
        index == (self.arr.count - 1)) {
        return nil;
    }
    
    // 下标自增
    index++;
    
    return self.arr[index];
}


@end
