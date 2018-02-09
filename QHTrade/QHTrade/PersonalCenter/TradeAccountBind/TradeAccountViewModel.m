//
//  TradeAccountViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeAccountViewModel.h"

@implementation TradeAccountViewModel

- (RACSignal *)signInSiganl {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

        [self signInTCPWithAccountNum:self.accountNumStr passWord:self.passWordStr brokerId:self.brokerId complete:^(QHRequestModel *responsObject) {
            if ([responsObject.status isEqualToString:@"200"]) {
                [UserInformation getInformation].userModel.ctpAccount = self.accountNumStr;
                [subscriber sendNext:responsObject];
            }
            NSLog(@"cg=->%@",[UserInformation getInformation].userModel.ctpAccount);
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

-(instancetype)init {
    
    if (self = [super init]) {
        
        RACSignal * accountNumLengthSig = [RACObserve(self, accountNumStr) map:^id _Nullable(NSString * value) {
            if (value.length >0) return @(YES);
            
            return @(NO);
        }];
        
        RACSignal * passWordLengthSig = [RACObserve(self, passWordStr) map:^id _Nullable(NSString * value) {
            if (value.length>=6) {
                return @(YES);
            }
            return @(NO);
        }];
        
        _loginBtnEnable = [RACSignal combineLatest:@[accountNumLengthSig,passWordLengthSig] reduce:^id (NSNumber * phoneNum, NSNumber * passWord){
            return @([phoneNum boolValue] && [passWord boolValue] && self.isAgree);
        }];
        
        _loginCommand = [[RACCommand alloc]initWithEnabled:_loginBtnEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [self signInSiganl];
        }];
        
        
        
    }
    return self;
}
#pragma mark -网络请求
- (void)signInTCPWithAccountNum:(NSString *)accountNum
                       passWord:(NSString *)passWord
                       brokerId:(NSString *)brokerId
                       complete:(void(^)(QHRequestModel* responsObject))completeBlock {
    
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"account"] = accountNum;
    parameter[@"password"] = passWord;
    parameter[@"brokerId"] = brokerId;
    
    loading(@"正在登录")
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError * error;
        QHRequestModel * model = [QHRequest postDataWithApi:@"/ctpAccount" withParam:parameter error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
            }else{
//                [MBProgressHUD showError:@"网络正在开小差"];
            }
            showMassage(model.message)
            completeBlock(model);
        });
        
    });
}
#pragma mark - 请求开户公司
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
                            }
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
    return _requestCommand;
}
-(RACSubject *)searchSubject {
    if (!_searchSubject) {
        _searchSubject = [RACSubject subject];
    }
    return _searchSubject;
}

-(RACSubject *)tickClickSubject {
    if (!_tickClickSubject) {
        _tickClickSubject = [RACSubject subject];
    }
    return _tickClickSubject;
}

-(RACSubject *)statementSubject {
    if (!_statementSubject) {
        _statementSubject = [RACSubject subject];
    }
    return _statementSubject;
}
@end
