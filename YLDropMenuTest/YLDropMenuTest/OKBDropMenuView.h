//
//  OKBDropMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/9.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKBDropMenuView;
@class OKBDropMenuItemView;

@protocol OKBDropMenuViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInDropView:(OKBDropMenuView *)dropMenuView;
- (nullable OKBDropMenuItemView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewForItemAtIndex:(NSInteger)index;
- (UIView *)dropMenuView:(OKBDropMenuView *)dropMenuView viewInItemAtIndex:(NSInteger)index;
- (CGFloat)dropMenuView:(OKBDropMenuView *)dropMenuView heightForViewAtIndexPath:(NSInteger)index;

@end


@protocol OKBDropMenuViewDelegate <NSObject>
- (void)dropMenuView:(OKBDropMenuView *)dropMenuView didSelectItemAtIndexPath:(NSInteger)index;
@end

@interface OKBDropMenuView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak, nullable) id <OKBDropMenuViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <OKBDropMenuViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
