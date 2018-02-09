//
//  DiamondRecordViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondRecordViewModel.h"
#import "DiamondRecordModel.h"
@interface DiamondRecordViewModel ()

@end

@implementation DiamondRecordViewModel

-(void)initialize {
    WS(weakSelf)
    //正在跟单请求
    [self.requestCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (weakSelf.dataArray.count!= 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        NSLog(@"abcd=%@",array);
        
        for (NSDictionary *dic in array) {
            DiamondRecordModel *model = [DiamondRecordModel mj_objectWithKeyValues:dic];
            
            [weakSelf.dataArray addObject:model];
        }
        
        [self.refreshUI sendNext:nil];
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];

}
-(RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
            
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/userRechargeRecord/list" withParam:nil error:&error];
                    
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
    return _requestCommand;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
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
