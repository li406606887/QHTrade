//
//  MessageModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject
@property (nonatomic,strong) NSString *timeString;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *contentString;

@end
