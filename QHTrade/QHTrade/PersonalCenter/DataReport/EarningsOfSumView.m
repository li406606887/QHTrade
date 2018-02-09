//
//  EarningsOfSumView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EarningsOfSumView.h"
#import "GraphView.h"
#import "SegmentedControlView.h"
#import "DataReportViewModel.h"

@interface EarningsOfSumView ()
@property (nonatomic,strong) GraphView * lineChartView;
@property (nonatomic,strong) SegmentedControlView * segmentedControl;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIView  * lineView;
@property (nonatomic,strong) DataReportViewModel  *viewModel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UILabel * nilLabel;
@end

@implementation EarningsOfSumView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (DataReportViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    
    [self addSubview:self.timeLabel];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.nilLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(UILabel *)nilLabel {
    if (!_nilLabel) {
        _nilLabel = [[UILabel alloc]init];
        _nilLabel.text = @"暂无收益数据";
        _nilLabel.textColor = RGB(141, 140, 140);
        _nilLabel.font = [UIFont systemFontOfSize:16.0f];
        _nilLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nilLabel;
}
-(void)layoutSubviews {
    
    WS(weakSelf)
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.right.left.equalTo(weakSelf);
        make.height.mas_equalTo(25);
    }];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.segmentedControl);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weakSelf);
        make.height.mas_equalTo(1.5);
    }];
    [self.nilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_offset(CGSizeMake(250, 16));
    }];
    [super layoutSubviews];
}
-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = RGB(102, 102, 102);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.text = [NSString stringWithFormat:@"更新时间:%@",[NSDate getNowDate]];
    }
    return _timeLabel;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = RGB(196, 196, 196);
    }
    return _lineView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"总收益曲线";
        _titleLabel.font  = [UIFont systemFontOfSize:15.0f];
    }
    return _titleLabel;
}
-(UIView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, 80, 30) item:[NSArray arrayWithObjects:@"日",@"月", nil]];
        _segmentedControl.defultTitleColor = RGB(84, 85, 86);
        _segmentedControl.selectedTitleColor = RGB(252, 99, 33);
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = [UIColor whiteColor];
        _segmentedControl.font = 15;
        _segmentedControl.layer.masksToBounds = YES;
        _segmentedControl.layer.cornerRadius = 15;
        @weakify(self);
        _segmentedControl.itemClick = ^(int index) {
            @strongify(self)
            [self.viewModel.totalIncomeCommand execute:[NSNumber numberWithInteger:index+1]];
        };
    }
    return _segmentedControl;
}
-(void)bindViewModel {
    [[[self.viewModel.totalIncomeCommand executionSignals]switchToLatest] subscribeNext:^(NSArray * x) {
        [self.lineChartView removeFromSuperview];
        self.lineChartView = nil;
        if (x.count <1) {
            self.nilLabel.hidden = NO;
            return;
        }else{
            self.nilLabel.hidden = YES;
            [self addSubview:self.lineChartView];
        }
        NSMutableArray *dataY = [NSMutableArray array];//数据源
        NSMutableArray *dataX = [NSMutableArray array];//数据源
        for (NSDictionary *dic in x) {
            [dataY addObject:[NSString stringWithFormat:@"%.3f",[dic[@"value"] floatValue]]];
            NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            self.updataTime = str;
            [dataX addObject:[str substringFromIndex:5]];//时间
        }
        self.timeLabel.text = [NSString stringWithFormat:@"更新时间：%@",self.updataTime];
        NSNumber *maxNum = [dataY valueForKeyPath:@"@max.floatValue"];
        NSNumber *minNum = [dataY valueForKeyPath:@"@min.floatValue"];
        // 按顺序执行
        [self.lineChartView setYValueArray:dataY];
        [self.lineChartView setXTitleArray:dataX];
        [self.lineChartView setYMax:[maxNum floatValue]];
        [self.lineChartView setYMin:[minNum floatValue]];
        [self.lineChartView setTitleY:@""];
        [self.lineChartView showGraphView];
        
    }];
}

-(GraphView *)lineChartView{
    if(!_lineChartView){
        _lineChartView = [[GraphView alloc] initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, SCREEN_HEIGHT-385)];
    }
    return _lineChartView;
}


@end
