//
//  TradeStatisticViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface TradeStatisticViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@property(nonatomic,strong)NSMutableArray * dataArray;//正在跟单数据数组

@property (nonatomic,strong)RACCommand * refreshDataCommand;//正在跟单刷新数据



@end
