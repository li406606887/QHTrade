//
//  HistorySignalModel.h
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistorySignalModel : NSObject
@property(nonatomic,copy) NSString *instrumentId ;//           合约代码
@property(nonatomic,copy) NSString *instrumentidCh ;//     合约中文名称
@property(nonatomic,copy) NSString *price;//                 价格
@property(nonatomic,copy) NSString *volume;//              手数
@property(nonatomic,copy) NSString *direction;//               买卖方向（0-Buy-买；1-Sell-卖）
@property(nonatomic,copy) NSString *offsetflag;//          开平标志（0开仓；1平仓；2强平；3平今；4平昨；5强减；6本地强平；）
@property(nonatomic,copy) NSString *tradedatetime;//           交易时间

@end
