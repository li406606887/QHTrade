//
//  AwesomeIntroductionView.m
//  QHTrade
//
//  Created by user on 2017/11/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeIntroductionView.h"
#import "AwesomeDetailsViewModel.h"
#import "AwesomeModel.h"
#import "TradersInstructionsView.h"
#import "TradingInformationView.h"
#import "AwesomeIntroductionHeadView.h"

@interface AwesomeIntroductionView ()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) AwesomeIntroductionHeadView *awesomeDetailsHeadView;//牛人信息
@property(nonatomic,strong) TradersInstructionsView *tradersInstructionsView;//操盘说明View
@property(nonatomic,strong) TradingInformationView *tradingInformationView;//交易信息view
@property(nonatomic,assign) CGFloat instructionsHeight;//操作说明ViewHeight
@end

@implementation AwesomeIntroductionView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.awesomeDetailsHeadView];
    [self.scroll addSubview:self.tradersInstructionsView];
    [self.scroll addSubview:self.tradingInformationView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.tradersInstructionsOpenSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
            self.instructionsHeight = [x intValue] ==1 ? self.viewModel.tradersInstructionsHeight+59:59+12;
            _scroll.contentSize = [x intValue]==1?CGSizeMake(0.5,574+self.viewModel.tradersInstructionsHeight):CGSizeMake(0.5,574+12);
            [self updateConstraints];
    }];
    
    [self.viewModel.investorPositionSubject subscribeNext:^(id  _Nullable x) {
        [self.scroll.mj_header endRefreshing];
    }];
    
    [self.viewModel.tradeSignalsRefreshUISubject subscribeNext:^(id  _Nullable x) {
        [self.scroll.mj_header endRefreshing];
    }];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.edges.equalTo(self);
    }];
    
    [self.awesomeDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.top.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 110));
    }];
    
    [self.tradersInstructionsView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.leftMargin.rightMargin.equalTo(self);
        make.top.equalTo(self.awesomeDetailsHeadView.mas_bottom).with.offset(5);
        make.height.mas_offset(self.instructionsHeight);
    }];
    
    [self.tradingInformationView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH,400));
        make.top.equalTo(self.tradersInstructionsView.mas_bottom);
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.contentSize = CGSizeMake(0.5,586);
        @weakify(self)
        _scroll.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            if (self.viewModel.segmentedControlIndex ==0) {
                [self.viewModel.investorPositionCommand execute:nil];
            }else {
                [self.viewModel.tradeSignalsCommand execute:nil];
            }
        }];
    }
    return _scroll;
}

-(AwesomeIntroductionHeadView *)awesomeDetailsHeadView {
    if (!_awesomeDetailsHeadView) {
        _awesomeDetailsHeadView = [[AwesomeIntroductionHeadView alloc] initWithViewModel:self.viewModel];
        _awesomeDetailsHeadView.layer.shadowOpacity = 0.3;// 阴影透明度
        _awesomeDetailsHeadView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _awesomeDetailsHeadView.layer.shadowRadius = 1;// 阴影扩散的范围控制
        _awesomeDetailsHeadView.layer.shadowOffset  = CGSizeMake(0, 1);// 阴影的范围
    }
    return _awesomeDetailsHeadView;
}

-(TradersInstructionsView *)tradersInstructionsView {
    if (!_tradersInstructionsView) {
        _tradersInstructionsView = [[TradersInstructionsView alloc] initWithViewModel:self.viewModel];
    }
    return _tradersInstructionsView;
}

-(TradingInformationView *)tradingInformationView {
    if (!_tradingInformationView) {
        _tradingInformationView = [[TradingInformationView alloc] initWithViewModel:self.viewModel];
        
    }
    return _tradingInformationView;
}

-(CGFloat)instructionsHeight {
    if (!_instructionsHeight) {
        _instructionsHeight = 68.0f;
    }
    return _instructionsHeight;
}
@end
