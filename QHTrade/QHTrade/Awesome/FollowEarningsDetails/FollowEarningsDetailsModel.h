//
//  FollowEarningsDetailsModel.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowEarningsDetailsModel : NSObject
@property(nonatomic,copy) NSString* userName;// 				昵称
@property(nonatomic,copy) NSString* ID;//					id
@property(nonatomic,copy) NSString* gender;//				性别 1 男 2女 3其他
@property(nonatomic,copy) NSString* incomeRate;//			收益率
@property(nonatomic,copy) NSString* balance; //balance				总资产
@property(nonatomic,copy) NSString* totalIncome; //			总收益
@property(nonatomic,copy) NSString* positionRate;//			仓位使用率
@property(nonatomic,copy) NSString* positionCount;//			持仓手数
@property(nonatomic,copy) NSString* userImg; //				头像key
@property(nonatomic,strong) NSArray* okamiList;//			正在跟单列表
@end
