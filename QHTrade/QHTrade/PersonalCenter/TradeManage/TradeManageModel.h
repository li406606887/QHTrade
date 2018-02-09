//
//  TradeManageModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/14.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeManageModel : NSObject
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userImg;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *numScale;//跟单手数比例
@property (nonatomic,copy) NSString *jumpPoint;//跟单跳点
@property (nonatomic,copy) NSString *priceType;//成交价类型 1牛人成交价格 2合约市价
@end
