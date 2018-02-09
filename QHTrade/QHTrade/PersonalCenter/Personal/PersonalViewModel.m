//
//  PersonalViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalViewModel.h"
//#import "PersonalModel.h"
#import "UserModel.h"
@implementation PersonalViewModel

-(void)initialize {
    @weakify(self)
    [self.userInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[NSUserDefaults standardUserDefaults] setObject:x forKey:@"userModel"];
        [UserInformation getInformation].userModel = [UserModel mj_objectWithKeyValues:x];
        [self.refreshUI sendNext:[UserInformation getInformation].userModel];
    }];
    
    [self.openAccountCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.refreshUI sendNext:[UserInformation getInformation].userModel];
        [self showOpenAccountAlertView];
        
    }];
}
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
//交易账户登录
//-(RACCommand *)tcpAccountCommand {
//    if (!_tcpAccountCommand) {
//        _tcpAccountCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                loading(@"交易账户登录中")
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSError * error;
//                    QHRequestModel * model = [QHRequest postDataWithApi:@"/ctpAccount/login" withParam:nil error:&error];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        hiddenHUD;
//                        if (error == nil) {
//                            if ([model.status intValue] == 200) {
//                                [subscriber sendNext:@"200"];
//                            }
//                        }else{
//                            [MBProgressHUD showError:@"网络正在开小差"];
//                        }
//                        [subscriber sendCompleted];
//                    });
//                });
//                return nil;
//            }];
//        }];
//    }
//    return _tcpAccountCommand;
//}

-(RACCommand *)totalIncomeCommand {
    if (!_totalIncomeCommand) {
        _totalIncomeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"正在获取收益数据")
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSError * error;
                    NSMutableDictionary * param = [NSMutableDictionary dictionary];
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     
                    [param setObject:@"1" forKey:@"type"];//类型 1日 2月 3季
                    [param setObject:[defaults objectForKey:@"userId"] forKey:@"userId"];
//                     [param setObject:@"118" forKey:@"userId"];//测试
                    QHRequestModel * model = [QHRequest getDataWithApi:@"/reports/totalIncome" withParam:param error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error == nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:model.content];
                                NSLog(@"总收益曲线=%@",model.content);
                                if ([model.content isKindOfClass:[NSArray class]]) {
                                    self.totalIncomeArray = model.content;
                                }
                                
                            }else [subscriber sendNext:nil];
                            
                        }
                        
                        [subscriber sendCompleted];
                    });
                    
                });
                return nil;
            }];
        }];

    }
    return _totalIncomeCommand;
}
-(NSMutableArray *)totalIncomeArray {
    if (!_totalIncomeArray) {
        _totalIncomeArray = [NSMutableArray array];
    }
    return _totalIncomeArray;
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
                                [subscriber sendNext:model.content];
                            
                        }else{
                            showMassage(model.message);
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

-(RACCommand *)manualChooseCommand {
    if (!_manualChooseCommand) {
        _manualChooseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel * model = [QHRequest postDataWithApi:@"/ctpAccount/logout" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error == nil) {
                            [UserInformation getInformation].userModel.documentary = @"2";
                            [UserInformation getInformation].userModel.state = @"2";
                            [self.refreshPersonalFollowStateSubject sendNext:nil];
                        } else{
                            showMassage(model.message);
                        }
                        [subscriber sendCompleted];
                    });
                    
                });
                return nil;
            }];
        }];
    }
    return _manualChooseCommand;
}

-(RACCommand *)automaticChooseCommand {
    if (!_automaticChooseCommand) {
        _automaticChooseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSError * error;
                    QHRequestModel * model = [QHRequest postDataWithApi:@"/ctpAccount/login" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error == nil) {
                            [UserInformation getInformation].userModel.documentary = @"1";
                            [UserInformation getInformation].userModel.state = @"3";
                            [self.refreshPersonalFollowStateSubject sendNext:nil];
                        }else{
                            showMassage(model.message);
                        }
                        [subscriber sendCompleted];
                    });
                    
                });
                return nil;
            }];
        }];
    }
    return _automaticChooseCommand;
}

-(RACSubject *)positionsClick{

    if (!_positionsClick) {
        _positionsClick = [RACSubject subject];
    }
    return _positionsClick;
}
-(RACSubject *)middleCellClick{

    if (!_middleCellClick) {
        _middleCellClick = [RACSubject subject];
    }
    return _middleCellClick;
}
-(RACSubject *)tradeAccountLoginBtnClick{

    if (!_tradeAccountLoginBtnClick) {
        _tradeAccountLoginBtnClick = [RACSubject subject];
    }
    return _tradeAccountLoginBtnClick;
}
-(RACSubject *)diamondBtnClick{

    if (!_diamondBtnClick) {
        _diamondBtnClick = [RACSubject subject];
    }
    return _diamondBtnClick;

}
-(RACSubject *)setBtnClick{

    if (!_setBtnClick) {
        _setBtnClick = [RACSubject subject];
    }
    return _setBtnClick;
}
-(RACSubject *)focusClick{

    if (!_focusClick) {
        _focusClick = [RACSubject subject];
    }
    return _focusClick;
}
-(RACSubject *)visitorsClick{

    if (!_visitorsClick) {
        _visitorsClick = [RACSubject subject];
    }
    return _visitorsClick;
}
-(RACSubject *)questionClick{

    if (!_questionClick) {
        _questionClick = [RACSubject subject];
    }
    return _questionClick;
}
-(RACSubject *)headImgClick{
    if (!_headImgClick) {
        _headImgClick = [RACSubject subject];
    }
    return _headImgClick;
}
-(RACSubject *)tradeAccountIsLogin {
    if (!_tradeAccountIsLogin) {
        _tradeAccountIsLogin = [RACSubject subject];
    }
    return _tradeAccountIsLogin;
}

#pragma mark - 开户
-(RACCommand *)openAccountCommand {
    if (!_openAccountCommand) {
        _openAccountCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    [dic setObject:@"1" forKey:@"isAccount"];
                    QHRequestModel * model = [QHRequest postDataWithApi:@"/users/info" withParam:nil error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error == nil) {
                            if ([model.status intValue] == 200) {
                                [subscriber sendNext:@"200"];
                            }
                        }else{
                            [MBProgressHUD showError:@"网络正在开小差"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _openAccountCommand;
}

-(RACSubject *)refreshPersonalFollowStateSubject {
    if (!_refreshPersonalFollowStateSubject) {
        _refreshPersonalFollowStateSubject = [RACSubject subject];
    }
    return _refreshPersonalFollowStateSubject;
}

-(RACSubject *)openAccountSubject {
    if (!_openAccountSubject) {
        _openAccountSubject = [RACSubject subject];
    }
    return _openAccountSubject;
}
#pragma mark- 我要开户弹框
-(void)showOpenAccountAlertView {
    PromptView * pView = [[PromptView alloc]initWithTitleString:@"我要开户" SubTitleString:@"感谢您的支持，瑞达期货已经收到您的开户要求，我们将尽快安排业务员与您联系开户事宜，请保持通话畅通！"];
    [pView show];
    pView.goonBlock = ^{
        
    };
    pView.closeBlock = ^{
        
    };
}
@end
