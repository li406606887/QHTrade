//
//  NotificationModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/8/14.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject
@property (nonatomic,strong) NSString *msgType;
@property (nonatomic,strong) NSString *skipType;
@property (nonatomic,strong) NSString *outUrl;
@property (nonatomic,strong) NSString *pageId;
//1、msgType           消息类型:1新设备登录 2通知消息
//2、skipType          跳转类型:1内部链接 2外部链接
//3、outUrl            外部链接URL
//4、pageId            内部链接ID：1消息列表 2牛人信号
@end
