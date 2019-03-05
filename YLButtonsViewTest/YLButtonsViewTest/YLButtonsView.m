//
//  YLButtonsView.m
//  YLButtonsViewTest
//
//  Created by fanyl on 2019/3/4.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import "YLButtonsView.h"
#import <Masonry/Masonry.h>

@interface YLButtonsView ()
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, strong) NSArray<UIButton*>* buttons;
@end

@implementation YLButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithButtons:1];
}

- (instancetype)initWithButtons:(NSUInteger)buttonNums {
    NSMutableArray* titles = [NSMutableArray arrayWithCapacity:buttonNums];
    for (int i = 0; i < buttonNums; i++) {
        [titles addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return [self initWithFrame:CGRectZero titles:titles images:nil internalSpace:0];
}

- (instancetype)initWithFrame:(CGRect)frame buttons:(NSArray<UIButton*>* const)buttons internalSpace:(CGFloat)space {
    self = [super initWithFrame:frame];
    if (self) {
        _space = space;
        _buttons = buttons;
        _verticalDisplay = NO;
        [self yl_configUI];
    }
    return self;
    
}

- (void)yl_configUI {
    if (self.verticalDisplay == NO) {
        // 第一个
        UIButton *lastBtn = self.buttons.firstObject;
        lastBtn.tag = 0;
        [lastBtn addTarget:self action:@selector(yl_btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lastBtn];
        [lastBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.bottom.and.top.equalTo(self).offset(0);
        }];
        
        CGFloat space = self.space;
        
        for (NSInteger i = 1; i < self.buttons.count; i++ ) {
            UIButton* bt = self.buttons[i];
            bt.tag = i;
            [bt addTarget:self action:@selector(yl_btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bt];
            [bt mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).mas_offset(space);
                make.top.and.bottom.equalTo(lastBtn);
                make.width.equalTo(lastBtn.mas_width);
            }];
            lastBtn = bt;
        }
        
        // 最后一个
        [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0);
        }];
    }
    else {
        // 第一个
        UIButton *lastBtn = self.buttons.firstObject;
        lastBtn.tag = 0;
        [lastBtn addTarget:self action:@selector(yl_btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lastBtn];
        [lastBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self).offset(0).priority(300); // 设置优先级，防止出现 Masonry 警告
            make.right.equalTo(self).offset(0).priority(300);
            make.top.equalTo(self).offset(0).priority(300);
        }];
        
        CGFloat space = self.space;
        
        for (NSInteger i = 1; i < self.buttons.count; i++ ) {
            UIButton* bt = self.buttons[i];
            bt.tag = i;
            [bt addTarget:self action:@selector(yl_btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bt];
            [bt mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastBtn.mas_bottom).mas_offset(space).priority(300);
                make.left.and.right.equalTo(lastBtn).priority(300);
                make.width.equalTo(lastBtn.mas_width).priority(300);
            }];
            lastBtn = bt;
        }
        
        // 最后一个，注意这里是 mas_makeConstraints，或者 mas_updateConstraints，表示添加
        [lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(0).priority(300);
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString*>* const)titles images:(nullable NSArray<UIImage*>*)images internalSpace:(CGFloat)space {
    NSMutableArray* bts = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0; i < titles.count; i++) {
        UIButton* bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:titles[i] forState:UIControlStateNormal];
        if (images.count > 0) {
            NSAssert(titles.count == images.count, @"ERROR:titles.count != images.count");
            [bt setImage:images[i] forState:UIControlStateNormal];
        }
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bts addObject:bt];
    }
    return [self initWithFrame:frame buttons:bts internalSpace:space];
}

- (void)setButtonTitle:(NSString*)title index:(NSUInteger)index forState:(UIControlState)state {
    NSAssert(index < self.buttons.count, @"ERROR:index out of array");
    if (index < self.buttons.count) {
        [self.buttons[index] setTitle:title forState:state];
    }
}


- (void)yl_btnPressed:(UIButton*)sender {
    if (self.block) {
        self.block(sender, sender.tag);
    }
}

- (void)setVerticalDisplay:(BOOL)verticalDisplay {
    if (_verticalDisplay != verticalDisplay) {
        _verticalDisplay = verticalDisplay;
        [self yl_configUI];
    }
}

- (UIButton*)buttonOfIndex:(NSUInteger)index {
    NSAssert(index < self.buttons.count, @"ERROR:index out of array");
    if (index < self.buttons.count) {
        return self.buttons[index];
    }
    else {
        return nil;
    }
}

- (void)insertButton:(UIButton*)button atIndex:(NSUInteger)index {
    NSAssert(index <= self.buttons.count, @"ERROR:index greater than array count");
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.buttons];
    [tmp insertObject:button atIndex:index];
    self.buttons = [NSArray arrayWithArray:tmp];
    [self yl_configUI];
}

- (NSArray<UIButton*>* const)buttonsArr {
    return self.buttons;
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%s", __func__);
#endif
}

@end
