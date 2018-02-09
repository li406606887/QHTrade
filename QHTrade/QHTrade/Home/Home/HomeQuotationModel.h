//
//  HomeQuotationModel.h
//  QHTrade
//
//  Created by user on 2017/8/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeQuotationModel : NSObject
@property(nonatomic,copy) NSString* ContractID;//合约名称
@property(nonatomic,copy) NSString* QLastPrice;//最新价格
@property(nonatomic,copy) NSString* QChangeValue;//涨跌
@property(nonatomic,copy) NSString* QChangeRate;//涨幅
@end
