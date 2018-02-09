//
//  TradeManageMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeManageMainView.h"

@interface TradeManageMainView ()
@property(nonatomic,weak)BaseView *oldView;

@end
@implementation TradeManageMainView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (TradeManageViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.tradingView];
    self.oldView = self.tradingView;
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}
- (void)layoutSubviews {
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    [self.oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(SCREEN_HEIGHT);
    }];
    [super layoutSubviews];
}

-(SegmentedControlView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) item:[NSArray arrayWithObjects:@"正在跟单",@"历史跟单" ,nil]];
        _segmentedControl.defultTitleColor = [UIColor blackColor];
        _segmentedControl.selectedTitleColor = [UIColor whiteColor];
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = RGB(255, 98, 1);
        _segmentedControl.font = 15;
        _segmentedControl.layer.borderWidth = 0.5f;
        _segmentedControl.layer.borderColor = RGB(215, 215, 215).CGColor;
        WS(weakSelf)
        _segmentedControl.itemClick = ^(int index) {
            [weakSelf changeChlidView:index];
        };
    }
    return _segmentedControl;
}

-(void)changeChlidView:(int)index {
    switch (index) {
        case 0:
            [self.viewModel.refreshDataCommand execute:nil];
            [self.oldView removeFromSuperview];
            [self addSubview:self.tradingView];
            self.oldView = self.tradingView;
            break;
        case 1:
            [self.viewModel.historyDataCommand execute:nil];
            [self.oldView removeFromSuperview];
            [self addSubview:self.historyTradeView];
            self.oldView = self.historyTradeView;
            break;
        default:
            break;
    }
}
-(HistoryTradeView *)historyTradeView {
    if (!_historyTradeView) {
        _historyTradeView = [[HistoryTradeView alloc]initWithViewModel:self.viewModel];
    }
    return _historyTradeView;
}
-(TradingView *)tradingView {
    if (!_tradingView) {
        _tradingView = [[TradingView alloc]initWithViewModel:self.viewModel];
    }
    return _tradingView;
}
-(TradeManageViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[TradeManageViewModel alloc]init];
    }
    return _viewModel;
}

@end
