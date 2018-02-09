//
//  TradeAnalysisModel.h
//  QHTrade
//
//  Created by user on 2017/12/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeAnalysisModel : NSObject
@property(nonatomic,copy) NSString* preBalance;//期初权益
@property(nonatomic,copy) NSString* dayAvgBalance;//日均权益
@property(nonatomic,copy) NSString* balance;//期末权益
@property(nonatomic,copy) NSString* sectionProfit;//期间盈亏
@property(nonatomic,copy) NSString* annualYield;//年化收益率
@property(nonatomic,copy) NSString* netWorthTotal;//最新净值
@property(nonatomic,copy) NSString* withdrawalRateMax;//历史最大回撤率
@property(nonatomic,copy) NSString* withdrawalRate;//单日最大回撤
@property(nonatomic,copy) NSString* riskProfitRatio;//风险收益比
@property(nonatomic,copy) NSString* thirtyNetWorth;//近30日累计净值
@property(nonatomic,copy) NSString* totalNetDeposit;//净入金
@property(nonatomic,copy) NSString* tradeDayNum;//交易天数
@property(nonatomic,copy) NSString* totalCommission;//累计手续费
@property(nonatomic,copy) NSString* totalTradeNum;//交易总笔数
@property(nonatomic,strong) NSArray* incomeDay;//累计盈亏曲线
@property(nonatomic,strong) NSArray* incomeWeek;//周盈亏曲线
@property(nonatomic,strong) NSArray* incomeMonth;//月盈亏曲线
@property(nonatomic,strong) NSArray* transactionRatio;//品种成交偏好
@property(nonatomic,strong) NSArray* positionRatio;//品种持仓偏好
@end
