//
//  UserModel.h
//  QHTrade
//
//  Created by user on 2017/8/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy) NSString *userName;//昵称
@property(nonatomic,copy) NSString *ID;//id
@property(nonatomic,copy) NSString *gender;//性别 1 男 2女 3其他
@property(nonatomic,copy) NSString *incomeRate;//收益率
@property(nonatomic,copy) NSString *balance;//总资产
@property(nonatomic,copy) NSString *diamond;//钻石数
@property(nonatomic,copy) NSString *totalIncome;//总收益
@property(nonatomic,copy) NSString *positionRate;//仓位使用率
@property(nonatomic,copy) NSString *positionCount;//持仓手数
@property(nonatomic,copy) NSString *state;//状态 1未绑定交易账号 2未登录 3已登录 4不显示登录提示
@property(nonatomic,copy) NSString *userImg;//头像key
@property(nonatomic,copy) NSString *mobile;//手机号码
@property(nonatomic,copy) NSString *ctpAccount;//交易账号
@property(nonatomic,copy) NSString *fierce;//是否为牛人 1是2否
@property(nonatomic,copy) NSString *isFollows;//是否有跟单 0否 1是
@property(nonatomic,copy) NSString *brokerId;//经纪公司代码
@property(nonatomic,copy) NSString *isAccount;//是否点击过开户 0未点击 1点击开户
@property(nonatomic,copy) NSString *niuUserName;//牛人昵称
@property(nonatomic,copy) NSString *niuUserImg;//牛人头像
@property(nonatomic,copy) NSString *documentary;//跟单状态 1自动跟单 2手动跟单
@property(nonatomic,copy) NSString *numScale;//跟单手数比例
@property(nonatomic,copy) NSString *jumpPoint;//跟单跳点
@property(nonatomic,copy) NSString *priceType;//成交价类型 1牛人成交价格 2合约市价
@end
