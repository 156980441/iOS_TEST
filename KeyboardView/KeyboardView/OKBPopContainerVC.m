//
//  OKBPopContainerVC.m
//  OKBusiness
//
//  Created by fanyl on 2019/10/18.
//

#import "OKBPopContainerVC.h"
#import "Masonry.h"

@interface OKBPopContainerVC ()
{
    UIViewController* _contentVC;
    UIView* _maskView;
}
@end



@implementation OKBPopContainerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
    _maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _maskView.clipsToBounds = YES;
    [self.view addSubview:_maskView];
}

- (void)setContentVC:(UIViewController *)contentVC
            atOffset:(CGFloat)offset
              height:(CGFloat)height
            animated:(BOOL)animated
          completion:(dispatch_block_t)completion {
    
    if (_contentVC) {
        // 当前有contentView，那么就强制无动画显示
        animated = NO;
        
        [_contentVC.view removeFromSuperview];
        [_contentVC willMoveToParentViewController:nil];
        [_contentVC removeFromParentViewController];
        
    }
    
    CGRect maskViewFrame = CGRectMake(0, offset, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - offset);
    _maskView.frame = maskViewFrame;
    
    [self addChildViewController:contentVC];
    contentVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), height);
    [_maskView addSubview:contentVC.view];
    [contentVC didMoveToParentViewController:self];
    _contentVC = contentVC;
    
    if (animated) {
        contentVC.view.transform = CGAffineTransformMakeTranslation(0, -height);
        _maskView.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3 animations:^{
            self->_maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
            contentVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }
    else {
        _maskView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
        if (completion) {
            completion();
        }
    }
    
}

- (void)clearContentVCAnimated:(BOOL)animated completion:(dispatch_block_t)completion {
    if (!_contentVC) {
        return;
    }
    
    UIViewController* contentVC = _contentVC;
    _contentVC = nil;
    
    if (animated) {
        CGFloat contentViewHeight = CGRectGetHeight(contentVC.view.frame);
        [UIView animateWithDuration:0.3 animations:^{
            self->_maskView.backgroundColor = [UIColor clearColor];
            contentVC.view.transform = CGAffineTransformMakeTranslation(0, -contentViewHeight);
        } completion:^(BOOL finished) {
            contentVC.view.transform = CGAffineTransformIdentity;
            
            [contentVC willMoveToParentViewController:nil];
            [contentVC.view removeFromSuperview];
            [contentVC removeFromParentViewController];
            
            if (completion) {
                completion();
            }
        }];
    }
    else {
        contentVC.view.transform = CGAffineTransformIdentity;
        [contentVC willMoveToParentViewController:nil];
        [contentVC.view removeFromSuperview];
        [contentVC removeFromParentViewController];
        if (completion) {
            completion();
        }
    }
}


@end
