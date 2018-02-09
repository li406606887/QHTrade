//
//  AwesomeDetailsViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeDetailsViewModel.h"
#import "AwesomeModel.h"
#import "WarehouseModel.h"
#import "TradeRecordModel.h"
#import "CurveFigureModel.h"
#import "EvaluationModel.h"
#import "TradeAnalysisModel.h"

@implementation AwesomeDetailsViewModel
-(void)initialize{
    @weakify(self)
    [self.awesomeInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (x) {
            AwesomeModel *model = [AwesomeModel mj_objectWithKeyValues:x];
            self.tradersInstructions = model.traderDescription;
            [self.awesomeRefreshUISubject sendNext:model];
            [self.instructionsRefreshUISubject sendNext:model.traderDescription];
            [self.investorPositionCommand execute:nil];
        }
    }];
    
    [self.investorPositionCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.investorArray.count!= 0) {
            [self.investorArray removeAllObjects];
        }
        if(self.state==1){
            for (NSDictionary *data in x) {
                WarehouseModel *model = [WarehouseModel mj_objectWithKeyValues:data];
                model.openAmount = [NSString stringWithFormat:@"%.2f",[model.openAmount floatValue]];
                [self.investorArray addObject:model];
            }
        }else{
            for (NSDictionary *data in x) {
                WarehouseModel *model = [WarehouseModel mj_objectWithKeyValues:data];
                NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:NULL];
                NSString *result = [regular stringByReplacingMatchesInString:model.name options:0 range:NSMakeRange(0, [model.name length]) withTemplate:@""];
                model.name = [result stringByAppendingString:@"****"];
                model.openAmount = @"****";
                [self.investorArray addObject:model];
            }
        }
        [self.investorPositionSubject sendNext:nil];
    }];
 
    [self.tradeSignalsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        if (self.tradingSignalsArray.count!= 0) {
            [self.tradingSignalsArray removeAllObjects];
        }
        if(self.state==1){
            for (NSDictionary *data in x) {
                TradeRecordModel *model = [TradeRecordModel mj_objectWithKeyValues:data];
                [self.tradingSignalsArray addObject:model];
            }
        }else{
            for (NSDictionary *data in x) {
                TradeRecordModel *model = [TradeRecordModel mj_objectWithKeyValues:data];
                NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:NULL];
                NSString *result = [regular stringByReplacingMatchesInString:model.instrumentidCh options:0 range:NSMakeRange(0, [model.instrumentidCh length]) withTemplate:@""];
                model.instrumentidCh = [result stringByAppendingString:@"****"];
                model.price = @"****";
                [self.tradingSignalsArray addObject:model];
            }
        }
        [self.tradeSignalsRefreshUISubject sendNext:nil];
    }];
    
    [self.EvaluationCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        for (NSDictionary *data in x) {
            EvaluationModel *model = [EvaluationModel mj_objectWithKeyValues:data];
            [self.evaluationArray addObject:model];
        }
        [self.refreshEvaluationSubject sendNext:nil];
    }];
    
    [self.getTradeAnalysisDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        TradeAnalysisModel *model = [TradeAnalysisModel mj_objectWithKeyValues:x];
        [self.refreshTradeAnalysisSubject sendNext:model];
    }];
}
/**
 牛人信息数据查询
 */
-(RACCommand *)awesomeInfoCommand{
    if (!_awesomeInfoCommand) {
        _awesomeInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *api = [NSString stringWithFormat:@"/okami/%@",input];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:nil
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _awesomeInfoCommand;
}
/**
 根据ID查看持仓
 */
-(RACCommand *)investorPositionCommand{
    if (!_investorPositionCommand) {
        _investorPositionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *api = [NSString stringWithFormat:@"/ctpInvestorPosition/%@",self.awesomeID];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:nil
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _investorPositionCommand;
}
/**
 交易信号
 */
-(RACCommand *)tradeSignalsCommand {
    if (!_tradeSignalsCommand) {
        _tradeSignalsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *api = [NSString stringWithFormat:@"/ctpTradeRecord/%@",self.awesomeID];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:input
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _tradeSignalsCommand;
}
/**
 牛人评论数据获取
 */
-(RACCommand *)EvaluationCommand{
    if (!_EvaluationCommand) {
        _EvaluationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:self.awesomeID forKey:@"okamiId"];
                [param setObject:input forKey:@"page"];
                [param setObject:@"10" forKey:@"pageSize"];
                NSString *api = [NSString stringWithFormat:@"/okami/okamiEvaluate/list/"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([input intValue]==1) {
                                [self.evaluationArray removeAllObjects];
                            }
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _EvaluationCommand;
}
/**
 交易分析
 */
-(RACCommand *)getTradeAnalysisDataCommand {
    if (!_getTradeAnalysisDataCommand) {
        _getTradeAnalysisDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
                    NSError *error = nil;
                    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                    [param setObject:self.awesomeID forKey:@"okamiId"];
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/okami/trade/analysis"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                
                return nil;
            }];
        }];
    }
    return _getTradeAnalysisDataCommand;
}
/**
 结束刷新
 */
