//
//  MyPositionsMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "MyPositionsViewModel.h"
#import "SegmentedControlView.h"
#import "WareHouseView.h"
#import "TradeRecordView.h"

@interface MyPositionsMainView : BaseView
@property (nonatomic,strong) MyPositionsViewModel *viewModel;
@property (nonatomic,strong) SegmentedControlView *segmentedControl;
@property (nonatomic,strong) TradeRecordView *tradingSignalsView;//交易记录
@property (nonatomic,strong) WareHouseView *myWarehouseView;//我的持仓
@end
