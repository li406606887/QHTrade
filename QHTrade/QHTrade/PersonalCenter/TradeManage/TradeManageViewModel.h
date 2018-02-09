//
//  TradeManageViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface TradeManageViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *refreshFollowUISubject;//刷新跟单UI

@property(nonatomic,strong)NSMutableArray * dataArray;//正在跟单数据数组

@property (nonatomic,strong)RACCommand * refreshDataCommand;//正在跟单刷新数据

@property (nonatomic,strong)RACCommand * historyDataCommand;//历史跟单刷新数据 tpye 0

@property(nonatomic,strong)RACSubject *refreshHistoryUISubject;//刷新历史UI

@property(nonatomic,strong)NSMutableArray * historyDataArr;//历史跟单数据数组

@property (nonatomic,strong) RACCommand *nextPageCommand;//下一页

@property (nonatomic,strong) RACSubject *cancelBtnClick;//按钮->取消跟单

@property (nonatomic,strong) RACCommand *cancelCommand;//取消跟单

@property (nonatomic,strong) RACCommand *evaluateCommand;//新增评论

@end
