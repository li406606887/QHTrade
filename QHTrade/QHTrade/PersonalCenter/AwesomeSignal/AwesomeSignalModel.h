//
//  AwesomeSignalModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwesomeSignalModel : NSObject
@property (nonatomic,strong) NSString *title;//标题
@property (nonatomic,strong) NSString *userName;//牛人名字

//1、title             标题
//2、alert             内容
//3、futuresName       合约名称
//4、direction         下单方向 1买入开仓 2卖出平仓 3卖出开仓 4买入平仓
//5、volume            手数
//6、tradeTime         下单时间
//7、userName          牛人名称

@property (nonatomic,strong) NSString *futuresName;//合约名称
@property (nonatomic,strong) NSString *direction;//下单方向
@property (nonatomic,strong) NSString *volume;//下单手数
@property (nonatomic,strong) NSString *tradeTime;//下单时间
@property (nonatomic,strong) NSString *price;//下单价格

@property (nonatomic,strong) NSString *tradeStateStr;//交易状态

@end
