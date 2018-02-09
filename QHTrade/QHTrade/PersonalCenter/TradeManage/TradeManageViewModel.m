//
//  TradeManageViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeManageViewModel.h"
#import "TradeManageModel.h"

@implementation TradeManageViewModel
-(void)initialize{
    //历史跟单请求
    @weakify(self)
    [self.historyDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        @strongify(self)
        if (self.historyDataArr.count!= 0) {
            [self.historyDataArr removeAllObjects];
        }
        for (NSDictionary *dic in array) {
            TradeManageModel *model = [TradeManageModel mj_objectWithKeyValues:dic];
            [self.historyDataArr addObject:model];
        }
        [self.refreshHistoryUISubject sendNext:@"1"];
    }];

    //正在跟单请求
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        @strongify(self)
        if (self.dataArray.count!= 0) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary *dic in array) {
            TradeManageModel *model = [TradeManageModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:model];
        }
        [self.refreshFollowUISubject sendNext:@"1"];
    }];
    
    [self.cancelCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.refreshDataCommand execute:nil];//重新获取
        NSDictionary *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"];
//        NSDictionary *dic = [NSDictionary mj_objectWithKeyValues:userData];

//        NSLog(@"123");
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userData];
        [dic setValue:@"0" forKey:@"isFollows"];
        NSError *parseError = nil;
        NSData *stringData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        NSString *data = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
         [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userModel"];
    }];
}
#pragma mark -评论请求
-(RACCommand *)evaluateCommand {
    if (!_evaluateCommand) {
        _evaluateCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSMutableDictionary * input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    QHRequestModel * model = [QHRequest postDataWithApi:@"/okami/okamiEvaluate" withParam:input error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                            }
                            showMassage(model.message)
                        }else {
                            [MBProgressHUD showError:@"请求失败"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _evaluateCommand;
}
#pragma mark -取消跟单请求
-(RACCommand *)cancelCommand {
    if (!_cancelCommand) {
        _cancelCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:input forKey:@"userId"];
                    
                    QHRequestModel * model = [QHRequest deleteDataWithApi:@"/documentary" withParam:dic error:&error];
                    
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
    return _cancelCommand;
}


-(RACCommand *)historyDataCommand {
    if (!_historyDataCommand) {
        _historyDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"0" forKey:@"type"];
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/documentary" withParam:dic error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                                [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            [self.refreshHistoryUISubject sendNext:@"0"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _historyDataCommand;
}

-(RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"1" forKey:@"type"];
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/documentary" withParam:dic error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                           [self.refreshHistoryUISubject sendNext:@"0"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}
-(RACSubject *)cancelBtnClick {
    if (!_cancelBtnClick) {
        _cancelBtnClick = [RACSubject subject];
    }
    return _cancelBtnClick;
}

-(RACSubject *)refreshFollowUISubject{
    
    if (!_refreshFollowUISubject) {
        _refreshFollowUISubject = [RACSubject subject];
    }
    return _refreshFollowUISubject;
}

-(RACSubject *)refreshHistoryUISubject {
    if (!_refreshHistoryUISubject) {
        _refreshHistoryUISubject = [RACSubject subject];
    }
    return _refreshHistoryUISubject;
}
-(NSMutableArray *)historyDataArr{
    
    if (!_historyDataArr) {
        _historyDataArr = [[NSMutableArray alloc]init];
    }
    return _historyDataArr;
}
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
