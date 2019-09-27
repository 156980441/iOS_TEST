//
//  OKBMenuPopViewPrivateHeader.h
//  YLDropMenuTest
//
//  Created by fanyl on 2019/9/27.
//  Copyright © 2019 fanyl. All rights reserved.
//

#ifndef OKBMenuPopViewPrivateHeader_h
#define OKBMenuPopViewPrivateHeader_h

@class OKBMenuPopViewController, OKBMenuItemView;

@protocol OKBMenuPopViewControllerDelegate <NSObject>

- (void)menuPopViewController:(OKBMenuPopViewController *)vc
           renderMenuItemView:(OKBMenuItemView *)menuItemView
                     userInfo:(id)userdata;

@end


@interface OKBMenuPopViewController (Private)
- (void)setMenuViewDelegate:(id<OKBMenuPopViewControllerDelegate>)delegte;
@end



#endif /* OKBMenuPopViewPrivateHeader_h */
