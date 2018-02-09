//
//  TradeAccountViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface TradeAccountViewModel : BaseViewModel

@property (nonatomic,strong) NSString *accountNumStr;
@property (nonatomic,strong) NSString *passWordStr;
@property (nonatomic,strong) NSString *brokerId;
@property (nonatomic,strong, readonly) RACCommand *loginCommand;//登录
@property (nonatomic,strong, readonly) RACSignal *loginBtnEnable;
@property (nonatomic,assign) BOOL isAgree;

@property (nonatomic,strong) RACSubject *tickClickSubject;
@property (nonatomic,strong) RACSubject *searchSubject;
@property (nonatomic,strong) RACSubject *statementSubject;//声明点击

@property (nonatomic,strong) RACCommand *requestCommand;//开户公司

@end
