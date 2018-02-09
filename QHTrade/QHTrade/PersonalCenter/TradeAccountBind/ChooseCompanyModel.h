//
//  ChooseCompanyModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseCompanyModel : NSObject
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *letter;
@property (nonatomic,strong) NSString *sort;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *tradeIP;
/*
 1、code                  代码
 2、name                  开户公司名称
 3、letter                首字母
 4、sort                  权重 (ps:值越大越靠前)
 */
@end
