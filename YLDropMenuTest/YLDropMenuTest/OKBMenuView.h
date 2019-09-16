//
//  OKBDropMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBMenuView;
@class OKBMenuItemView;

@protocol OKBMenuViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInMenuView:(OKBMenuView *)menuView;
- (nullable OKBMenuItemView *)menuView:(OKBMenuView *)menuView viewForItemAtIndex:(NSInteger)index;
- (UIView *)menuView:(OKBMenuView *)menuView sourceViewInItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(OKBMenuView *)menuView heightForSourceViewAtIndexPath:(NSInteger)index;

@end


@protocol OKBMenuViewDelegate <NSObject>

@optional
- (void)menuView:(OKBMenuView *)menuView didSelectItemAtIndexPath:(NSInteger)index;

@end



@interface OKBMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak, nullable) id <OKBMenuViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <OKBMenuViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedItemIndex;

- (OKBMenuItemView *)menuItemViewAtIndex:(NSInteger)index;

- (void)dismissSourceViewWithAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
