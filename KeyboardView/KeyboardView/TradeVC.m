//
//  TradeVC.m
//  KeyboardView
//
//  Created by fanyl on 2019/10/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "TradeVC.h"
#import "Masonry.h"

@interface TradeVC ()

@end

@implementation TradeVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_showView:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_hidenView:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 根据键盘状态，调整 view 的位置
- (void)p_showView:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGFloat keyBoardEndY = value.CGRectValue.origin.y; // 得到键盘弹出后的键盘视图所在y坐标
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue delay:0 options:[curve intValue] animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    
//    [UIView animateWithDuration:duration.doubleValue animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationCurve:[curve intValue]];
//
//        self.toolBarView.center = CGPointMake(self.toolBarView.center.x, keyBoardEndY  - self.toolBarView.bounds.size.height/2.0);   // keyBoardEndY的坐标包括了状态栏的高度，要减去
//    }];
}

- (void)p_hidenView:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue delay:0 options:[curve intValue] animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
//          [UIView animateWithDuration:duration.doubleValue animations:^{
//
//                [UIView setAnimationBeginsFromCurrentState:YES];
//
//            [UIView setAnimationCurve:[curve intValue]];
//
//
//
//        //           self.toolBarView.center = CGPointMake(0, SCR_H - 44);  // keyBoardEndY的坐标包括了状态栏的高度，要减去
//
//                self.toolBarView.frame = CGRectMake(0, SCR_H - 44, SCR_W, 44);
//
//            }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tradeView = [[TradeView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tradeView];
    [_tradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
