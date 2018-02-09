//
//  AwesomeSignalCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//
#define TITLE_GRAY RGB(218, 218, 218)
#define TITLE_GREEN RGB(2, 213, 136)
#define TITLE_ORANGE RGB(255,134,59)

#import "AwesomeSignalCell.h"

@implementation AwesomeSignalCell
-(void)setupViews {
    self.contentView.backgroundColor = RGB(243, 244, 245);
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.promptLabel];
    [self.contentView addSubview:self.firstLabel];
    [self.contentView addSubview:self.awesomeNameLabel];
    [self.contentView addSubview:self.secondLabel];
    [self.contentView addSubview:self.thirdLabel];
    [self.contentView addSubview:self.contractLabel];
    [self.contentView addSubview:self.fourthLabel];
    [self.contentView addSubview:self.orderSideLabel];
    [self.contentView addSubview:self.fivethLabel];
    [self.contentView addSubview:self.orderPriceLabel];
    [self.contentView addSubview:self.sixthLabel];
    [self.contentView addSubview:self.orderLotLabel];
    [self.contentView addSubview:self.seventhLabel];
    [self.contentView addSubview:self.timeLabel];
//    [self.contentView addSubview:self.eighthLabel];
//    [self.contentView addSubview:self.tradeStateLabel];
    
    [super setNeedsUpdateConstraints];
    [super updateConstraintsIfNeeded];
}
-(void)updateConstraints {
   
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(10, 16, 10, 16));
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(30);
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promptLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(88, 20));
    }];
    
    [self.awesomeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.firstLabel);
        make.left.equalTo(self.firstLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(99, 20));
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.awesomeNameLabel);
        make.left.equalTo(self.awesomeNameLabel.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(130, 20));
    }];
    
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 20));
    }];
    
    [self.contractLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.thirdLabel);
        make.left.equalTo(self.thirdLabel.mas_right);
        make.size.mas_offset(CGSizeMake(220, 20));
    }];
    
    [self.fourthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 20));
    }];
    
    [self.orderSideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fourthLabel);
        make.left.equalTo(self.fourthLabel.mas_right);
        make.size.mas_offset(CGSizeMake(220, 20));
    }];
    
    [self.fivethLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fourthLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 20));
    }];
    
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fivethLabel);
        make.left.equalTo(self.fivethLabel.mas_right);
        make.size.mas_offset(CGSizeMake(220, 20));
    }];
    [self.sixthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fivethLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 20));
    }];
    
    [self.orderLotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sixthLabel);
        make.left.equalTo(self.sixthLabel.mas_right);
        make.size.mas_offset(CGSizeMake(220, 20));
    }];
    
    [self.seventhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sixthLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(75, 20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seventhLabel);
        make.left.equalTo(self.seventhLabel.mas_right);
        make.size.mas_offset(CGSizeMake(220, 20));
    }];
    
//    [self.eighthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.seventhLabel.mas_bottom).with.offset(5);
//        make.left.equalTo(self.bgView).with.offset(10);
//        make.size.mas_offset(CGSizeMake(75, 20));
//    }];
//    
//    [self.tradeStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.eighthLabel);
//        make.left.equalTo(self.eighthLabel.mas_right);
//        make.size.mas_offset(CGSizeMake(220, 20));
//    }];
    
    [super updateConstraints];
}
-(void)setModel:(AwesomeSignalModel *)model {
    if (model) {
        self.awesomeNameLabel.text = model.userName;//牛人名字
        self.contractLabel.text = model.futuresName;//合约
        
        switch ([model.direction integerValue]) {
            case 1:
            {
                self.orderSideLabel.text = @"买入开仓";//方向
            }
                break;
            case 2:
            {
                self.orderSideLabel.text = @"卖出平仓";//方向
            }
                break;
            case 3:
            {
                self.orderSideLabel.text = @"卖出开仓";//方向
            }
                break;
            case 4:
            {
                self.orderSideLabel.text = @"买入平仓";//方向
            }
                break;
                
            default:
                break;
        }
//        下单方向 1买入开仓 2卖出平仓 3卖出开仓 4买入平仓
        self.orderLotLabel.text = model.volume;//手数
        
        self.timeLabel.text = [UserInformation formatTimeStampString:model.tradeTime];
        self.orderPriceLabel.text = model.price;
        
//        self.tradeStateLabel.text = model.tradeStateStr;
        
        if ([model.tradeStateStr isEqualToString:@"交易成功"]) {
            self.promptLabel.backgroundColor = TITLE_GREEN;
            self.tradeStateLabel.textColor = TITLE_GREEN;
        }else if ([model.tradeStateStr isEqualToString:@"交易所关闭，下单失败"]) {
            self.promptLabel.backgroundColor = TITLE_GRAY;
            self.tradeStateLabel.textColor = TITLE_GRAY;
        }else {
            self.promptLabel.backgroundColor = TITLE_ORANGE;
            self.tradeStateLabel.textColor = TITLE_ORANGE;
        }
    }
}

