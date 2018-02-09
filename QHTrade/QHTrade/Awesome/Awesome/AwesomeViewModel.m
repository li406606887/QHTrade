
//
//  AwesomeViewModel.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeViewModel.h"
#import "AwesomeModel.h"
#import "FollowEarningsModel.h"

@implementation AwesomeViewModel

-(void)initialize {
    [self.canDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable array) {
        if (array.count>0) {
            if (self.canPageNum==1) {
                [self.canFollowDataArray removeAllObjects];
            }
            for (NSDictionary *data in array) {
                AwesomeModel *model = [AwesomeModel mj_objectWithKeyValues:data];
                [self.canFollowDataArray addObject:model];
                NSLog(@"%f",model.nameWidth);
            }
        }
        [self.canRefreshDataSubject sendNext:nil];
    }];
    [self.followEarningsDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable array) {
        if (array.count>0) {
            if (self.followEarningsPageNum==1) {
                [self.followEarningsDataArray removeAllObjects];
            }
            for (NSDictionary *data in array) {
                FollowEarningsModel *model = [FollowEarningsModel mj_objectWithKeyValues:data];
                [self.followEarningsDataArray addObject:model];
            }
            
        }
        [self.followEarningsRefreshDataSubject sendNext:@(RefreshError)];
        
    }];
    [self.rookieDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable array) {
        if (array.count>0) {
            if (self.rookiePageNum==1) {
                [self.rookieDataArray removeAllObjects];
            }
            for (NSDictionary *data in array) {
                AwesomeModel *model = [AwesomeModel mj_objectWithKeyValues:data];
                NSLog(@"%f",model.nameWidth);
                [self.rookieDataArray addObject:model];
            }
        }
        [self.rookieRefreshDataSubject sendNext:@(RefreshError)];
        
    }];
    [self.awesomeDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable array) {
        if (array.count>0) {
            if (self.awesomePageNum==1) {
                [self.awesomeDataArray removeAllObjects];
            }
            for (NSDictionary *data in array) {
                AwesomeModel *model = [AwesomeModel mj_objectWithKeyValues:data];
                NSLog(@"%f",model.nameWidth);
                [self.awesomeDataArray addObject:model];
            }
        }
        [self.awesomeRefreshDataSubject sendNext:nil];
    }];
}

-(RACCommand *)canDataCommand {
    if (!_canDataCommand) {
        _canDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.canPageNum = input == nil ? self.canPageNum : 0;
                self.canPageNum++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.canPageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"4" forKey:@"type"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/okami/list"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            self.followEarningsPageNum--;
                            [self.canRefreshDataSubject sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _canDataCommand;
}

-(RACCommand *)followEarningsDataCommand {
    if (!_followEarningsDataCommand) {
        _followEarningsDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.followEarningsPageNum = input == nil ? self.followEarningsPageNum : 0;
                self.followEarningsPageNum++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.followEarningsPageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"3" forKey:@"type"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/okami/list"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            self.followEarningsPageNum--;
                            [self.followEarningsRefreshDataSubject sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _followEarningsDataCommand;
}

-(RACCommand *)rookieDataCommand {
    if (!_rookieDataCommand) {
        _rookieDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.rookiePageNum = input == nil ? self.rookiePageNum: 0;
                self.rookiePageNum ++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.rookiePageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"2" forKey:@"type"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/okami/list"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            self.rookiePageNum--;
                            [self.rookieRefreshDataSubject sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _rookieDataCommand;
}

-(RACCommand *)awesomeDataCommand {
    if (!_awesomeDataCommand) {
        _awesomeDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.awesomePageNum = input == nil ? self.awesomePageNum: 0;
                self.awesomePageNum++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.awesomePageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"1" forKey:@"type"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/okami/list"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            self.awesomePageNum--;
                            [self.awesomeRefreshDataSubject sendNext:nil];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _awesomeDataCommand;
}
-(int)canPageNum{
    if (!_canPageNum) {
        _canPageNum = 0;
    }
    return _canPageNum;
}

-(int)followEarningsPageNum{
    if (!_followEarningsPageNum) {
        _followEarningsPageNum = 0;
    }
    return _followEarningsPageNum;
}

-(int)awesomePageNum{
    if (!_awesomePageNum) {
        _awesomePageNum = 0;
    }
    return _awesomePageNum;
}

-(int)rookiePageNum{
    if (!_rookiePageNum) {
        _rookiePageNum = 0;
    }
    return _rookiePageNum;
}


-(NSMutableArray *)awesomeDataArray {
    if (!_awesomeDataArray) {
        _awesomeDataArray = [[NSMutableArray alloc] init];
    }
    return _awesomeDataArray;
}

-(NSMutableArray *)canFollowDataArray {
    if (!_canFollowDataArray) {
        _canFollowDataArray = [[NSMutableArray alloc] init];
    }
    return _canFollowDataArray;
}

-(NSMutableArray *)rookieDataArray {
    if (!_rookieDataArray) {
        _rookieDataArray = [[NSMutableArray alloc] init];
    }
    return _rookieDataArray;
}


-(NSMutableArray *)followEarningsDataArray{
    if (!_followEarningsDataArray) {
        _followEarningsDataArray = [[NSMutableArray alloc] init];
    }
    return _followEarningsDataArray;
}

-(RACSubject *)followEarningsCellClick {
    if (!_followEarningsCellClick) {
        _followEarningsCellClick = [RACSubject subject];
    }
    return _followEarningsCellClick;
}

-(RACSubject *)awesomeCellClick {
    if (!_awesomeCellClick) {
        _awesomeCellClick = [RACSubject subject];
    }
    return _awesomeCellClick;
}

-(RACSubject *)awesomeFollowActionClick {
    if (!_awesomeFollowActionClick) {
        _awesomeFollowActionClick = [RACSubject subject];
    }
    return _awesomeFollowActionClick;
}


-(RACSubject *)awesomeRefreshDataSubject {
    if (!_awesomeRefreshDataSubject) {
        _awesomeRefreshDataSubject = [RACSubject subject];
    }
    return _awesomeRefreshDataSubject;
}

-(RACSubject *)canRefreshDataSubject {
    if (!_canRefreshDataSubject) {
        _canRefreshDataSubject = [RACSubject subject];
    }
    return _canRefreshDataSubject;
}

-(RACSubject *)followEarningsRefreshDataSubject {
    if (!_followEarningsRefreshDataSubject) {
        _followEarningsRefreshDataSubject = [RACSubject subject];
    }
    return _followEarningsRefreshDataSubject;
}

-(RACSubject *)rookieRefreshDataSubject {
    if (!_rookieRefreshDataSubject) {
        _rookieRefreshDataSubject = [RACSubject subject];
    }
    return _rookieRefreshDataSubject;
}

@end
