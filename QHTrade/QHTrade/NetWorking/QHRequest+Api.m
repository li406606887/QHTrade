//
//  QHRequest+Api.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "QHRequest+Api.h"

@implementation QHRequest (Api)

+(QHRequestModel *)deleteDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error {
    
    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError *blockError = nil;
    [[QHRequest request] DELETE:request_Url
                     parameters:data_dic
                        success:^(QHRequest *request, id response) {
                            if ([[response objectForKey:@"status"] intValue] != 200) {
                                blockError = (NSError *)[response objectForKey:@"message"];
                            }
                            model = [QHRequestModel mj_objectWithKeyValues:response];
                        } failure:^(QHRequest *request, NSError *error) {
                        blockError = error;
                            if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                                NSLog(@"未登录或者被挤掉");
                                [[UserInformation getInformation] cleanUserInfo];
                            }
                    }];
    
    if (blockError) {
        *error = blockError;
    }
    return model;
}

+(QHRequestModel *)postDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error{

    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError *blockError = nil;
    
    [[QHRequest request] POST:request_Url
                   parameters:data_dic
                      success:^(QHRequest *request, id response) {
                          if ([[response objectForKey:@"status"] intValue] != 200) {
                              blockError = (NSError *)[response objectForKey:@"message"];
                          }
                          model = [QHRequestModel mj_objectWithKeyValues:response];                      }
                      failure:^(QHRequest *request, NSError *error) {
                          blockError = error;
                          if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                              NSLog(@"未登录或者被挤掉");
                              [[UserInformation getInformation] cleanUserInfo];
                          }
                      }];
    if (blockError) {
        *error = blockError;
    }
    return model;
}



+(QHRequestModel *)getDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error{
    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError *blockError = nil;
    
    [[QHRequest request] GET:request_Url
                  parameters:data_dic
                     success:^(QHRequest *request, id response) {
                         if ([[response objectForKey:@"status"] intValue] != 200) {
                                blockError = (NSError *)[response objectForKey:@"message"];
                         }
                        model = [QHRequestModel mj_objectWithKeyValues:response];
                    } failure:^(QHRequest *request, NSError *error) {
                        blockError = error;
                        model = [[QHRequestModel alloc] init];
                        model.message = @"网络君挂掉啦";
                        if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                            NSLog(@"未登录或者被挤掉");
                            [[UserInformation getInformation] cleanUserInfo];
                        }
                    }];

    if (blockError) {
        *error = blockError;
    }
    return model;
}

+(void)getQiniuToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel * model = [QHRequest getDataWithApi:@"/qiNiu/token" withParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if ([model.status intValue] == 200) {
                    NSDictionary * dic = model.content;
                    [[UserInformation getInformation] setQiniuToken:dic[@"token"] andLink:dic[@"link"]];
                }
            }else{
                [MBProgressHUD showError:@"获取七牛token失败"];
            }
          
        });
    });
}

@end
