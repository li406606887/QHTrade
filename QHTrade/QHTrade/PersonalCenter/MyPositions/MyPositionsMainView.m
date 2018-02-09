//
//  MyPositionsMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyPositionsMainView.h"


@interface MyPositionsMainView ()
@property(nonatomic,weak)BaseView *oldView;
@end

@implementation MyPositionsMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (MyPositionsViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    [self.viewModel.warehouseCommand execute:nil];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.myWarehouseView];
    
    self.oldView = self.myWarehouseView;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)layoutSubviews{
    
    WS(weakSelf)
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(5);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(SCREEN_HEIGHT-94);
    }];
    
    [super layoutSubviews];
}

-(TradeRecordView *)tradingSignalsView{
    
    if (!_tradingSignalsView) {
        _tradingSignalsView = [[TradeRecordView alloc]initWithViewModel:self.viewModel];
    }
    return _tradingSignalsView;
    
}
-(WareHouseView *)myWarehouseView{
    
    if (!_myWarehouseView) {
        _myWarehouseView = [[WareHouseView alloc]initWithViewModel:self.viewModel];
    }
    return _myWarehouseView;
}

-(SegmentedControlView *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) item:[NSArray arrayWithObjects:@"我的持仓",@"交易记录" ,nil]];
        _segmentedControl.defultTitleColor = [UIColor blackColor];
        _segmentedControl.selectedTitleColor = [UIColor whiteColor];
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = RGB(255, 98, 1);
        _segmentedControl.font = 15;
        _segmentedControl.layer.borderColor = RGB(215, 215, 215).CGColor;
        _segmentedControl.layer.borderWidth = 0.5f;
        WS(weakSelf)
        _segmentedControl.itemClick = ^(int index) {
            [weakSelf changeChlidView:index];
        };
    }
    return _segmentedControl;
}

-(void)changeChlidView:(int)index{
    
    switch (index) {
            
        case 0://我的持仓
            [self.viewModel.warehouseCommand execute:nil];
            [self.oldView removeFromSuperview];
            [self addSubview:self.myWarehouseView];
            self.oldView = self.myWarehouseView;
            break;
        case 1:
            [self.viewModel.tradeRecordCommand execute:nil];
            [self.oldView removeFromSuperview];
            [self addSubview:self.tradingSignalsView];
            self.oldView = self.tradingSignalsView;
            break;
            
        default:
            break;
    }
}
-(MyPositionsViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[MyPositionsViewModel alloc]init];
    }
    return _viewModel;
}

@end