-(RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}
/**
 刷新UI
 */
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
/**
 持仓
 */
-(RACSubject *)investorPositionSubject{
    if (!_investorPositionSubject) {
        _investorPositionSubject = [RACSubject subject];
    }
    return _investorPositionSubject;
}
/**
 跟单点击
 */
-(RACSubject *)followEarningSubject {
    if (!_followEarningSubject) {
        _followEarningSubject = [RACSubject subject];
    }
    return _followEarningSubject;
}
/**
 查看全部历史按钮点击
 */
-(RACSubject *)lookAllHistorySignalSubject {
    if (!_lookAllHistorySignalSubject) {
        _lookAllHistorySignalSubject = [RACSubject subject];
    }
    return _lookAllHistorySignalSubject;
}

/**
 个人说明数据刷新
 */
-(RACSubject *)instructionsRefreshUISubject{
    if (!_instructionsRefreshUISubject) {
        _instructionsRefreshUISubject = [RACSubject subject];
    }
    return _instructionsRefreshUISubject;
}
/**
 交易信号刷新
 */
-(RACSubject *)tradeSignalsRefreshUISubject {
    if (!_tradeSignalsRefreshUISubject) {
        _tradeSignalsRefreshUISubject = [RACSubject subject];
    }
    return _tradeSignalsRefreshUISubject;
}
//收益折现图数据发送
-(RACSubject *)earningsSumDataSubject{
    if (!_earningsSumDataSubject) {
        _earningsSumDataSubject = [RACSubject subject];
    }
    return _earningsSumDataSubject;
}
//操作说明展开
-(RACSubject *)tradersInstructionsOpenSubject{
    if (!_tradersInstructionsOpenSubject) {
        _tradersInstructionsOpenSubject = [RACSubject subject];
    }
    return _tradersInstructionsOpenSubject;
}

/**
 牛人刷新数据
 */
-(RACSubject *)awesomeRefreshUISubject {
    if (!_awesomeRefreshUISubject) {
        _awesomeRefreshUISubject = [RACSubject subject];
    }
    return _awesomeRefreshUISubject;
}
/**
 评论刷新数据
 */
-(RACSubject *)refreshEvaluationSubject {
    if (!_refreshEvaluationSubject) {
        _refreshEvaluationSubject = [RACSubject subject];
    }
    return _refreshEvaluationSubject;
}
/**
 刷新交易分析数据
 */
-(RACSubject *)refreshTradeAnalysisSubject {
    if (!_refreshTradeAnalysisSubject) {
        _refreshTradeAnalysisSubject = [RACSubject subject];
    }
    return _refreshTradeAnalysisSubject;
}
/**
 去登陆信号
 */
-(RACSubject *)gotoLoginSubject {
    if (!_gotoLoginSubject) {
        _gotoLoginSubject = [RACSubject subject];
    }
    return _gotoLoginSubject;
}
/**
 风险揭示提示点击信号
 */
-(RACSubject *)promptClickSubject {
    if (!_promptClickSubject) {
        _promptClickSubject = [RACSubject subject];
    }
    return _promptClickSubject;
}
/**
 segmented开关点击信号
 */
-(RACSubject *)switchSegmentedSubject {
    if (!_switchSegmentedSubject) {
        _switchSegmentedSubject = [RACSubject subject];
    }
    return _switchSegmentedSubject;
}

-(int)segmentedControlIndex {
    if (!_segmentedControlIndex) {
        _segmentedControlIndex = 0;
    }
    return _segmentedControlIndex;
}
/**
 跟单状态(如果已跟此牛人的单,交易信号显示全部)
 */
-(int)state {
    if (!_state) {
        _state = 0;
    }
    return _state;
}

/**
 牛人持仓的数据
 */
-(NSMutableArray *)investorArray {
    if (!_investorArray) {
        _investorArray = [[NSMutableArray alloc] init];
    }
    return _investorArray;
}
/**
 牛人评论的数据
 */
-(NSMutableArray *)evaluationArray {
    if (!_evaluationArray) {
        _evaluationArray = [[NSMutableArray alloc] init];
    }
    return _evaluationArray;
}
/**
 牛人最新交易信号数组
 */
-(NSMutableArray *)tradingSignalsArray{
    if (!_tradingSignalsArray) {
        _tradingSignalsArray = [[NSMutableArray alloc] init];
    }
    return _tradingSignalsArray;
}
/**
 牛人说明的高度
 */
-(CGFloat )tradersInstructionsHeight{
    if (!_tradersInstructionsHeight) {
        NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGRect rect = [self.model.traderDescription boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                              attributes:dictionary
                                                                 context:nil];
        _tradersInstructionsHeight = rect.size.height;
    }
    return _tradersInstructionsHeight;
}
/**
 牛人说明
 */
-(NSString *)tradersInstructions{
    if (!_tradersInstructions) {
        _tradersInstructions = @"";
    }
    return _tradersInstructions;
}
@end

