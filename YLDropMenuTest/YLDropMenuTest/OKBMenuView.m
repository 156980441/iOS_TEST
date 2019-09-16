//
//  OKBDropMenuView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBMenuView.h"
#import "OKBMenuItemView.h"
#import <Masonry/Masonry.h>


@interface OKBMenuView ()
{
    NSArray<OKBMenuItemView *> *_itemViewArr;
    NSInteger _num;
    UIView *_showView;
    OKBMenuItemView *_lastSelectedItemView;
}
@end

@implementation OKBMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
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

- (void)p_tapInView:(UITapGestureRecognizer *)tap {
    
    OKBMenuItemView *itemView = (OKBMenuItemView *)tap.view;
    
    if (_lastSelectedItemView == itemView && itemView.selected) { // 同一个，并且已经选中，删除视图
        
        __weak typeof(self) wSelf = self; // typeof() 一元运算 可以根据（）内的变量自动识别并返回其数据类型。
        _showView.alpha = 1.0f;
        [UIView animateWithDuration:0.2f animations:^{
            __strong typeof(self) sSelf = wSelf;
            sSelf->_showView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            __strong typeof(self) sSelf = wSelf;
            [sSelf->_showView removeFromSuperview];
        }];
        
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
            
            [_showView removeFromSuperview];
            
            CGRect frame = CGRectZero;
            frame.origin = CGPointMake(self.frame.origin.x, CGRectGetMaxY(self.frame));
            frame.size = CGSizeMake(CGRectGetWidth(self.frame), height);
            tmp.frame = frame;
            
            tmp.alpha = 0.0f;
            
            [self.superview addSubview:tmp];
            
            [UIView animateWithDuration:0.2f animations:^{
                tmp.alpha = 1.0f;
            }];
            
            _showView = tmp;
        }
        
        _lastSelectedItemView.selected = NO;
        _lastSelectedItemView = itemView;
    }
    
    itemView.selected = !itemView.selected;
    
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
