//
//  ViewController.m
//  YLPopViewTest
//
//  Created by fanyl on 2019/6/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 50, 80, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:view];
    view.layer.mask = layer;
}


@end
