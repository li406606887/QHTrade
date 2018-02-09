//
//  ContractModel.h
//  QHTrade
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContractModel : NSObject
@property(nonatomic,copy) NSString* ContractID;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* QLastPrice;
@property(nonatomic,copy) NSString* QChangeValue;
@property(nonatomic,copy) NSString* QChangeRate;
@property(nonatomic,copy) NSString* futuCode;
@end
