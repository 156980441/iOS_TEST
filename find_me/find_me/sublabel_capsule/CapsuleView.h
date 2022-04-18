//
//  CapsuleView.h
//  find_me
//
//  Created by yunlong on 2022/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapsuleView : UIView
@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) UIEdgeInsets insets;
@end

NS_ASSUME_NONNULL_END
