//
//  FollowSetingViewModel.h
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "FollowSetingModel.h"
#import "AwesomeModel.h"

@interface FollowSetingViewModel : BaseViewModel
@property(nonatomic,strong) FollowSetingModel *setingModel;
@property(nonatomic,strong) AwesomeModel *model;
@property(nonatomic,strong) RACCommand *followEarningSumbitCommand;
@property(nonatomic,strong) RACSubject *valueChangeSubject;
@property(nonatomic,strong) RACSubject *sureClickSubject;
@property(nonatomic,strong) RACSubject *successPriceClick;
@property(nonatomic,strong) RACSubject *gotoLoginSubject;
@property(nonatomic,strong) RACSubject *gotoBindCTPAcountSubject;
@property(nonatomic,strong) RACSubject *sumbitSuccessfulSubject;

@property(nonatomic,strong) RACCommand *getAwesomePositionCommand;
@property(nonatomic,strong) RACSubject *refreshPositionUISubject;
@property(nonatomic,strong) RACSubject *popViewControllerSubject;
@property(nonatomic,strong) NSMutableArray *dataArray;//牛人持仓数据
@end
