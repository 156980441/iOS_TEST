//
//  OKBMultiLevelDropDownMenuView.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/11.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OKBMultiLevelMenuProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKBMultiLevelDropDownMenuView : UIView
- (instancetype)initWithFrame:(CGRect)frame tableViewNum:(NSInteger)num;
- (void)reloadDataWithDataSource:(id<OKBMultiLevelMenuProtocol>)dataSource;
@end

NS_ASSUME_NONNULL_END
