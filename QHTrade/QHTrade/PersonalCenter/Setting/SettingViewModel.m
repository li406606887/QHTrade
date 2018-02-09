//
//  SettingViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SettingViewModel.h"


@implementation SettingViewModel
-(void)initialize {
    
    [self.userInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        UserModel * model = [UserModel mj_objectWithKeyValues:x];
    
        [self.refreshUI sendNext:model];
    }];
    
}
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

-(RACCommand *)unbindCommand {
    if (!_unbindCommand) {
        _unbindCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"解除绑定");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    QHRequestModel * model = [QHRequest postDataWithApi:@"/ctpAccount/unbind" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error == nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:@"成功"];
                            }else [subscriber sendNext:nil];
                        }else showMassage(@"网络正在开小差");
                        [subscriber sendNext:@"失败"];
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _unbindCommand;
}
-(RACCommand *)userInfoCommand {
    if (!_userInfoCommand) {
        _userInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                loading(@"获取个人信息")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSError * error;
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/users" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        hiddenHUD;
                        if (error == nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                            }else [subscriber sendNext:nil];
                            
                        }else{
//                            [MBProgressHUD showError:@"网络正在开小差"];
                        }
                        [subscriber sendCompleted];
                    });
                    
                });
                return nil;
            }];
        }];
    }
    return _userInfoCommand;
}

-(RACSubject *)changePhoneClick{

    if (!_changePhoneClick) {
        _changePhoneClick = [RACSubject subject];
    }
    return _changePhoneClick;
}

-(RACSubject *)cellClick{
    if (!_cellClick) {
        _cellClick = [RACSubject subject];
    }
    return _cellClick;
}
@end
