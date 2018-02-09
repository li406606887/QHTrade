//
//  HistorySignalViewModel.h
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface HistorySignalViewModel : BaseViewModel
@property(nonatomic,strong) RACCommand *getMonthSignalsCommand;//获取月份
@property(nonatomic,strong) RACCommand *tradeSignalsCommand;//交易信号
@property(nonatomic,strong) RACSubject *tradeSignalsRefreshUISubject;
@property(nonatomic,strong) NSMutableArray *tradingSignalsArray;//交易信号数组
@property(nonatomic,strong) NSMutableArray *tradingMonthArray;//交易月份数组
@property(nonatomic,copy) NSString *awesomeID;//牛人ID
@property(nonatomic,copy) NSString *month;//牛人ID
@end
