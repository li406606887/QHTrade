//
//  AwesomeSignalMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "AwesomeSiganlViewModel.h"
@interface AwesomeSignalMainView : BaseView
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AwesomeSiganlViewModel *viewModel;
@end
