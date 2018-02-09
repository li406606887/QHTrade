//
//  FollowEarningChooseViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "AwesomeModel.h"
#import "FollowSetingModel.h"

@interface FollowEarningChooseViewModel : BaseViewModel
@property(nonatomic,strong) AwesomeModel *model;
@property(nonatomic,strong) RACCommand *followEarningSumbitCommand;

@property(nonatomic,strong) RACSubject *sumbitSuccessfulSubject;
@property(nonatomic,strong) RACSubject *gotoBuyDiamondSubject;
@property(nonatomic,strong) RACSubject *gotoBindCTPAcountSubject;
@property(nonatomic,strong) RACSubject *gotoLoginSubject;
@property(nonatomic,strong) RACSubject *cellClickSubject;
@property(nonatomic,strong) RACSubject *tableReloadSubject;
@property(nonatomic,strong) NSMutableDictionary *setingModelDic;
@property(nonatomic,assign) CGFloat nameWidth;
@end
