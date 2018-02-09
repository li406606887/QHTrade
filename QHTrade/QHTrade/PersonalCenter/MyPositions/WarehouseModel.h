//
//  WarehouseModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WarehouseModel : NSObject
@property (nonatomic,strong) NSString *instrumentId;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *posiDirection;
@property (nonatomic,strong) NSString *openAmount;
@property (nonatomic,strong) NSString *positionProfit;
@property (nonatomic,strong) NSString *name;
/*
1、instrumentId          合约代码
2、position              手数
3、posiDirection         多空 2多 3空
4、openAmount            开仓均价
5、positionProfit        持仓盈亏
 */
@end
