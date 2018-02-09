//
//  FollowEarningsDetailsViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface FollowEarningsDetailsViewModel : BaseViewModel
@property(nonatomic,strong) RACSubject *followRarningsSubject;//跟单详情数据发送
@property(nonatomic,strong) RACCommand *getUserInfoCommand;//根据id获取个人信息
@property(nonatomic,strong) RACSubject *refreshUISubject;//刷新UI
@property(nonatomic,strong) RACSubject *awesomeClickSubject;//点击查看牛人信息
@property(nonatomic,strong) NSDictionary *dataDictionary;
@property(nonatomic,copy  ) NSString* userID;


@property(nonatomic,strong) RACCommand *curveGraphDayCommand;//曲线图
@property(nonatomic,strong) RACCommand *curveGraphMonthCommand;//曲线图
@property(nonatomic,strong) RACSubject *refreshCurveGraphsubject;//曲线图
@property(nonatomic,strong) NSMutableArray *dayDataArray;//日收益图
@property(nonatomic,strong) NSMutableArray *monthDataArray;//月收益图
@end
