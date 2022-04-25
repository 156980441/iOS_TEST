//
//  CountryTVCell.h
//  find_me
//
//  Created by yunlong on 2022/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryTVCell : UITableViewCell
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *displayStr;
@end

NS_ASSUME_NONNULL_END
