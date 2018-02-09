//
//  QHRequest+Api.h
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "QHRequest.h"
#import "QHRequestModel.h"

@interface QHRequest (Api)
//post 提交数据
+(QHRequestModel *)postDataWithApi:(NSString *)api withParam:(NSDictionary*)data_dic
                             error:(NSError* __autoreleasing*)error;

//get 获取数据
+(QHRequestModel *)getDataWithApi:(NSString *)api withParam:(NSDictionary*)data_dic
                            error:(NSError* __autoreleasing*)error;
//delete 方式
+(QHRequestModel *)deleteDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error;
//获取七牛token
+(void)getQiniuToken;
@end
