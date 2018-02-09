//
//  QHRequestModel.h
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHRequestModel : NSObject
@property(nonatomic,strong)id content;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,copy)NSString *status;
@end
