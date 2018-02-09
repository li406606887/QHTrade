//
//  MyPositionsViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface MyPositionsViewModel : BaseViewModel

@property (nonatomic,strong) NSString *userId;

@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@property(nonatomic,strong)NSMutableArray * warehouseDataArr;//持仓数据数组

@property (nonatomic,strong) RACCommand *warehouseCommand;

@property (nonatomic,strong)RACCommand * tradeRecordCommand;//

@property(nonatomic,strong)NSMutableArray * tradeRecordDataArr;//交易记录数据数组



@end
