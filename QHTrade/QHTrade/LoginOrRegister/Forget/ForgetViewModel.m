//
//  ForgetViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ForgetViewModel.h"

@implementation ForgetViewModel

-(RACSignal *)registerSiganl{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //网络请求
        [self registerWithPhoneNum:self.phoneStr codeStr:self.codeStr passWord:self.passWordStr again:self.againPWStr complete:^(QHRequestModel *model) {
            [subscriber sendNext:model];
            [subscriber sendCompleted];
        }];
//        [self registerWithPhoneNum:self.phoneStr codeStr:self.codeStr passWord:self.passWordStr complete:^(QHRequestModel* model) {
//
//            [subscriber sendNext:model];
//            [subscriber sendCompleted];
//        }];
        
        return nil;
    }];
}

#pragma mark -网络请求
- (void)registerWithPhoneNum:(NSString *)phoneNum
                     codeStr:(NSString *)codeStr
                    passWord:(NSString *)passWord
                       again:(NSString *)agian
                    complete:(void(^)(QHRequestModel* responsObject))completeBlock {
    if (![agian isEqualToString:passWord]) {
        showMassage(@"输入的两次密码不同")
        return;
    }
    
    loading(@"正在请求")
    NSMutableDictionary * parameter = [NSMutableDictionary dictionary];
    parameter[@"mobile"] = phoneNum;
    parameter[@"password"] = passWord;
    parameter[@"validate_code"] = codeStr;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError * error;
        QHRequestModel * model = [QHRequest postDataWithApi:@"/users/password" withParam:parameter error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                
            }else{
                showMassage(model.message);
//                [MBProgressHUD showError:@"网络正在开小差"];
            }
            completeBlock(model);
        });
        
    });
    
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        RACSignal * phoneNumLengthSig = [RACObserve(self, self.phoneStr) map:^id _Nullable(NSString * value) {
            if (value.length == 11) {
                return @(YES);
            }
            return @(NO);
        }];
        
        RACSignal * codeLengthSig = [RACObserve(self, self.codeStr) map:^id _Nullable(NSString * value) {
            if (value.length == 6) {
                return @(YES);
            }
            return @(NO);
        }];
        
        RACSignal * passWordLengthSig = [RACObserve(self, self.passWordStr) map:^id _Nullable(NSString * value) {
            if (value.length >= 6) {
                return @(YES);
            }
            return @(NO);
        }];
        
        _commitBtnEnable = [RACSignal combineLatest:@[phoneNumLengthSig,codeLengthSig,passWordLengthSig] reduce:^id (NSNumber * phoneNum, NSNumber * code, NSNumber * passWord){
            return @([phoneNum boolValue] && [code boolValue] && [passWord boolValue]);
        }];
        
        _commitCommand = [[RACCommand alloc]initWithEnabled:_commitBtnEnable signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [self registerSiganl];
        }];
        
        
        
    }
    
    return self;
}

-(RACCommand *)codeCommand{
    
    if (!_codeCommand) {
        _codeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    //                   NSError * error;
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    [dic setObject:self.phoneStr forKey:@"phoneNumber"];
                    //请求
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //倒计时
                    });
                    
                });
                return nil;
            }];
        }];
    }
    return _codeCommand;
}


-(RACSubject *)getCodeSubject{
    
    if (!_getCodeSubject) {
        _getCodeSubject = [RACSubject subject];
    }
    return _getCodeSubject;
}

@end
