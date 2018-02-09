//
//  RateOfEarningsView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "RateOfEarningsView.h"
#import "GraphView.h"
#import "SegmentedControlView.h"
#import "DataReportViewModel.h"

@interface RateOfEarningsView ()
@property (nonatomic,strong) GraphView * lineChartView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * unitLabel;
@property (nonatomic,strong) SegmentedControlView * segmentedControl;
@property (nonatomic,strong) DataReportViewModel * viewModel;
@property (nonatomic,strong) UILabel * nilLabel;
@end

@implementation RateOfEarningsView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (DataReportViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.unitLabel];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.nilLabel];
    [super setNeedsUpdateConstraints];
    [super updateConstraintsIfNeeded];
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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(5);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(100, 25));
    }];
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.titleLabel);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.nilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(weakSelf);
        make.size.mas_offset(CGSizeMake(250, 16));
    }];
    [super layoutSubviews];
}


-(void)bindViewModel {
    [[[self.viewModel.totalProfitCommand executionSignals] switchToLatest] subscribeNext:^(NSArray * x) {
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
            [dataX addObject:[str substringFromIndex:5]];//时间
        }
     
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
-(UIView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)
                                                                   item:[NSArray arrayWithObjects:@"日",@"月", nil]];
        _segmentedControl.defultTitleColor = RGB(84, 85, 86);
        _segmentedControl.selectedTitleColor = RGB(252, 99, 33);
         _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = [UIColor whiteColor];
        _segmentedControl.font = 15;
        @weakify(self)
        _segmentedControl.itemClick = ^(int index) {
            @strongify(self)
            [self.viewModel.totalProfitCommand execute:[NSNumber numberWithInteger:index+1]];
        };
    }
    return _segmentedControl;
}

-(UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc]init];
        _unitLabel.font = [UIFont systemFontOfSize:12.0f];
        _unitLabel.textColor = RGB(169, 169, 169);
        _unitLabel.text = @"单位：%";
    }
    return _unitLabel;
}
-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"总收益率曲线";
    }
    return _titleLabel;
}

-(GraphView *)lineChartView{
    if(!_lineChartView){
        _lineChartView = [[GraphView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, SCREEN_HEIGHT-385)];
        
    }
    return _lineChartView;
}


@end
