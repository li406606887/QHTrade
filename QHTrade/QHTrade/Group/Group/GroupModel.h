//
//  GroupModel.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property(nonatomic,copy) NSString* userId;//				用户ID
@property(nonatomic,copy) NSString* ID;//					记录ID
@property(nonatomic,copy) NSString* userName;//				用户名
@property(nonatomic,copy) NSString* userImg;//				用户头像
@property(nonatomic,copy) NSString* createTime;//			发布时间戳（毫秒）
@property(nonatomic,copy) NSString* priseCount;//			点赞数
@property(nonatomic,copy) NSString* stepCount;//			踩数量
@property(nonatomic,copy) NSString* state;//				用户操作记录 1未操作 2点赞 3踩
@property(nonatomic,copy) NSString* content;//				内容
@end
