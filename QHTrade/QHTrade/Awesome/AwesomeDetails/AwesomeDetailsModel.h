//
//  AwesomeDetailsModel.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwesomeDetailsModel : NSObject
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* subNumber;
@property(nonatomic,copy) NSString* lowestMoney;
@property(nonatomic,copy) NSString* incomeRate;
@property(nonatomic,copy) NSString* positionRate;
@property(nonatomic,copy) NSString* beginDate;
@property(nonatomic,copy) NSString* endDate;
@property(nonatomic,copy) NSString* dayNum;
@property(nonatomic,copy) NSString* todayIncomeRate;
@property(nonatomic,copy) NSString* praiseCount;
@property(nonatomic,copy) NSString* traderDescription;
@property(nonatomic,copy) NSString* userImg;
@property(nonatomic,copy) NSString* isPrise;
@end
