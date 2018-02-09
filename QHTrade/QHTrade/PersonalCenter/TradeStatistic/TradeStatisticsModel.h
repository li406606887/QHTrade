//
//  TradeStatisticsModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeStatisticsModel : NSObject

@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *totalIncome;
@property (nonatomic,strong) NSString *incomeRate;
@property (nonatomic,strong) NSString *lastDayIncome;
@property (nonatomic,strong) NSString *documentaryCount;
@property (nonatomic,strong) NSString *totalVolume;
@property (nonatomic,strong) NSString *dayNum;

/*
 1、balance               总资产
 2、totalIncome           总收益
 3、incomeRate            收益率
 4、lastDayIncome         上日收益
 5、documentaryCount      跟单人数
 6、totalVolume           交易总手数
 7、dayNum                交易时长
 */
@end
