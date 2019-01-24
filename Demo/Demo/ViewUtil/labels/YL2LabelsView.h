//
//  YL2LabelsView.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YL2LabelsView : UIView

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, assign) CGFloat space; // 两个 Label 之间的间距， default 0.0f
@property (nonatomic, assign) YLLabelsViewLayoutAlignment layoutAlignment; // default OKBLabelsViewLayoutAlignmentCenter
@property (nonatomic, assign) YLLabelsViewLayoutDirection layoutDirection; // default OKBLabelsViewLayoutDirection_horizontal

@end

YL2LabelsView* get2LabelsView(void);
