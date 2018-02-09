//
//  FollowEarningsDetailsViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsDetailsViewModel.h"
#import "FollowEarningsDetailsModel.h"
#import "FollowAwesomeModel.h"

@implementation FollowEarningsDetailsViewModel

-(void)initialize {
    @weakify(self)
    [self.getUserInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (x) {
            FollowEarningsDetailsModel *model = [FollowEarningsDetailsModel mj_objectWithKeyValues:x];
            [self.refreshUISubject sendNext:model];
        }
    }];
    [self.curveGraphDayCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray*  _Nullable array) {
        self.dayDataArray = array;
        [self.refreshCurveGraphsubject sendNext:array];
    }];
    [self.curveGraphMonthCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray*  _Nullable array) {
        self.monthDataArray = array;
        [self.refreshCurveGraphsubject sendNext:array];
    }];
    
}

-(RACCommand *)getUserInfoCommand {
    if (!_getUserInfoCommand) {
        _getUserInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               loading(@"")
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   NSError *error;
                   NSString *api = [NSString stringWithFormat:@"/users/%@",self.userID];
                   QHRequestModel *model = [QHRequest getDataWithApi:api
                                                           withParam:nil
                                                               error:&error];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       hiddenHUD;
                       if (error==nil) {
                           [subscriber sendNext:model.content];
                       }else {
                           showMassage(model.message);
                       }
                       [subscriber sendCompleted];
                   });
               });
               return nil;
           }];
        }];
    }
    return _getUserInfoCommand;
}

-(RACCommand *)curveGraphDayCommand {
    if (!_curveGraphDayCommand) {
        _curveGraphDayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                    [param setObject:[NSString stringWithFormat:@"1"] forKey:@"type"];
                    [param setObject:self.userID forKey:@"userId"];
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/reports/totalIncome"
                                                            withParam:param
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
    return _curveGraphDayCommand;
}
-(RACCommand *)curveGraphMonthCommand {
    if (!_curveGraphMonthCommand) {
        _curveGraphMonthCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                    [param setObject:[NSString stringWithFormat:@"2"] forKey:@"type"];
                    [param setObject:self.userID forKey:@"userId"];
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/reports/totalIncome"
                                                            withParam:param
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
    return _curveGraphMonthCommand;
}
-(RACSubject *)refreshCurveGraphsubject {
    if (!_refreshCurveGraphsubject) {
        _refreshCurveGraphsubject = [RACSubject subject];
    }
    return _refreshCurveGraphsubject;
}


-(RACSubject *)awesomeClickSubject {
    if (!_awesomeClickSubject) {
        _awesomeClickSubject = [RACSubject subject];
    }
    return _awesomeClickSubject;
}

-(NSDictionary *)dataDictionary {
    if (!_dataDictionary) {
        _dataDictionary = [[NSDictionary alloc] init];
        
    }
    return _dataDictionary;
}

-(RACSubject *)followRarningsSubject {
    if (!_followRarningsSubject) {
        _followRarningsSubject = [RACSubject subject];
    }
    return _followRarningsSubject;
}

-(RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

-(NSMutableArray *)monthDataArray {
    if (!_monthDataArray) {
        _monthDataArray = [[NSMutableArray alloc] init];
    }
    return _monthDataArray;
}
-(NSMutableArray *)dayDataArray {
    if (!_dayDataArray) {
        _dayDataArray = [[NSMutableArray alloc] init];
    }
    return _dayDataArray;
}
@end
