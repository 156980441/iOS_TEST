//
//  PopContainerVC.m
//  PopContainerVC
//
//  Created by fanyl on 2020/3/9.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import "PopContainerVC.h"

@interface PopContainerVC ()
{
    UIView *_maskView;
}
@end

@implementation PopContainerVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _maskView.clipsToBounds = YES;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_maskView];
    
    UITapGestureRecognizer *containerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(p_tappedInPopContainerVC:)];
    containerTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:containerTap];
}

- (void)p_tappedInPopContainerVC:(UIGestureRecognizer*)gestureRecognizer {
    CGPoint locationInContainer = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGRect contentFrame = [self.view convertRect:_contentVC.view.bounds
                                               fromView:_contentVC.view];
    if (CGRectContainsPoint(contentFrame, locationInContainer) ) {
        // 点击了内容区，忽略
        return;
    }

    // 如果不是内容区域，看看是否是 MenuView 区域
    CGPoint locationInWindow = [self.view.window convertPoint:locationInContainer
                                                fromView:self.view];
    CGPoint locationInSelf = [self convertPoint:locationInWindow
                                       fromView:self.view.window];
//    if (CGRectContainsPoint(self.bounds, locationInSelf)) {
//        // 点在了 MenuView 上
//        [self p_tappedInMenuItemView:locationInSelf];
//    }
//    else {
//        // 点在了 OKBPopContainerVC 的空白区域上
//        [self dismissSourceViewWithAnimation:YES];
//    }
}

- (void)setContentVC:(UIViewController *)vc
            atOffset:(CGFloat)offset
              height:(CGFloat)height
            animated:(BOOL)animated
          completion:(nullable dispatch_block_t)completion {
    _contentVC = vc;
    [self addChildViewController:_contentVC];
    _contentVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height);
    [_maskView addSubview:_contentVC.view];
    [_contentVC didMoveToParentViewController:self];
    
    CGRect maskViewFrame = CGRectMake(0, offset, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - offset);
    _maskView.frame = maskViewFrame;
    
    if (animated) {
        _contentVC.view.transform = CGAffineTransformMakeTranslation(0, -height);
        _maskView.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self->_maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            self->_contentVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
    else {
        if (completion) {
            completion();
        }
    }
    
}

- (void)clearContentVCAnimated:(BOOL)animated
                    completion:(nullable dispatch_block_t)completion {
    if (animated) {
        CGFloat height = CGRectGetHeight(_contentVC.view.frame);
        [UIView animateWithDuration:0.3 animations:^{
            self->_maskView.backgroundColor = [UIColor clearColor];
            self->_contentVC.view.transform = CGAffineTransformMakeTranslation(0, -height);
        } completion:^(BOOL finished) {
            self->_contentVC.view.transform = CGAffineTransformIdentity;
            
            [self->_contentVC willMoveToParentViewController:nil];
            [self->_contentVC.view removeFromSuperview];
            [self->_contentVC removeFromParentViewController];
            
            if (completion) {
                completion();
            }
            
            self->_contentVC = nil;
        }];
    }
    else {
        self->_contentVC.view.transform = CGAffineTransformIdentity;
        [self->_contentVC willMoveToParentViewController:nil];
        [self->_contentVC.view removeFromSuperview];
        [self->_contentVC removeFromParentViewController];
        
        if (completion) {
            completion();
        }
        
        self->_contentVC = nil;
    }
}

@end
