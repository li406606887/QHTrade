//
//  PersonalTableFootView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalViewModel.h"
#import "GraphView.h"

@interface PersonalTableFootView : BaseView
@property (nonatomic,strong) PersonalViewModel *viewModel;
@property (nonatomic,strong) GraphView *lineChartView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *nilLabel;
@end
