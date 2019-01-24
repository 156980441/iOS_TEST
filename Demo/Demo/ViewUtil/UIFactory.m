//
//  UIFactory.m
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (UIButton*)defaultButton {
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"--.--" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 12;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = YLColor_Disable;
    return btn;
}

+ (UILabel*)defaultLabel {
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    lbl.textColor = YLColor_Subtitle;
    lbl.font = [UIFont systemFontOfSize:14];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.userInteractionEnabled = YES;
    lbl.text = @"--.--";
    lbl.numberOfLines = 0;
    lbl.adjustsFontSizeToFitWidth = YES;
    return lbl;
}

+ (UITextView*)defaultTextView {
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.text = @"--.--";
    textView.textColor = YLColor_Subtitle;
    return textView;
}

+ (UITextField*)defaultTextField {
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.textColor = YLColor_Title;
    return textField;
}

+ (UITableView*)getTableView:(UITableViewStyle)style
                   cellClass:(Class)cellClass
                  identifier:(NSString*)identifier {
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    [tableView registerClass:[cellClass class] forCellReuseIdentifier:identifier];
    tableView.tableFooterView = UIView.new; // 去掉 cell 或者 section 的多余线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉 cell 分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    tableView.separatorColor = [UIColor grayColor];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滑动后让键盘消失
    return tableView;
}

@end
