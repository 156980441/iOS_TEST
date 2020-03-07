//
//  FoldTableViewCtrler.h
//  FoldTableViewDemo
//
//  Created by fanyl on 2020/3/6.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoldTableViewDataSource : NSObject
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) NSString *cellId;
@property (nonatomic, strong) id dataType;
@property (nonatomic, assign) BOOL status; // 0 闭合，1打开
@property (nonatomic, copy) void (^renderCell)(UITableViewCell *cell, NSIndexPath *indexPath, id dataType);
@property (nonatomic, copy) void (^didSelectRow)(id);
@end

@interface FoldTableViewCtrlerParams : NSObject
@property (nonatomic, assign) UITableViewStyle style;
@property (nonatomic, strong, nullable) NSArray<FoldTableViewDataSource *> *dataSource;
@end

@interface FoldTableViewCtrler : NSObject
- (instancetype)initWithParams:(FoldTableViewCtrlerParams *)params;
@property (nonatomic, strong) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
