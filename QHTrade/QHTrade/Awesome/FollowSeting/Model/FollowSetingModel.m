//
//  FollowSetingModel.m
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowSetingModel.h"

@implementation FollowSetingModel
+(NSString *)proportion:(NSString *)index{
    
    return index !=nil ? [@"1:" stringByAppendingString:index]: @"1:0.1";
}

+(NSString *)successPrice:(long)index {
    NSString *result ;
    switch (index) {
        case 0:
            result = @"牛人成交价";
            break;
        case 1:
            result = @"合约市价";
            break;
        default:
            break;
    }
    return result;
}
+(NSString *)hops:(long)index{
    NSString *result ;
    switch (index) {
        case 0:
            result = @"1点";
            break;
        case 1:
            result = @"2点";
            break;
        case 2:
            result = @"5点";
            break;
            
        default:
            break;
    }
    return result;
}
@end
