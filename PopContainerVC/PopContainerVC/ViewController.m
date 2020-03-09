//
//  ViewController.m
//  PopContainerVC
//
//  Created by fanyl on 2020/3/9.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "RedVC.h"
#import "BlueVC.h"
#import "PopContainerVC.h"

@interface ViewController ()
{
    PopContainerVC *_popVC;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _popVC = [[PopContainerVC alloc] initWithNibName:nil bundle:nil];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button0 setTitle:@"Red" forState:UIControlStateNormal];
    button0.frame = CGRectMake(0, 200, CGRectGetWidth(self.view.frame) / 2, 44);
    [self.view addSubview:button0];
    [button0 addTarget:self
               action:@selector(p_buttonClicked0:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Blue" forState:UIControlStateNormal];
    button1.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2, 200, CGRectGetWidth(self.view.frame) / 2, 44);
    [self.view addSubview:button1];
    [button1 addTarget:self
               action:@selector(p_buttonClicked1:)
     forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_buttonClicked0:(UIButton *)button {
    RedVC *vc = RedVC.new;
    CGFloat offset = CGRectGetMaxY(button.frame);
    UIViewController *root = self.view.window.rootViewController;
    [root presentViewController:_popVC animated:NO completion:^{
        [self->_popVC setContentVC:vc
          atOffset:offset
            height:100
          animated:YES
        completion:nil];
    }];
}

- (void)p_buttonClicked1:(UIButton *)button {
    BlueVC *vc = BlueVC.new;
    CGFloat offset = CGRectGetMaxY(button.frame);
    UIViewController *root = self.view.window.rootViewController;
    [root presentViewController:_popVC animated:NO completion:^{
        [self->_popVC setContentVC:vc
          atOffset:offset
            height:100
          animated:YES
        completion:nil];
    }];
}

@end
