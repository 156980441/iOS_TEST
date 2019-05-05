//
//  ViewController.m
//  AddSubViewTest
//
//  Created by fanyl on 2019/5/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()
@property (nonatomic, strong) CustomView* innerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomView *tmp = CustomView.new;
//    tmp.backgroundColor = [UIColor redColor];
//    tmp.frame = CGRectMake(100, 100, 100, 100);
    
    UIView *v1 = UIView.new;
    [tmp addSubview:v1];
    
    [self.view addSubview:tmp];
}


@end
