//
//  PopContainerVC.h
//  PopContainerVC
//
//  Created by fanyl on 2020/3/9.
//  Copyright © 2020 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopContainerVC : UIViewController

@property (nonatomic, strong, readonly) UIViewController* contentVC;

- (void)setContentVC:(UIViewController *)vc
            atOffset:(CGFloat)offset
              height:(CGFloat)height
            animated:(BOOL)animated
          completion:(nullable dispatch_block_t)completion;

- (void)clearContentVCAnimated:(BOOL)animated
                    completion:(nullable dispatch_block_t)completion;
@end

NS_ASSUME_NONNULL_END
