//
//  DataReportViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface DataReportViewModel : BaseViewModel
@property (nonatomic,strong) RACCommand *totalIncomeCommand;//总收益
@property (nonatomic,strong) RACCommand *totalProfitCommand;//收益率
@end
