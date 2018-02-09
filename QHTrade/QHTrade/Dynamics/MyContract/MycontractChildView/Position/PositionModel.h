//
//  PositionModel.h
//  QHTrade
//
//  Created by user on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionModel : NSObject
@property(nonatomic,copy)NSString *contractName;//合约名称
@property(nonatomic,assign)BOOL moreEmpty;//多空
@property(nonatomic,copy)NSString *numberHand;//手数
@property(nonatomic,copy)NSString *canUsed;//可用
@property(nonatomic,copy)NSString *averageOpen;//开仓均价
@property(nonatomic,copy)NSString *chasesGains;//逐笔浮盈
@end
