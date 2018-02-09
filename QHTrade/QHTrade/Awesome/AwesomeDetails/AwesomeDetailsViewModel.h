//
//  AwesomeDetailsViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "AwesomeModel.h"

@interface AwesomeDetailsViewModel : BaseViewModel
@property(nonatomic,strong) RACCommand *investorPositionCommand;//他的持仓
@property(nonatomic,strong) RACSubject *investorPositionSubject;
@property(nonatomic,strong) NSMutableArray *investorArray;

@property(nonatomic,strong) RACCommand *awesomeInfoCommand;//牛人信息
@property(nonatomic,strong) RACSubject *awesomeRefreshUISubject;

@property(nonatomic,strong) RACCommand *tradeSignalsCommand;//交易信号
@property(nonatomic,strong) RACSubject *tradeSignalsRefreshUISubject;
@property(nonatomic,strong) RACSubject *lookAllHistorySignalSubject;
@property(nonatomic,strong) NSMutableArray *tradingSignalsArray;

@property(nonatomic,strong) RACSubject *followEarningSubject;//跟单按钮

@property(nonatomic,strong) RACCommand *EvaluationCommand;//评论数据
@property(nonatomic,strong) RACSubject *refreshEvaluationSubject;//评论
@property(nonatomic,strong) NSMutableArray *evaluationArray;

@property(nonatomic,strong) RACCommand *getTradeAnalysisDataCommand;
@property(nonatomic,strong) RACSubject *refreshTradeAnalysisSubject;

@property(nonatomic,strong) RACSubject *instructionsRefreshUISubject;
@property(nonatomic,strong) RACSubject *tradersInstructionsOpenSubject;//操作说明展开
@property(nonatomic,strong) RACSubject *earningsSumDataSubject;//收益折现图数据发送
@property(nonatomic,assign) CGFloat tradersInstructionsHeight;//个人说明内容高度;
@property(nonatomic,copy  ) NSString *tradersInstructions;//牛人个人说明内容;

@property(nonatomic,strong) RACSubject *gotoLoginSubject;

@property(nonatomic,strong) AwesomeModel* model;
@property(nonatomic,copy  ) NSString* awesomeID;

@property(nonatomic,strong) RACSubject *refreshUI;
@property(nonatomic,strong) RACSubject *refreshEndSubject;//刷新结束
@property(nonatomic,strong) RACSubject *promptClickSubject;//提示点击

@property(nonatomic,strong) RACSubject *switchSegmentedSubject;//segmentedClick点击事件
@property(nonatomic,assign) int segmentedControlIndex;//segmented 选中index

@property(nonatomic,assign) int state;//跟单状态
@end
