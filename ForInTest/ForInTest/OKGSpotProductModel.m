//
//  OKGSpotProductModel.m
//  AFNetworking
//
//  Created by fanyl on 2018/5/8.
//

#import "OKGSpotProductModel.h"

@implementation OKGSpotProductModel

+ (instancetype)randomProductModel {
    OKGSpotProductModel* model = [[OKGSpotProductModel alloc] init];
    model.quoteCurrency = @"BTC";
    return model;
}

@end
