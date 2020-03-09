//
//  SectionHeaderView.h
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/7.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FoldTableViewCtrler.h"

NS_ASSUME_NONNULL_BEGIN

@interface SectionHeaderView : UIView <SectionHeaderViewProtocol>
@property (nonatomic, strong) UILabel *label;
- (void)setHighlight:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
