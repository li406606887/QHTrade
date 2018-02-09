//
//  AwesomeModel.h
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwesomeModel : NSObject
@property(nonatomic,copy) NSString* balance;//余额
@property(nonatomic,copy) NSString* beginDate;//计划开始时间
@property(nonatomic,copy) NSString* dayNum;//完成天数
@property(nonatomic,copy) NSString* endDate;//计划结束时间
@property(nonatomic,copy) NSString* incomeRate;//收益率
@property(nonatomic,copy) NSString* lowestMoney;//最低交易金
@property(nonatomic,copy) NSString* positionRate;//仓位使用率
@property(nonatomic,copy) NSString* praiseCount;//点赞数量
@property(nonatomic,copy) NSString* subNumber;//订阅数
@property(nonatomic,copy) NSString* todayIncomeRate;//今日收益率
@property(nonatomic,copy) NSString* traderDescription;// 操盘说明
@property(nonatomic,copy) NSString* userId;//用户ID
@property(nonatomic,copy) NSString* userImg;//头像key
@property(nonatomic,copy) NSString* userName;//用户昵称
@property(nonatomic,copy) NSString* isFollows;//是否跟单 0否 1已跟单
@property(nonatomic,copy) NSString* totalTradeNum;//交易总手数
@property(nonatomic,copy) NSString* singleMaxIncome;//单笔最大盈利
@property(nonatomic,copy) NSString* winRate;//胜率
@property(nonatomic,copy) NSString* referenceIncomeRate;//参考收益率
@property(nonatomic,copy) NSString *labels;//标签  标签1,标签2,标签3,标签4
@property(nonatomic,copy) NSString *netWorthToday;//最新净值
@property(nonatomic,copy) NSString *annualYield;//年化收益率
@property(nonatomic,assign) CGFloat nameWidth;

@end
