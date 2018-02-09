//
//  TradeAnalysisView.m
//  QHTrade
//
//  Created by user on 2017/12/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeAnalysisView.h"
#import "AwesomeDetailsViewModel.h"
#import "PieChartView.h"
#import "GraphView.h"
#import "TradeAnalysisDetailsView.h"
#import "TradeAnalysisModel.h"

@interface TradeAnalysisView()<UIScrollViewDelegate>
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) TradeAnalysisDetailsView *first;
@property(nonatomic,strong) TradeAnalysisDetailsView *second;
@property(nonatomic,strong) TradeAnalysisDetailsView *third;
@property(nonatomic,strong) TradeAnalysisDetailsView *fourth;
@property(nonatomic,strong) UILabel *graphTitleLabel;//累计盈亏曲线title
@property(nonatomic,strong) GraphView *incomeDayView;//累计盈亏曲线
@property(nonatomic,strong) UILabel *incomeWeekLabel;//周盈亏曲线title
@property(nonatomic,strong) GraphView *incomeWeekView;//周盈亏曲线
@property(nonatomic,strong) UILabel *incomeMonthLabel;//月盈亏曲线title
@property(nonatomic,strong) GraphView *incomeMonthView;//月盈亏曲线
@property(nonatomic,strong) UILabel *typeSuccessTitleLabel;//品种成交偏好title
@property(nonatomic,strong) PieChartView *transactionRatioView;//品种成交偏好
@property(nonatomic,strong) UILabel *typePositionTitleLabel;//品种持仓偏好title
@property(nonatomic,strong) PieChartView *positionRatioView;//品种持仓偏好
@end

