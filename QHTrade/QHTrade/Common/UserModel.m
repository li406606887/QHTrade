//
//  UserModel.m
//  QHTrade
//
//  Created by user on 2017/8/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             };
}

@end
