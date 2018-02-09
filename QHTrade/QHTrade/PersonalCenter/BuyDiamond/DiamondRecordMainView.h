//
//  DiamondRecordMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "DiamondRecordViewModel.h"
@interface DiamondRecordMainView : BaseView


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) DiamondRecordViewModel  *viewModel;
@end
