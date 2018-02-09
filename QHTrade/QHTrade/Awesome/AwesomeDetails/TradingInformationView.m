//
//  TradingInformationView.m
//  QHTrade
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradingInformationView.h"
#import "AwesomeDetailsViewModel.h"
#import "SegmentedControlView.h"
#import "TradingSignalsView.h"
#import "MyWarehouseView.h"

@interface TradingInformationView()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) SegmentedControlView *segmentedControl;
@property(nonatomic,strong) TradingSignalsView *tradingSignalsView;
@property(nonatomic,strong) MyWarehouseView *myWarehouseView;
//@property(nonatomic,strong) EarningsSumView *earningSumView;
@property(nonatomic,  weak) BaseView *oldView;
@end

@implementation TradingInformationView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    self.oldView = self.myWarehouseView;
    [self addSubview:self.segmentedControl];
    [self addSubview:self.self.oldView];

}

-(void)updateConstraints {
    [super updateConstraints];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(30, 0, 0, 0));
    }];
}

-(void)changeChlidView:(int)index {
    [self.oldView removeFromSuperview];
    switch (index) {
        case 0:
            self.oldView = self.myWarehouseView;
            break;
        case 1:
            self.oldView = self.tradingSignalsView;
            break;
        default:
            break;
    }
    [self addSubview:self.oldView];
    [self updateConstraints];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(TradingSignalsView *)tradingSignalsView {
    if (!_tradingSignalsView) {
        _tradingSignalsView = [[TradingSignalsView alloc] initWithViewModel:self.viewModel];
    }
    return _tradingSignalsView;
}

-(MyWarehouseView *)myWarehouseView {
    if (!_myWarehouseView) {
        _myWarehouseView = [[MyWarehouseView alloc] initWithViewModel:self.viewModel];
    }
    return _myWarehouseView;
}

//-(EarningsSumView *)earningSumView {
//    if (!_earningSumView) {
//        _earningSumView = [[EarningsSumView alloc] initWithViewModel:self.viewModel];
////        _earningSumView.data = nil;
//    }
//    return _earningSumView;
//}

-(SegmentedControlView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) item:[NSArray arrayWithObjects:@"当前持仓",@"成交信号", nil]];
        _segmentedControl.defultTitleColor = [UIColor blackColor];
        _segmentedControl.selectedTitleColor = [UIColor whiteColor];
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = RGB(250, 99, 32);
        _segmentedControl.font = 15;
        _segmentedControl.layer.borderWidth = 0.5f;
        _segmentedControl.layer.borderColor = RGB(215, 215, 215).CGColor;
        @weakify(self);
        _segmentedControl.itemClick = ^(int index) {
            @strongify(self)
            self.viewModel.segmentedControlIndex = index;
            [self changeChlidView:index];
        };
    }
    return _segmentedControl;
}
@end
