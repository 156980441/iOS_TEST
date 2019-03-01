//
//  LayoutSubViewsVC.h
//  Demo
//
//  Created by fanyl on 2019/1/24.
//  Copyright © 2019年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 https://blog.csdn.net/u013027894/article/details/79199021
 
 - (void)layoutSubViews
 
 The default implementation of this method does nothing on iOS 5.1 and earlier. Otherwise, the default implementation uses any constraints you have set to determine the size and position of any subviews.
 
 Subclasses can override this method as needed to perform more precise layout of their subviews. You should override this method only if the autoresizing and constraint-based behaviors of the subviews do not offer the behavior you want. You can use your implementation to set the frame rectangles of your subviews directly.
 
 You should not call this method directly. If you want to force a layout update, call the setNeedsLayout method instead to do so prior to the next drawing update. If you want to update the layout of your views immediately, call the layoutIfNeeded method.
 
 那么，layoutSubviews什么情况下会被调用呢？

 直接调用setLayoutSubviews。（这个在上面苹果官方文档里有说明）
 addSubview的时候。
 当view的frame发生改变的时候。
 滑动UIScrollView的时候。
 旋转Screen会触发父UIView上的layoutSubviews事件。
 改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件。
 
 当view的fram的值为0的时候，addSubview也不会调用layoutSubviews的。

 */
@interface LayoutSubViewsVC : UIViewController

@end
