//
//  DiamondRecordModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiamondRecordModel : NSObject

@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *diamond;
@property (nonatomic,strong) NSString *payTime;

/*
1、userId                用户ID
2、diamond               钻石数量
3、payTime               支付时间戳
 */
@end
