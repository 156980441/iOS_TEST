//
//  ViewController.m
//  UISegmentTest
//
//  Created by fanyl on 2019/3/8.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UISegmentedControl* temp = [[UISegmentedControl alloc] initWithItems:@[@"25%",@"50%",@"75%",@"100%"]];
    temp.layer.cornerRadius = 10;
    temp.clipsToBounds = YES;
    temp.layer.borderWidth = 0.5f;
    temp.layer.borderColor = [UIColor redColor].CGColor;
    [temp setDividerImage:nil
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];
    [temp addTarget:self
             action:@selector(actionSegmentChanged:)
   forControlEvents:UIControlEventValueChanged];
    NSDictionary *normal = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                             NSForegroundColorAttributeName:[UIColor blueColor]};
    NSDictionary *select = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                             NSForegroundColorAttributeName:[UIColor whiteColor]};
    [temp setTitleTextAttributes:select forState:UIControlStateSelected];
    [temp setTitleTextAttributes:normal forState:UIControlStateNormal];
    temp.frame = CGRectMake(10, 50, 200, 20);
    [self.view addSubview:temp];
}

- (void)actionSegmentChanged:(UISegmentedControl *)segmentedControl {
    NSLog(@"seg index: %zd", segmentedControl.selectedSegmentIndex);
}


@end
