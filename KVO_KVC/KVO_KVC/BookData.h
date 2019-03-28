//
//  BookData.h
//  KVO_KVC
//
//  Created by fanyunlong on 5/30/16.
//  Copyright © 2016 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthorData.h"

@interface BookData : NSObject
{
    NSString * bookName;
    float price;
    AuthorData * author;
}
@end
