//
//  OKBDropMenuView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuView.h"
#import <Masonry/Masonry.h>

static UIWindow* window4Show (void) {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
        }
    }
    return nil;
}

@interface OKBMenuView ()
{
    NSArray<OKBMenuItemView *> *_itemViewArr;
    NSInteger _num;
    UIView *_sourceView;
    OKBMenuItemView *_lastSelectedItemView;
}
@end

@implementation OKBMenuView

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInMenuView:)]) {
        _num = [self.dataSource numberOfItemsInMenuView:self];
    }
    NSMutableArray<OKBMenuItemView *> *tmp = [[NSMutableArray alloc] initWithCapacity:_num];
    for (int i = 0; i < _num; i ++) {
        if ([self.dataSource respondsToSelector:@selector(menuView:viewForItemAtIndex:)]) {
            OKBMenuItemView *itemView = [self.dataSource menuView:self viewForItemAtIndex:i];
            NSAssert(itemView != nil, @"Please implement OKBMenuViewDataSource");
            itemView.tag = i;
            [tmp addObject:itemView];
            [self addSubview:itemView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_tapInView:)];
            [itemView addGestureRecognizer:tap];
        }
    }
    _itemViewArr = [NSArray arrayWithArray:tmp];
    
    [self p_layoutUI];
}

- (void)dismissSourceViewWithAnimation:(BOOL)animation {
    if (animation) {
        __weak typeof(self) wSelf = self; // typeof() 一元运算 可以根据（）内的变量自动识别并返回其数据类型。
        _sourceView.alpha = 1.0f;
        [UIView animateWithDuration:0.2f animations:^{
            __strong typeof(self) sSelf = wSelf;
            sSelf->_sourceView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            __strong typeof(self) sSelf = wSelf;
            [sSelf->_sourceView removeFromSuperview];
        }];
    }
    else {
        [_sourceView removeFromSuperview];
    }
    
    _lastSelectedItemView.selected = NO;
}

- (void)p_tapInView:(UITapGestureRecognizer *)tap {
    
    OKBMenuItemView *itemView = (OKBMenuItemView *)tap.view;
    itemView.selected = !itemView.selected;
    
    if (_lastSelectedItemView == itemView && itemView.selected == NO) { // 同一个，并且已经选中，删除视图
        [self dismissSourceViewWithAnimation:YES];
    }
    else {
        UIView *tmp = nil;
        CGFloat height = 0.f;
        
        if ([self.dataSource respondsToSelector:@selector(menuView:sourceViewInItemAtIndex:)]) {
            tmp = [self.dataSource menuView:self sourceViewInItemAtIndex:tap.view.tag];
        }
        if ([self.dataSource respondsToSelector:@selector(menuView:heightForSourceViewAtIndexPath:)]) {
            height = [self.dataSource menuView:self heightForSourceViewAtIndexPath:tap.view.tag];
        }
        if (tmp && height) {
            
            if (_sourceView.superview) {
                [self dismissSourceViewWithAnimation:NO];
            }
            
            // QUESTION : 是否要加到 window 上？
            UIWindow *window = window4Show();
            NSAssert(window != nil, @"No window for add menu view");
            
            CGPoint originInWindow = [self.superview convertPoint:self.frame.origin toView:window];
            
            CGRect frame = CGRectZero;
            frame.origin = CGPointMake(originInWindow.x, CGRectGetHeight(self.frame) + originInWindow.y);
            frame.size = CGSizeMake(CGRectGetWidth(self.frame), height);
            tmp.frame = frame;
            
            tmp.alpha = 0.0f;
            
            [window addSubview:tmp];
            
            [UIView animateWithDuration:0.2f animations:^{
                tmp.alpha = 1.0f;
            }];
            
            _sourceView = tmp;
        }
        
        _lastSelectedItemView = itemView;
    }
    
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectItemAtIndexPath:)]) {
        [self.delegate menuView:self didSelectItemAtIndexPath:tap.view.tag];
    }
}

- (NSInteger)selectedItemIndex {
    return [_itemViewArr indexOfObject:_lastSelectedItemView];
}

- (void)p_layoutUI {
    OKBMenuItemView *cursor = nil;
    OKBMenuItemView *firstView = _itemViewArr.firstObject;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.top.equalTo(self);
    }];
    
    cursor = firstView;
    
    for (int i = 1; i < _num; i++) {
        OKBMenuItemView *tmp = _itemViewArr[i];
        [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cursor.mas_right);
            make.bottom.top.equalTo(self);
            make.width.equalTo(cursor);
        }];
        cursor = tmp;
    }
    
    [cursor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}

- (OKBMenuItemView *)menuItemViewAtIndex:(NSInteger)index {
    NSAssert(index < _num, @"The menu title to be updated is out of bounds");
    return [_itemViewArr objectAtIndex:index];
}

@end
