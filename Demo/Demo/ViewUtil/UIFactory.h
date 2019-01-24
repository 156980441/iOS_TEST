//
//  UIFactory.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFactory : NSObject

+ (UILabel*)defaultLabel;
+ (UIButton*)defaultButton;
+ (UITextView*)defaultTextView;
+ (UITextField*)defaultTextField;

+ (UITableView*)getTableView:(UITableViewStyle)style
                   cellClass:(Class)cellClass
                  identifier:(NSString*)identifier;



@end
