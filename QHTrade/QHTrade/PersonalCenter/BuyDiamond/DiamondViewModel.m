//
//  DiamondViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondViewModel.h"
#import "ALiPayModel.h"
#import <AlipaySDK/AlipaySDK.h>
#define ALISCHEME  @"QHTradeALiPay"//支付宝拉起scheme

@implementation DiamondViewModel

-(RACSignal *)aLiPayRequestWithMoney:(NSString * )money {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        loading(@"正在跳转支付")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\
            NSError * error;
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            [param setObject:money forKey:@"totalAmount"];//
//            [param setObject:@"0.01" forKey:@"totalAmount"];//测试
            QHRequestModel * model = [QHRequest getDataWithApi:@"/alipay/params" withParam:param error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (error == nil) {
                    if ([model.status intValue] == 200) {
                        NSLog(@"返回付款参数=%@",model.content);
                        ALiPayModel * payModel = [ALiPayModel mj_objectWithKeyValues:model.content];
                        NSLog(@"orderStr = %@",payModel.orderStr);
                        // NOTE: 调用支付结果开始支付
                        [[AlipaySDK defaultService] payOrder:payModel.orderStr fromScheme:ALISCHEME callback:^(NSDictionary *resultDic) {
                            NSLog(@"reslut = %@   状态=%@",resultDic,resultDic[@"resultStatus"]);
                        
                            NSString *resultStatus = resultDic[@"resultStatus"];
                            if ([resultStatus isEqualToString:@"9000"]) {//支付成功
                                showMassage(@"支付成功")
                            }else {
                                showMassage(@"支付失败")
                            }
                            [subscriber sendCompleted];
                        }];
                    }
                }
            });
        });
        
        return nil;
    }];
    
}

//支付
-(RACCommand *)aLiPayCommand {
    if (!_aLiPayCommand) {
        _aLiPayCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(NSString * input) {
            return [self aLiPayRequestWithMoney:input];
        }];
    }
    return _aLiPayCommand;
}


-(RACSubject *)commitBtnSubjet {
    if (!_commitBtnSubjet) {
        _commitBtnSubjet = [RACSubject subject];
    }
    return _commitBtnSubjet;
}
-(RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
@end
