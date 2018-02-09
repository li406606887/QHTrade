//
//  TradeStatisticViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeStatisticViewModel.h"
#import "TradeStatisticsModel.h"

@interface TradeStatisticViewModel ()

@end

@implementation TradeStatisticViewModel

-(void)initialize {

}

-(RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/ctpAccount/statistics" withParam:nil error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                            }else{
                                showMassage(model.message)
                                [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
                            }
                        }else {
                            [MBProgressHUD showError:@"请求失败"];
                            [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
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

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];;
    }
    return _dataArray;
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
