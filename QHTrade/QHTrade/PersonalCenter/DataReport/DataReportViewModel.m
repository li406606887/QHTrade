//
//  DataReportViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DataReportViewModel.h"

@implementation DataReportViewModel
//总收益率
-(RACCommand *)totalProfitCommand {
    if (!_totalProfitCommand) {
        _totalProfitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * input) {
            return [self totalProfitRequestWithType:input.integerValue];
        }];
    }
    return _totalProfitCommand;
}
-(RACSignal *)totalProfitRequestWithType:(NSInteger)type {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        loading(@"正在加载")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError * error;
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [param setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];//类型 1日 2月 3季
                    [param setObject:[defaults objectForKey:@"userId"] forKey:@"userId"];
//            [param setObject:@"118" forKey:@"userId"];//测试
            QHRequestModel * model = [QHRequest getDataWithApi:@"/reports/totalProfit" withParam:param error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error == nil) {
                    if ([model.status intValue] == 200) {
                        [subscriber sendNext:model.content];
                        NSLog(@"总收益率率率率=%@",model.content);
                    }else [subscriber sendNext:nil];
                    
                }
                [subscriber sendCompleted];
            });
            
        });
        return nil;
    }];
    
}
//总收益
-(RACCommand *)totalIncomeCommand {
    if (!_totalIncomeCommand) {
        _totalIncomeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *input) {
            return [self totalIncomeRequestWithType:input.integerValue];
        }];
    }
    return _totalIncomeCommand;
}
- (RACSignal *)totalIncomeRequestWithType:(NSInteger)type {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (type != 1) {
            loading(@"正在加载")
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError * error;
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [param setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];//类型 1日 2月 3季
                    [param setObject:[defaults objectForKey:@"userId"] forKey:@"userId"];
//            [param setObject:@"118" forKey:@"userId"];//测试
            QHRequestModel * model = [QHRequest getDataWithApi:@"/reports/totalIncome" withParam:param error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (type != 1) {
                    hiddenHUD;
                }
                if (error == nil) {
                    [subscriber sendNext:model.content];
                    NSLog(@"总收益曲线=%@",model.content);
                }else [subscriber sendNext:nil];
                [subscriber sendCompleted];
            });
            
        });
        return nil;
    }];
}
@end
