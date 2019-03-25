//
//  OKGSpotProductModel.h
//  AFNetworking
//
//  Created by fanyl on 2018/5/8.
//

#import <UIKit/UIKit.h>

@interface OKGSpotProductModel : NSObject

// from server
@property (nonatomic, assign) NSInteger baseCurrency;
@property (nonatomic, copy) NSString* quoteCurrency;

+ (instancetype)randomProductModel;

@end
