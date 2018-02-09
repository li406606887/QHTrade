//
//  EarningsSumDayView.m
//  QHTrade
//
//  Created by user on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EarningsSumDayView.h"
#import "GraphView.h"
#import "FollowEarningsDetailsViewModel.h"
#import "SegmentedControlView.h"

@interface EarningsSumDayView()
@property(nonatomic,strong) GraphView *lineChartView;
@property(nonatomic,strong) UILabel *promptEarningLabel;//收益率曲线提示label
@property(nonatomic,strong) SegmentedControlView *segmentedControl;//日 月
@property(nonatomic,strong) FollowEarningsDetailsViewModel *viewModel;
@property (nonatomic,strong) UILabel * nilLabel;
@end

@implementation EarningsSumDayView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowEarningsDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.promptEarningLabel];
    [self addSubview:self.segmentedControl];
    [self addSubview:self.nilLabel];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.promptEarningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(100, 50));
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    
    [self.nilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(250, 16));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshCurveGraphsubject subscribeNext:^(NSArray *  _Nullable array) {
        @strongify(self)
        [self.lineChartView removeFromSuperview];
        self.lineChartView = nil;
        if (array.count <1) {
            self.nilLabel.hidden = NO;
            return;
        }else{
            self.nilLabel.hidden = YES;
            [self addSubview:self.lineChartView];
        }
        NSMutableArray *dataY = [NSMutableArray array];//数据源
        NSMutableArray *dataX = [NSMutableArray array];//数据源
        for (NSDictionary *dic in array) {
            [dataY addObject:[NSString stringWithFormat:@"%.2f",[dic[@"value"] floatValue]]];
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
//-setda
//-(QHLineChartView *)lineChartView {
//    if(!_lineChartView){
//        
//    }
//    return _lineChartView;
//}

-(UILabel *)promptEarningLabel {
    if (!_promptEarningLabel) {
        _promptEarningLabel = [[UILabel alloc] init];
        _promptEarningLabel.numberOfLines = 2;
        _promptEarningLabel.attributedText = [NSAttributedString getAttributedStringWithString:@"总收益率曲线\n单位:%" littlefont:15 bigFont:10 defultTextColor:RGB(84, 85, 85) specialColor:RGB(49,49,49) range:NSMakeRange(0, 6)];
        _promptEarningLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _promptEarningLabel;
}

-(UIView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc]initWithFrame:CGRectMake(0, 0, 80, 30) item:[NSArray arrayWithObjects:@"日",@"月", nil]];
        _segmentedControl.defultTitleColor = RGB(84, 85, 86);
        _segmentedControl.selectedTitleColor = RGB(252, 99, 33);
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = [UIColor whiteColor];
        _segmentedControl.font = 15;
        @weakify(self)
        _segmentedControl.itemClick = ^(int index) {
            @strongify(self)
            switch (index) {
                case 0:
                    if(self.viewModel.dayDataArray.count>1){
                        [self.viewModel.refreshCurveGraphsubject sendNext:self.viewModel.dayDataArray];
                        return ;
                    }else{
                        [self.viewModel.curveGraphDayCommand execute:nil];
                    }
                    break;
                case 1:
                    if(self.viewModel.monthDataArray.count>1){
                        [self.viewModel.refreshCurveGraphsubject sendNext:self.viewModel.monthDataArray];
                        return ;
                    }else{
                        [self.viewModel.curveGraphMonthCommand execute:nil];
                    }
                    break;
                default:
                    break;
            }
            
        };
    }
    return _segmentedControl;
}

-(GraphView *)lineChartView{
    if(!_lineChartView){
        _lineChartView = [[GraphView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, SCREEN_HEIGHT-110-40-50-40-64)];
    }
    return _lineChartView;
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
@end
