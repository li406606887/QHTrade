//
//  AccountSetViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AccountSetViewModel.h"

@implementation AccountSetViewModel
-(void)initialize {
    [self.logoutCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        [self.refreshUI sendNext:x];
    }];
}
//上传
-(RACCommand *)uploadHeadImageCommand {
    if (!_uploadHeadImageCommand) {
        _uploadHeadImageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               
                
                return nil;
            }];
        }];
    }
    return _uploadHeadImageCommand;
}
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
//退出
-(RACCommand *)logoutCommand {
    if (!_logoutCommand) {
        _logoutCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"退出登录");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel * model = [QHRequest deleteDataWithApi:@"/tokens" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            showMassage(model.message);
                            NSLog(@"%@",model.content);
                            if ([model.status intValue] == 200) {
                                [[UserInformation getInformation] cleanUserInfo];

                            }
                            [subscriber sendNext:model.status];
                        }else{
                            showMassage(@"请求失败");
                        }
                        [subscriber sendCompleted];
                    });
    
                });
                return nil;
            }];
        }];
    }
    return _logoutCommand;
}
-(RACSubject *)cellClick{

    if (!_cellClick) {
        _cellClick = [RACSubject subject];
    }
    return _cellClick;
}
@end
