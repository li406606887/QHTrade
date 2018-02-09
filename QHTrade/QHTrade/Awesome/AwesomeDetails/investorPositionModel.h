//
//  investorPositionModel.h
//  QHTrade
//
//  Created by user on 2017/7/31.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface investorPositionModel : NSObject
@property(nonatomic,copy) NSString *instrumentId;
@property(nonatomic,copy) NSString *position;
@property(nonatomic,copy) NSString *posiDirection;
@property(nonatomic,copy) NSString *openAmount;
@property(nonatomic,copy) NSString *positionProfit;
@property(nonatomic,copy) NSString *available;
@end