@implementation TradeAnalysisView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scrollView];
    self.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.first];
    [self.scrollView addSubview:self.second];
    [self.scrollView addSubview:self.third];
    [self.scrollView addSubview:self.fourth];
    [self.scrollView addSubview:self.graphTitleLabel];
    [self.scrollView addSubview:self.incomeDayView];
    [self.scrollView addSubview:self.incomeWeekLabel];
    [self.scrollView addSubview:self.incomeWeekView];
    [self.scrollView addSubview:self.incomeMonthLabel];
    [self.scrollView addSubview:self.incomeMonthView];
    [self.scrollView addSubview:self.typeSuccessTitleLabel];
    [self.scrollView addSubview:self.transactionRatioView];
    [self.scrollView addSubview:self.typePositionTitleLabel];
    [self.scrollView addSubview:self.positionRatioView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(5);
        make.left.equalTo(self.scrollView).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-12.5, 103));
    }];
    
    [self.second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(5);
        make.left.equalTo(self.first.mas_right).with.offset(2.5);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-12.5, 103));
    }];
    
    [self.third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.first.mas_bottom).with.offset(7);
        make.centerX.equalTo(self.first);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-12.5, 103));
    }];
    
    [self.fourth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.second.mas_bottom).with.offset(7);
        make.centerX.equalTo(self.second);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-12.5, 103));
    }];
    
    [self.graphTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourth.mas_bottom).with.offset(9);
        make.left.equalTo(self.scrollView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.incomeDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.graphTitleLabel.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 300));
    }];
    
    [self.incomeWeekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeDayView.mas_bottom).with.offset(9);
        make.left.equalTo(self.scrollView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.incomeWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.incomeWeekLabel.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 300));
    }];
    
    [self.incomeMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeWeekView.mas_bottom).with.offset(9);
        make.left.equalTo(self.scrollView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.incomeMonthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.incomeMonthLabel.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 300));
    }];
    
    [self.typeSuccessTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.incomeMonthView.mas_bottom).with.offset(9);
        make.left.equalTo(self.scrollView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.transactionRatioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.typeSuccessTitleLabel.mas_bottom).with.offset(9);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 300));
    }];
    
    [self.typePositionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.transactionRatioView.mas_bottom).with.offset(9);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [self.positionRatioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.typePositionTitleLabel.mas_bottom).with.offset(9);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 300));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getTradeAnalysisDataCommand execute:nil];
    [self.viewModel.refreshTradeAnalysisSubject subscribeNext:^(TradeAnalysisModel  * model) {
        @strongify(self)
        self.first.firstValue.text = model.preBalance.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.preBalance floatValue]];//期初权益
        self.first.secondValue.text = model.dayAvgBalance.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.dayAvgBalance floatValue]];//日均权益
        self.first.thirdValue.text = model.balance.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.balance floatValue]];//期末权益
        self.first.fourthValue.text = model.totalNetDeposit.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.totalNetDeposit floatValue]];//净入金
        
        self.second.firstValue.text = model.tradeDayNum.length<1 ? @"0": [NSString stringWithFormat:@"%@",model.tradeDayNum];//交易天数
        self.second.secondValue.text = model.sectionProfit.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.sectionProfit floatValue]];//期间盈亏
        self.second.thirdValue.text = model.totalCommission.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.totalCommission floatValue]];//累计手续费
        self.second.fourthValue.text = model.totalTradeNum.length<1 ? @"0": [NSString stringWithFormat:@"%@",model.totalTradeNum];//交易总笔数
        
        self.third.firstValue.text = model.annualYield.length<1 ? @"0": [NSString stringWithFormat:@"%.2f%%",[model.annualYield floatValue]];//年化收益率
        self.third.secondValue.text = model.netWorthTotal.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.netWorthTotal floatValue]];//最新净值
        self.third.thirdValue.text = model.thirtyNetWorth.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.thirtyNetWorth floatValue]];//近30天净值
        self.third.fourthValue.text = model.riskProfitRatio.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.riskProfitRatio floatValue]];//收益风险比
        
        self.fourth.firstValue.text = model.withdrawalRateMax.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.withdrawalRateMax floatValue]];//历史最大回撤
        self.fourth.secondValue.text = model.withdrawalRate.length<1 ? @"0": [NSString stringWithFormat:@"%.2f",[model.withdrawalRate floatValue]];//单日最大回撤
        if (model.incomeDay.count>0) {
            NSMutableArray *dataY = [NSMutableArray array];//数据源
            NSMutableArray *dataX = [NSMutableArray array];//数据源
            for (NSDictionary *dic in model.incomeDay) {
                [dataY addObject:[NSString stringWithFormat:@"%.2f",[dic[@"value"] floatValue]]];
                NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                [dataX addObject:[str substringFromIndex:5]];//时间
                
            }
            NSNumber *maxNum = [dataY valueForKeyPath:@"@max.floatValue"];
            
            NSNumber *minNum = [dataY valueForKeyPath:@"@min.floatValue"];
            // 按顺序执行
            [self.incomeDayView setYValueArray:dataY];
            [self.incomeDayView setXTitleArray:dataX];
            [self.incomeDayView setYMax:[maxNum floatValue]];
            [self.incomeDayView setYMin:[minNum floatValue]];
            [self.incomeDayView setTitleY:@"单位/元"];
            [self.incomeDayView showGraphView];
        }
        NSLog(@"%@",model.incomeWeek);
        
        if (model.incomeWeek.count>0) {
            NSMutableArray *dataY = [NSMutableArray array];//数据源
            NSMutableArray *dataX = [NSMutableArray array];//数据源
            for (NSDictionary *dic in model.incomeDay) {
                [dataY addObject:[NSString stringWithFormat:@"%.2f",[dic[@"value"] floatValue]]];
                NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                [dataX addObject:[str substringFromIndex:5]];//时间
                
            }
            NSNumber *maxNum = [dataY valueForKeyPath:@"@max.floatValue"];
            
            NSNumber *minNum = [dataY valueForKeyPath:@"@min.floatValue"];
            // 按顺序执行
            [self.incomeWeekView setYValueArray:dataY];
            [self.incomeWeekView setXTitleArray:dataX];
            [self.incomeWeekView setYMax:[maxNum floatValue]];
            [self.incomeWeekView setYMin:[minNum floatValue]];
            [self.incomeWeekView setTitleY:@"单位/元"];
            [self.incomeWeekView showGraphView];
        }
        
        if (model.incomeMonth.count>0) {
            NSMutableArray *dataY = [NSMutableArray array];//数据源
            NSMutableArray *dataX = [NSMutableArray array];//数据源
            for (NSDictionary *dic in model.incomeDay) {
                [dataY addObject:[NSString stringWithFormat:@"%.2f",[dic[@"value"] floatValue]]];
                NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                [dataX addObject:[str substringFromIndex:5]];//时间
                
            }
            NSNumber *maxNum = [dataY valueForKeyPath:@"@max.floatValue"];
            
            NSNumber *minNum = [dataY valueForKeyPath:@"@min.floatValue"];
            // 按顺序执行
            [self.incomeMonthView setYValueArray:dataY];
            [self.incomeMonthView setXTitleArray:dataX];
            [self.incomeMonthView setYMax:[maxNum floatValue]];
            [self.incomeMonthView setYMin:[minNum floatValue]];
            [self.incomeMonthView setTitleY:@"单位/元"];
            [self.incomeMonthView showGraphView];
        }
       
        if (model.transactionRatio.count>0) {
            NSArray *array = model.transactionRatio;
            NSMutableArray *titleArray = [NSMutableArray array];
            NSMutableArray *ValueArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSString *value = [dic objectForKey:@"ratio"];
                NSString *name = [dic objectForKey:@"variety_ch"];
                [ValueArray addObject:value];
                [titleArray addObject:name];
            }
            self.transactionRatioView.valueArray = ValueArray;
            self.transactionRatioView.upTextItems = titleArray;
            [self.transactionRatioView showPieChartView];
        }
        
        if (model.positionRatio.count>0) {
            NSArray *array = model.positionRatio;
            NSMutableArray *titleArray = [NSMutableArray array];
            NSMutableArray *valueArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSString *value = [dic objectForKey:@"ratio"];
                NSString *name = [dic objectForKey:@"variety_ch"];
                [valueArray addObject:value];
                [titleArray addObject:name];
            }
            self.positionRatioView.valueArray = valueArray;
            self.positionRatioView.upTextItems = titleArray;
            [self.positionRatioView showPieChartView];
        }
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(0.5f, 2050);
    }
    return _scrollView;
}

