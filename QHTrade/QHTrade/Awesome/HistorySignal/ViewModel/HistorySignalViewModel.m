//
//  HistorySignalViewModel.m
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HistorySignalViewModel.h"
#import "TradeRecordModel.h"

@implementation HistorySignalViewModel
-(void)initialize {
    @weakify(self)
    [self.tradeSignalsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        for (NSDictionary *data in [x objectForKey:@"monthData"]) {
            TradeRecordModel *model = [TradeRecordModel mj_objectWithKeyValues:data];
            [self.tradingSignalsArray addObject:model];
        }
        [self.tradeSignalsRefreshUISubject sendNext:nil];
    }];
    
    [self.getMonthSignalsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        for (NSString *month in [x objectForKey:@"monthList"]) {
            [self.tradingMonthArray addObject:month];
        }
        self.month = self.tradingMonthArray[0];
        for (NSDictionary *data in [x objectForKey:@"monthData"]) {
            TradeRecordModel *model = [TradeRecordModel mj_objectWithKeyValues:data];
            [self.tradingSignalsArray addObject:model];
        }
        [self.tradeSignalsRefreshUISubject sendNext:nil];
    }];
}
//根据月份获取当月交易信号
-(RACCommand *)tradeSignalsCommand {
    if (!_tradeSignalsCommand) {
        _tradeSignalsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *api = [NSString stringWithFormat:@"/ctpTradeRecord/history/month"];
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:self.awesomeID forKey:@"userId"];
                [param setObject:self.month forKey:@"month"];
                [param setObject:input forKey:@"page"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([input intValue] == 1) {
                                [self.tradingSignalsArray removeAllObjects];
                            }
                            [subscriber sendNext:model.content];
                        }else {
                            [subscriber sendNext:nil];
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

//获取月份
-(RACCommand *)getMonthSignalsCommand {
    if (!_getMonthSignalsCommand) {
        _getMonthSignalsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *api = [NSString stringWithFormat:@"/ctpTradeRecord/history"];
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:self.awesomeID forKey:@"userId"];
                [param setObject:@"10" forKey:@"pageSize"]; dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:api
                                                            withParam:param
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
    return _getMonthSignalsCommand;
}

-(NSMutableArray *)tradingSignalsArray {
    if (!_tradingSignalsArray) {
        _tradingSignalsArray = [[NSMutableArray alloc] init];
    }
    return _tradingSignalsArray;
}

-(NSMutableArray *)tradingMonthArray {
    if (!_tradingMonthArray) {
        _tradingMonthArray = [[NSMutableArray alloc] init];
    }
    return _tradingMonthArray;
}

-(RACSubject *)tradeSignalsRefreshUISubject {
    if (!_tradeSignalsRefreshUISubject) {
        _tradeSignalsRefreshUISubject = [RACSubject subject];
    }
    return _tradeSignalsRefreshUISubject;
}


@end
