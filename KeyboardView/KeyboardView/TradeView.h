//
//  TradeView.h
//  KeyboardView
//
//  Created by fanyl on 2019/10/22.
//  Copyright © 2019 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TradeView : UIView
@property (nonatomic, strong) UITextField *priceTF;
@property (nonatomic, strong) UITextField *amountTF;
@property (nonatomic, strong) UILabel *warningLbl;
@end

NS_ASSUME_NONNULL_END
