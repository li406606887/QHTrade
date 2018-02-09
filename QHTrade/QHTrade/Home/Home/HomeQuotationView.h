//
//  HomeQuotationView.h
//  QHTrade
//
//  Created by user on 2017/8/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "ContractModel.h"
#import "HomeQuotationModel.h"
@interface HomeQuotationView : BaseView
@property(nonatomic,strong) ContractModel *model;
@property(nonatomic,strong) HomeQuotationModel *modelData;
@end
