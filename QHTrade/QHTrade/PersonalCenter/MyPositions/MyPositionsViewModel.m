//
//  MyPositionsViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyPositionsViewModel.h"
#import "WarehouseModel.h"
#import "TradeRecordModel.h"

@interface MyPositionsViewModel ()

@end

@implementation MyPositionsViewModel
-(void)initialize {
    WS(weakSelf)
    
    //交易记录请求
    [self.tradeRecordCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (weakSelf.tradeRecordDataArr.count!= 0) {
            [weakSelf.tradeRecordDataArr removeAllObjects];
        }
        NSLog(@"交易记录=%@",array);
        
        for (NSDictionary *dic in array) {
            TradeRecordModel *model = [TradeRecordModel mj_objectWithKeyValues:dic];
            
            [weakSelf.tradeRecordDataArr addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    //持仓请求
    [self.warehouseCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (weakSelf.warehouseDataArr.count!= 0) {
            [weakSelf.warehouseDataArr removeAllObjects];
        }
        NSLog(@"持仓=%@",array);
        
        for (NSDictionary *dic in array) {
            WarehouseModel *model = [WarehouseModel mj_objectWithKeyValues:dic];
            
            [weakSelf.warehouseDataArr addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];

}
-(RACCommand *)warehouseCommand {
    if (!_warehouseCommand) {
        _warehouseCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    QHRequestModel * model = [QHRequest getDataWithApi:[NSString stringWithFormat:@"/ctpInvestorPosition/list"] withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                            }else{
                                showMassage(model.message)
                                [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
                            }
                        }else {
                            showMassage(model.message)
                            [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _warehouseCommand;
}
-(RACCommand *)tradeRecordCommand {
    if (!_tradeRecordCommand) {
        _tradeRecordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    
                    QHRequestModel * model = [QHRequest getDataWithApi:[NSString stringWithFormat:@"/ctpTradeRecord/list"] withParam:nil error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                            }else{
                                showMassage(model.message)
                                [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
                            }
                        }else {
                            showMassage(model.message);
                            [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _tradeRecordCommand;
}

-(NSMutableArray *)tradeRecordDataArr {
    if (!_tradeRecordDataArr) {
        _tradeRecordDataArr = [[NSMutableArray alloc]init];
    }
    return _tradeRecordDataArr;
}

-(NSMutableArray *)warehouseDataArr {
    if (!_warehouseDataArr) {
        _warehouseDataArr = [[NSMutableArray alloc]init];
    }
    return _warehouseDataArr;
}

-(RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
@end
