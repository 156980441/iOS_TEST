//
//  ViewController.m
//  YLButtonsViewTest
//
//  Created by fanyl on 2019/3/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "YLButtonsView.h"

@interface ViewController ()
@property (nonatomic, strong) YLButtonsView *btnsView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YLButtonsView *buttonsView, *buttonsView1, *buttonsView2, *buttonsView3;
    buttonsView = [[YLButtonsView alloc] initWithButtons:5];
    buttonsView.frame = CGRectMake(50, 100, 300, 20);
    [self.view addSubview:buttonsView];
    
    buttonsView1 = [[YLButtonsView alloc] initWithFrame:CGRectZero titles:@[@"删除 UI，应该 dealloc", @"增加 UI", @"增加 Button"] images:nil internalSpace:5];
    [self.view addSubview:buttonsView1];
    [buttonsView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonsView.mas_left);
        make.right.equalTo(buttonsView.mas_right);
        make.top.equalTo(buttonsView.mas_bottom).offset(5);
    }];
    
    
    
    buttonsView2 = [self getButtonsView];
    [self.view addSubview:buttonsView2];
    [buttonsView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonsView1.mas_left);
        make.right.equalTo(buttonsView1.mas_right);
        make.top.equalTo(buttonsView1.mas_bottom).offset(5);
    }];
    
    self.btnsView = buttonsView2;
    
    __weak __typeof(YLButtonsView*)tmp = buttonsView1;
    __weak __typeof(ViewController*)ws = self;
    
    
    
    buttonsView1.block = ^(UIButton * _Nonnull btn, NSInteger index) {
        if (index == 0) {
            [ws.btnsView removeFromSuperview];
            ws.btnsView = nil;
            
//            [UIView animateWithDuration:0.5 animations:^{
//                // 强制刷新布局
//                [ws.view layoutIfNeeded];
//            }];
        }
        else if (index == 1) {
            if (ws.btnsView) {
                [ws.btnsView removeFromSuperview]; // 防止多次添加内存泄漏
                ws.btnsView = nil;
            }
            ws.btnsView = [self getButtonsView];
            [ws.view addSubview:ws.btnsView];
            [ws.btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tmp.mas_left);
                make.right.equalTo(tmp.mas_right);
                make.top.equalTo(tmp.mas_bottom).offset(5);
            }];
        } else if (index == 2) {
            if (ws.btnsView) {
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                bt.backgroundColor = [UIColor blueColor];
                [bt setTitle:@"体育" forState:UIControlStateNormal];
                [ws.btnsView insertButton:bt atIndex:2];
            }
        }
    };
    
    buttonsView3 = YLButtonsView.new;
    [self.view addSubview:buttonsView3];
    [buttonsView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonsView2.mas_left);
        make.right.equalTo(buttonsView2.mas_right);
        make.top.equalTo(buttonsView2.mas_bottom).offset(5);
//        make.top.equalTo(buttonsView1.mas_bottom).offset(5).priority(300);
//        make.left.equalTo(buttonsView1.mas_left).priority(300);
//        make.right.equalTo(buttonsView1.mas_right).priority(300);
    }];
    UIButton *btn = [buttonsView3 buttonOfIndex:0];
    btn.backgroundColor = [UIColor orangeColor];
}

- (YLButtonsView*)getButtonsView {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor blueColor];
    [bt setTitle:@"动漫" forState:UIControlStateNormal];
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.backgroundColor = [UIColor yellowColor];
    [bt1 setTitle:@"电影" forState:UIControlStateNormal];
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.backgroundColor = [UIColor redColor];
    [bt2 setTitle:@"电视剧" forState:UIControlStateNormal];
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt3.backgroundColor = [UIColor grayColor];
    [bt3 setTitle:@"综艺" forState:UIControlStateNormal];
    
    YLButtonsView *tmp = [[YLButtonsView alloc] initWithFrame:CGRectZero buttons:@[bt, bt1, bt2, bt3] internalSpace:10];
    __weak __typeof(YLButtonsView*)w_tmp = tmp;
    tmp.block = ^(UIButton * _Nonnull btn, NSInteger index) {
        
        NSLog(@"%zd", index);
        NSLog(@"%@", btn.titleLabel.text);
        
        if (index == 0) {
            w_tmp.verticalDisplay = !w_tmp.verticalDisplay;
        }
    };
    return tmp;
}


@end
