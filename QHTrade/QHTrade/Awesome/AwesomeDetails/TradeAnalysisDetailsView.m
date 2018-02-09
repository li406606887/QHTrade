//
//  TradeAnalysisDetailsView.m
//  QHTrade
//
//  Created by user on 2017/12/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeAnalysisDetailsView.h"

@implementation TradeAnalysisDetailsView

-(void)setupViews {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = RGB(214, 214, 214).CGColor;
    
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self addSubview:self.thirdLabel];
    [self addSubview:self.fourthLabel];
    
    [self addSubview:self.firstValue];
    [self addSubview:self.secondValue];
    [self addSubview:self.thirdValue];
    [self addSubview:self.fourthValue];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(7);
        make.left.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).with.offset(11);
        make.left.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondLabel.mas_bottom).with.offset(11);
        make.left.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    
    [self.fourthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdLabel.mas_bottom).with.offset(11);
        make.left.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    
    [self.firstValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(7);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_offset(CGSizeMake(200, 14));
    }];
    
    [self.secondValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.secondLabel);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_offset(CGSizeMake(200, 14));
    }];
    
    [self.thirdValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.thirdLabel);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_offset(CGSizeMake(200, 14));
    }];
    
    [self.fourthValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fourthLabel);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_offset(CGSizeMake(200, 14));
    }];
    [super updateConstraints];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UILabel *)firstValue {
    if (!_firstValue) {
        _firstValue = [self getValueLabel];
    }
    return _firstValue;
}

-(UILabel *)secondValue {
    if (!_secondValue) {
        _secondValue = [self getValueLabel];
    }
    return _secondValue;
}

-(UILabel *)thirdValue {
    if (!_thirdValue) {
        _thirdValue = [self getValueLabel];
    }
    return _thirdValue;
}

-(UILabel *)fourthValue {
    if (!_fourthValue) {
        _fourthValue = [self getValueLabel];
    }
    return _fourthValue;
}

-(UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [self getTitleLabel];
    }
    return _firstLabel;
}

-(UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [self getTitleLabel];
    }
    return _secondLabel;
}

-(UILabel *)thirdLabel {
    if (!_thirdLabel) {
        _thirdLabel = [self getTitleLabel];
    }
    return _thirdLabel;
}

-(UILabel *)fourthLabel {
    if (!_fourthLabel) {
        _fourthLabel = [self getTitleLabel];
    }
    return _fourthLabel;
}

-(UILabel *)getValueLabel {
    UILabel *value = [[UILabel alloc] init];
    value.font = [UIFont systemFontOfSize:14];
    value.textAlignment = NSTextAlignmentRight;
    value.text = @"000000";
    return value;
}

-(UILabel *)getTitleLabel{
    UILabel * title =  [[UILabel alloc ] init];
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = RGB(51, 51, 51);
    return title;
}
@end
