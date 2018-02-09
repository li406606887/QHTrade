//
//  FollowSetingModel.h
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowSetingModel : NSObject
@property(nonatomic,assign) NSString* numScale;
@property(nonatomic,assign) long priceType;
@property(nonatomic,assign) long jumpPoint;
+(NSString *)proportion:(NSString*)index;
+(NSString *)successPrice:(long)index;
+(NSString *)hops:(long)index;
@end
