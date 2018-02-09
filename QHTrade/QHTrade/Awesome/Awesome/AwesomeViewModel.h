//
//  AwesomeViewModel.h
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface AwesomeViewModel : BaseViewModel
@property(nonatomic,strong) NSMutableArray *awesomeDataArray;
@property(nonatomic,strong) NSMutableArray *rookieDataArray;//新秀数据
@property(nonatomic,strong) NSMutableArray *followEarningsDataArray;//获取跟单收益榜
@property(nonatomic,strong) NSMutableArray *canFollowDataArray;//可跟单数据
@property(nonatomic,strong) RACCommand *followEarningsDataCommand;//获取跟单收益榜数据
@property(nonatomic,strong) RACCommand *awesomeDataCommand;//获取牛人数据
@property(nonatomic,strong) RACCommand *rookieDataCommand;//获取跟单收益榜数据
@property(nonatomic,strong) RACCommand *canDataCommand;//获取可跟随榜数据
@property(nonatomic,strong) RACSubject *followEarningsCellClick;//跟单收益榜cell点击
@property(nonatomic,strong) RACSubject *followEarningsRefreshDataSubject;//跟单收益榜数据刷新
@property(nonatomic,strong) RACSubject *awesomeCellClick;//牛人cell点击
@property(nonatomic,strong) RACSubject *awesomeRefreshDataSubject;//牛人cell点击
@property(nonatomic,strong) RACSubject *rookieRefreshDataSubject;
@property(nonatomic,strong) RACSubject *canRefreshDataSubject;
@property(nonatomic,strong) RACSubject *awesomeFollowActionClick;//跟单按钮点击
@property(nonatomic,assign) int awesomePageNum;
@property(nonatomic,assign) int rookiePageNum;
@property(nonatomic,assign) int followEarningsPageNum;
@property(nonatomic,assign) int canPageNum;
@end
