//
//  YLTableViewUtil.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLTableViewUtil : NSObject

+ (UITableView*)getTableView:(UITableViewStyle)style
                   cellClass:(Class)cellClass
                  identifier:(NSString*)identifier;

@end
