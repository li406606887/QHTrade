//
//  TradeManageCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeManageCell.h"

@implementation TradeManageCell
-(void)setupViews {
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.cancleButton];
    [self.contentView addSubview:self.evaluatButton];
    [self.contentView addSubview:self.followTitle];
    [self.contentView addSubview:self.proportion];
    [self.contentView addSubview:self.tradeType];
    [self.contentView addSubview:self.hops];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.left.equalTo(self.headImgView.mas_right).with.offset(15);
        make.size.mas_offset(CGSizeMake(130, 20));
    }];
    
    [self.evaluatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.right.equalTo(self.evaluatButton.mas_left).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(75, 30));
    }];
    
    [self.followTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).with.offset(15);
        make.top.equalTo(self.headImgView.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(60, 14));
    }];
    
    [self.proportion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.followTitle.mas_right);
        make.centerY.equalTo(self.followTitle);
        make.size.mas_offset(CGSizeMake(30, 14));
    }];
    
    [self.tradeType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.proportion.mas_right).with.offset(10);
        make.centerY.equalTo(self.followTitle);
        make.size.mas_offset(CGSizeMake(75, 14));
    }];
    
    [self.hops mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tradeType.mas_right).with.offset(10);
        make.centerY.equalTo(self.followTitle);
        make.size.mas_offset(CGSizeMake(0, 0));
    }];
}

-(void)setModel:(TradeManageModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink ,_model.userImg]];
    [self.headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
    self.nickNameLabel.text = _model.userName;
    self.userId = _model.userId;
    self.proportion.text = [NSString stringWithFormat:@"1:%@",model.numScale];
    self.tradeType.text = [model.priceType intValue] == 1 ? @"牛人成交价格": @"合约市价";
    self.hops.text = model.jumpPoint.length<1? @"": [NSString stringWithFormat:@"跳%@点",model.jumpPoint];
    self.hops.hidden = [model.priceType intValue] == 1 ? NO: YES;
    if (model.jumpPoint.length>=1) {
        [self.hops mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(40, 14));
        }];
    }
    
}

-(UIButton *)evaluatButton {
    if (!_evaluatButton) {
        _evaluatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _evaluatButton.layer.cornerRadius = 3;
        _evaluatButton.layer.masksToBounds = YES;
        [_evaluatButton setBackgroundColor:RGB(255, 125, 45) forState:UIControlStateNormal];
        [_evaluatButton setTitle:@"评价" forState:UIControlStateNormal];
        _evaluatButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_evaluatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[_evaluatButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.evaluatBlock) {
                self.evaluatBlock(self.model);
            }
        }];
    }
    return _evaluatButton;
}

-(UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.layer.cornerRadius = 3;
        _cancleButton.layer.masksToBounds = YES;
        [_cancleButton setBackgroundColor:RGB(229, 229, 229) forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消跟单" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [[_cancleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.cancleBlock) {
                self.cancleBlock(self.model);
            }
        }];
    }
    return _cancleButton;
}

-(UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nickNameLabel.text = @"用户昵称";
    }
    return _nickNameLabel;
}

-(UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_minilogo"]];
        _headImgView.layer.cornerRadius = 15;
        _headImgView.layer.masksToBounds = YES;
    }
    return _headImgView;
}

-(UILabel *)followTitle {
    if (!_followTitle) {
        _followTitle = [[UILabel alloc] init];
        _followTitle.font = [UIFont systemFontOfSize:12];
        _followTitle.textColor = RGB(51, 51, 51);
        _followTitle.text = @"跟单情况:";
    }
    return _followTitle;
}

-(UILabel *)proportion {
    if (!_proportion) {
        _proportion = [[UILabel alloc] init];
        _proportion.layer.masksToBounds = YES;
        _proportion.layer.cornerRadius = 3;
        _proportion.layer.borderWidth = 0.5f;
        _proportion.layer.borderColor = RGB(255, 98, 1).CGColor;
        _proportion.text = @"1:1";
        _proportion.textColor = RGB(255, 98, 1);
        _proportion.font = [UIFont systemFontOfSize:12];
        _proportion.textAlignment = NSTextAlignmentCenter;
    }
    return _proportion;
}

-(UILabel *)tradeType {
    if (!_tradeType) {
        _tradeType = [[UILabel alloc] init];
        _tradeType.layer.masksToBounds = YES;
        _tradeType.layer.cornerRadius = 3;
        _tradeType.layer.borderWidth = 0.5f;
        _tradeType.layer.borderColor = RGB(255, 98, 1).CGColor;
        _tradeType.text = @"牛人成交价";
        _tradeType.textColor = RGB(255, 98, 1);
        _tradeType.font = [UIFont systemFontOfSize:12];
        _tradeType.textAlignment = NSTextAlignmentCenter;
    }
    return _tradeType;
}

-(UILabel *)hops {
    if (!_hops) {
        _hops = [[UILabel alloc] init];
        _hops.layer.masksToBounds = YES;
        _hops.layer.cornerRadius = 3;
        _hops.layer.borderWidth = 0.5f;
        _hops.layer.borderColor = RGB(255, 98, 1).CGColor;
        _hops.text = @"5点";
        _hops.textColor = RGB(255, 98, 1);
        _hops.font = [UIFont systemFontOfSize:12];
        _hops.textAlignment = NSTextAlignmentCenter;
    }
    return _hops;
}
@end