-(TradeAnalysisDetailsView *)first {
    if (!_first) {
        _first = [[TradeAnalysisDetailsView alloc] initWithViewModel:self.viewModel];
        _first.firstLabel.text = @"期初权益";
        _first.secondLabel.text = @"日均权益";
        _first.thirdLabel.text = @"期末权益";
        _first.fourthLabel.text = @"净入金";
    }
    return _first;
}

-(TradeAnalysisDetailsView *)second {
    if (!_second) {
        _second = [[TradeAnalysisDetailsView alloc] initWithViewModel:self.viewModel];
        _second.firstLabel.text = @"交易天数";
        _second.secondLabel.text = @"期间盈亏";
        _second.thirdLabel.text = @"累计手续费";
        _second.fourthLabel.text = @"交易总笔数";
    }
    return _second;
}

-(TradeAnalysisDetailsView *)third {
    if (!_third) {
        _third = [[TradeAnalysisDetailsView alloc] initWithViewModel:self.viewModel];
        _third.firstLabel.text = @"年化收益值";
        _third.secondLabel.text = @"最新净值";
        _third.thirdLabel.text = @"近30天净值";
        _third.fourthLabel.text = @"收益风险比";
    }
    return _third;
}

-(TradeAnalysisDetailsView *)fourth {
    if (!_fourth) {
        _fourth = [[TradeAnalysisDetailsView alloc] initWithViewModel:self.viewModel];
        _fourth.firstLabel.text = @"历史最大回撤";
        _fourth.secondLabel.text = @"单日最大回撤";
        _fourth.thirdValue.text = @"";
        _fourth.fourthValue.text = @"";
    }
    return _fourth;
}

-(UILabel *)graphTitleLabel {
    if (!_graphTitleLabel) {
        _graphTitleLabel = [[UILabel alloc] init];
        _graphTitleLabel.text = @"  累计盈亏曲线";
        _graphTitleLabel.backgroundColor = RGB(200, 200, 200);
        _graphTitleLabel.textColor = RGB(51, 51, 51);
        _graphTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _graphTitleLabel;
}

-(GraphView *)incomeDayView {
    if (!_incomeDayView) {
        _incomeDayView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 300)];
    }
    return _incomeDayView;
}

-(UILabel *)incomeWeekLabel {
    if (!_incomeWeekLabel) {
        _incomeWeekLabel = [[UILabel alloc] init];
        _incomeWeekLabel.text = @"  周盈亏曲线";
        _incomeWeekLabel.backgroundColor = RGB(200, 200, 200);
        _incomeWeekLabel.textColor = RGB(51, 51, 51);
        _incomeWeekLabel.font = [UIFont systemFontOfSize:15];
    }
    return _incomeWeekLabel;
}

-(GraphView *)incomeWeekView {
    if (!_incomeWeekView) {
        _incomeWeekView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 300)];
        
    }
    return _incomeWeekView;
}

-(UILabel *)incomeMonthLabel {
    if (!_incomeMonthLabel) {
        _incomeMonthLabel = [[UILabel alloc] init];
        _incomeMonthLabel.text = @"  月盈亏曲线";
        _incomeMonthLabel.backgroundColor = RGB(200, 200, 200);
        _incomeMonthLabel.textColor = RGB(51, 51, 51);
        _incomeMonthLabel.font = [UIFont systemFontOfSize:15];
    }
    return _incomeMonthLabel;
}

-(GraphView *)incomeMonthView {
    if (!_incomeMonthView) {
        _incomeMonthView = [[GraphView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 300)];
       
    }
    return _incomeMonthView;
}

-(UILabel *)typeSuccessTitleLabel {
    if (!_typeSuccessTitleLabel) {
        _typeSuccessTitleLabel = [[UILabel alloc] init];
        _typeSuccessTitleLabel.text = @"  品种成交偏好";
        _typeSuccessTitleLabel.backgroundColor = RGB(200, 200, 200);
        _typeSuccessTitleLabel.textColor = RGB(51, 51, 51);
        _typeSuccessTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _typeSuccessTitleLabel;
}

-(PieChartView *)transactionRatioView {
    if (!_transactionRatioView) {
        _transactionRatioView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _transactionRatioView.pieCenter = _transactionRatioView.center;
        _transactionRatioView.pieW = 14;
        _transactionRatioView.pieR = 175/2;
    }
    return _transactionRatioView;
}

-(UILabel *)typePositionTitleLabel {
    if (!_typePositionTitleLabel) {
        _typePositionTitleLabel = [[UILabel alloc] init];
        _typePositionTitleLabel.text = @"  品种持仓偏好";
        _typePositionTitleLabel.backgroundColor = RGB(200, 200, 200);
        _typePositionTitleLabel.textColor = RGB(51, 51, 51);
        _typePositionTitleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _typePositionTitleLabel;
}

-(PieChartView *)positionRatioView {
    if (!_positionRatioView) {
        _positionRatioView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _positionRatioView.pieCenter = _positionRatioView.center;
        _positionRatioView.pieW = 14;
        _positionRatioView.pieR = 175/2;
    }
    return _positionRatioView;
}
@end
