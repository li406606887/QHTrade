//
//  TradeRecordModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeRecordModel : NSObject

@property (nonatomic,strong) NSString *instrumentId;
@property (nonatomic,strong) NSString *instrumentidCh;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *volume;
@property (nonatomic,strong) NSString *direction;
@property (nonatomic,strong) NSString *offsetflag;
@property (nonatomic,strong) NSString *tradedatetime;
/*
 1、instrumentId          合约代码
 2、instrumentidCh        合约中文名称
 2、price                 价格
 3、volume                手数
 4、direction             买卖方向（0-Buy-买；1-Sell-卖）
 5、offsetflag            开平标志（0开仓；1平仓；2强平；3平今；4平昨；5强减；6本地强平；）
 6、tradedatetime         交易时间
 */
@end
