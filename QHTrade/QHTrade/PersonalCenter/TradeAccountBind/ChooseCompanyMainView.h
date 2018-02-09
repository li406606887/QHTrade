//
//  ChooseCompanyMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "ChooseCompanyViewModel.h"

@interface ChooseCompanyMainView : BaseView
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ChooseCompanyViewModel *viewModel;
@end
