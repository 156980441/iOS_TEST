//
//  ViewController.m
//  KeyboardView
//
//  Created by fanyl on 2019/10/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import "TradeView.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) TradeView *tradeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    self.textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textField];
    
    self.tradeView = [[TradeView alloc] initWithFrame:CGRectZero];
    self.textField.inputAccessoryView = self.tradeView;
    
}


@end
