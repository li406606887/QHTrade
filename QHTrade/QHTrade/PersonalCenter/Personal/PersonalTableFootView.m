//
//  PersonalTableFootView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalTableFootView.h"

@implementation PersonalTableFootView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.nilLabel];
    [self addSubview:self.lineChartView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(6);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_offset(CGSizeMake(100, 18));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(3);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_offset(CGSizeMake(250, 16));
    }];
    
    [self.nilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(250, 16));
    }];
    [super updateConstraints];
}

-(GraphView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[GraphView alloc] initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 220)];
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

-(UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.text = @"每个交易日下午15点后结算，21点前更新";
        _subTitleLabel.textColor = RGB(141, 140, 140);
        _subTitleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _subTitleLabel;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"总收益曲线";
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _titleLabel;
}

@end
