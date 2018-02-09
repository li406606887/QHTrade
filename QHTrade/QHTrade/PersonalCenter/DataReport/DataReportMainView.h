//
//  DataReportMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "DataReportViewModel.h"
#import "EarningsOfSumView.h"
#import "RateOfEarningsView.h"

@interface DataReportMainView : BaseView
@property (nonatomic,strong) DataReportViewModel *viewModel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) EarningsOfSumView *earningsOfSumView;
@property (nonatomic,strong) RateOfEarningsView *rateOfEaringsView;
@end