-(UILabel *)tradeStateLabel {
    if (!_tradeStateLabel) {
        _tradeStateLabel = [[UILabel alloc]init];
        _tradeStateLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _tradeStateLabel;
}
-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = RGB(255, 98, 1);
        _timeLabel.font = [UIFont systemFontOfSize:14.0f];
        _timeLabel.text = @"sssssss";
    }
    return _timeLabel;
}

-(UILabel *)orderLotLabel {
    if (!_orderLotLabel) {
        _orderLotLabel = [[UILabel alloc]init];
        _orderLotLabel.textColor = RGB(255, 98, 1);
        _orderLotLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _orderLotLabel;
}

-(UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [[UILabel alloc]init];
        _orderPriceLabel.textColor = RGB(255, 98, 1);
        _orderPriceLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _orderPriceLabel;
}
-(UILabel *)orderSideLabel {
    if (!_orderSideLabel) {
        _orderSideLabel = [[UILabel alloc]init];
        _orderSideLabel.textColor = RGB(255, 98, 1);
        _orderSideLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _orderSideLabel;
}
-(UILabel *)contractLabel {
    if (!_contractLabel) {
        _contractLabel = [[UILabel alloc]init];
        _contractLabel.textColor = RGB(255, 98, 1);
        _contractLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _contractLabel;
}
-(UILabel *)eighthLabel{
    if (!_eighthLabel) {
        _eighthLabel = [[UILabel alloc]init];
        _eighthLabel.text = @"交易状态：";
        _eighthLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _eighthLabel;
}
-(UILabel *)seventhLabel{
    if (!_seventhLabel) {
        _seventhLabel = [[UILabel alloc]init];
        _seventhLabel.text = @"下单时间：";
        _seventhLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _seventhLabel;
}
-(UILabel *)sixthLabel{
    if (!_sixthLabel) {
        _sixthLabel = [[UILabel alloc]init];
        _sixthLabel.text = @"下单手数：";
        _sixthLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _sixthLabel;
}
-(UILabel *)fivethLabel{
    if (!_fivethLabel) {
        _fivethLabel = [[UILabel alloc]init];
        _fivethLabel.text = @"成交价格：";
        _fivethLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _fivethLabel;
}
-(UILabel *)fourthLabel{
    if (!_fourthLabel) {
        _fourthLabel = [[UILabel alloc]init];
        _fourthLabel.text = @"下单方向：";
        _fourthLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _fourthLabel;
}
-(UILabel *)thirdLabel{
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc]init];
        _thirdLabel.text = @"合约名称：";
        _thirdLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _thirdLabel;
}
-(UILabel *)awesomeNameLabel{
    if (!_awesomeNameLabel) {
        _awesomeNameLabel = [[UILabel alloc]init];
        _awesomeNameLabel.text = @"牛人的名字";
        _awesomeNameLabel.font = [UIFont systemFontOfSize:14.0f];
        _awesomeNameLabel.textAlignment = NSTextAlignmentLeft;
        _awesomeNameLabel.textColor = RGB(0, 84, 255);
    }
    return _awesomeNameLabel;
}
-(UILabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc]init];
        _secondLabel.text = @"有新的交易信号啦";
        _secondLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _secondLabel;
}
-(UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]init];
        _firstLabel.text = @"你订阅的牛人";
        _firstLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _firstLabel;
}

-(UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-32, 30)];
        _promptLabel.textColor = [UIColor whiteColor];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont systemFontOfSize:15.0f];
        _promptLabel.text = @"下单提示";
        //设置圆角
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_promptLabel.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = _promptLabel.bounds;
        maskLayer1.path = maskPath1.CGPath;
        _promptLabel.layer.mask = maskLayer1;
    }
    return _promptLabel;
}
-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.borderWidth = 1.f;
        _bgView.layer.borderColor = RGB(222, 222, 222).CGColor;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
@end
