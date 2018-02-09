//
//  ChooseCompanyViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChooseCompanyViewModel.h"
#import "ChooseCompanyModel.h"

@interface ChooseCompanyViewModel ()

@end

@implementation ChooseCompanyViewModel
-(void)initialize {
    WS(weakSelf)
    //正在跟单请求
    [self.requestCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *array) {
        
        if (weakSelf.dataArray.count!= 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        NSLog(@"abcd=%@",array);
        ;
        NSMutableArray *company = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            ChooseCompanyModel *model = [ChooseCompanyModel mj_objectWithKeyValues:dic];
            
            [weakSelf.dataArray addObject:model];
            [company addObject:[NSString stringWithFormat:@"%@id=%@z",model.name,model.id]];
        }
        
        [self.refreshUI sendNext:company];
        
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
}
-(RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                //请求
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/ctpAccount/company" withParam:nil error:&error];
                    
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
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
@end
