//
//  FollowSetingViewModel.m
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowSetingViewModel.h"
#import "WarehouseModel.h"

@implementation FollowSetingViewModel
-(void)initialize {
    @weakify(self)
    [self.followEarningSumbitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.sumbitSuccessfulSubject sendNext:nil];
    }];
    
    [self.getAwesomePositionCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in x) {
            WarehouseModel *model = [WarehouseModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:model];
        }
        [self.refreshPositionUISubject sendNext:nil];
        
    }];
}

-(RACCommand *)followEarningSumbitCommand {
    if (!_followEarningSumbitCommand) {
        _followEarningSumbitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/okami/documentary"
                                                             withParam:input
                                                                 error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }
                        showMassage(model.message)
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _followEarningSumbitCommand;
}

-(RACCommand *)getAwesomePositionCommand {
    if (!_getAwesomePositionCommand) {
        _getAwesomePositionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    NSString *url = [NSString stringWithFormat:@"/ctpInvestorPosition/%@",self.model.userId];
                    QHRequestModel *model = [QHRequest getDataWithApi:url
                                                            withParam:nil
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
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
    return _getAwesomePositionCommand;
}

-(RACSubject *)valueChangeSubject {
    if (!_valueChangeSubject) {
        _valueChangeSubject = [RACSubject subject];
    }
    return _valueChangeSubject;
}

-(FollowSetingModel *)setingModel {
    if (!_setingModel) {
        _setingModel = [[FollowSetingModel alloc] init];
        _setingModel.numScale = @"1";
        _setingModel.priceType = 0;
        _setingModel.jumpPoint = 0;
    }
    return _setingModel;
}

-(RACSubject *)sureClickSubject {
    if (!_sureClickSubject) {
        _sureClickSubject = [RACSubject subject];
    }
    return _sureClickSubject;
}

-(RACSubject *)successPriceClick {
    if (!_successPriceClick) {
        _successPriceClick = [RACSubject subject];
    }
    return _successPriceClick;
}

-(RACSubject *)gotoLoginSubject {
    if (!_gotoLoginSubject) {
        _gotoLoginSubject = [RACSubject subject];
    }
    return _gotoLoginSubject;
}

-(RACSubject *)gotoBindCTPAcountSubject {
    if (!_gotoBindCTPAcountSubject) {
        _gotoBindCTPAcountSubject = [RACSubject subject];
    }
    return _gotoBindCTPAcountSubject;
}

-(RACSubject *)sumbitSuccessfulSubject {
    if (!_sumbitSuccessfulSubject) {
        _sumbitSuccessfulSubject = [RACSubject subject];
    }
    return _sumbitSuccessfulSubject;
}

-(RACSubject *)refreshPositionUISubject {
    if (!_refreshPositionUISubject) {
        _refreshPositionUISubject = [RACSubject subject];
    }
    return _refreshPositionUISubject;
}

-(RACSubject *)popViewControllerSubject {
    if (!_popViewControllerSubject) {
        _popViewControllerSubject = [RACSubject subject];
    }
    return _popViewControllerSubject;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
