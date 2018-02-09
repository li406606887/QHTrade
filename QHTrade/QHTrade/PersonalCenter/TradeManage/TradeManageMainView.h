//
//  TradeManageMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "TradeManageViewModel.h"
#import "SegmentedControlView.h"
#import "TradingView.h"
#import "HistoryTradeView.h"

@interface TradeManageMainView : BaseView
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TradeManageViewModel *viewModel;
@property (nonatomic,strong) SegmentedControlView *segmentedControl;
@property (nonatomic,strong) TradingView *tradingView;
@property (nonatomic,strong) HistoryTradeView *historyTradeView;
@end
