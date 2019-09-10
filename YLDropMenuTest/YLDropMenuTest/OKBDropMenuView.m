//
//  OKBDropMenuView.m
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "OKBDropMenuView.h"
#import "OKBDropMenuItemView.h"
#import <Masonry/Masonry.h>


@interface OKBDropMenuView ()
{
    NSArray<OKBDropMenuItemView *> *_itemViewArr;
    NSInteger _num;
    UIView *_showView;
    OKBDropMenuItemView *_lastSelectedItemView;
}
@end

@implementation OKBDropMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInDropView:)]) {
        _num = [self.dataSource numberOfItemsInDropView:self];
    }
    NSMutableArray<OKBDropMenuItemView *> *tmp = [[NSMutableArray alloc] initWithCapacity:_num];
    for (int i = 0; i < _num; i ++) {
        if ([self.dataSource respondsToSelector:@selector(dropMenuView:viewForItemAtIndex:)]) {
            OKBDropMenuItemView *itemView = [self.dataSource dropMenuView:self viewForItemAtIndex:i];
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
    
    OKBDropMenuItemView *itemView = (OKBDropMenuItemView *)tap.view;
    
    if (_lastSelectedItemView == itemView && itemView.selected) { // 同一个，并且已经选中，删除视图
        [_showView removeFromSuperview];
    }
    else {
        UIView *tmp = nil;
        CGFloat height = 0.f;
        
        if ([self.dataSource respondsToSelector:@selector(dropMenuView:viewInItemAtIndex:)]) {
            tmp = [self.dataSource dropMenuView:self viewInItemAtIndex:tap.view.tag];
        }
        if ([self.dataSource respondsToSelector:@selector(dropMenuView:heightForViewAtIndexPath:)]) {
            height = [self.dataSource dropMenuView:self heightForViewAtIndexPath:tap.view.tag];
        }
        if (tmp && height) {
            
            [_showView removeFromSuperview];
            
            CGRect frame = CGRectZero;
            frame.origin = CGPointMake(self.frame.origin.x, CGRectGetMaxY(self.frame));
            frame.size = CGSizeMake(CGRectGetWidth(self.frame), height);
            tmp.frame = frame;
            [self.superview addSubview:tmp];
            _showView = tmp;
        }
        
        _lastSelectedItemView.selected = NO;
        _lastSelectedItemView = itemView;
    }
    
    itemView.selected = !itemView.selected;
    
    if ([self.delegate respondsToSelector:@selector(dropMenuView:didSelectItemAtIndexPath:)]) {
        [self.delegate dropMenuView:self didSelectItemAtIndexPath:tap.view.tag];
    }
}

- (void)p_layoutUI {
    OKBDropMenuItemView *cursor = nil;
    OKBDropMenuItemView *firstView = _itemViewArr.firstObject;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.top.equalTo(self);
    }];
    
    cursor = firstView;
    
    for (int i = 1; i < _num; i++) {
        OKBDropMenuItemView *tmp = _itemViewArr[i];
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

@end
