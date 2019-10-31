//
//  OKBPopContainerVC.h
//  OKBusiness
//
//  Created by fanyl on 2019/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKBPopContainerVC : UIViewController

- (void)setContentVC:(UIViewController *)contentViewController
            atOffset:(CGFloat)offset
              height:(CGFloat)height
            animated:(BOOL)animated
          completion:(dispatch_block_t)completion;

- (void)clearContentVCAnimated:(BOOL)animated
                    completion:(dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
