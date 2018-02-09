//
//  DiamondRecordCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondRecordCell.h"

@implementation DiamondRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    /*
     @property (nonatomic,strong) UILabel *label;
     @property (nonatomic,strong) UILabel *label1;
     @property (nonatomic,strong) UILabel *label2;
     @property (nonatomic,strong) UILabel *timeLabel;
     @property (nonatomic,strong) UILabel *moneyLabel;
     @property (nonatomic,strong) UILabel *diamondLabel;
     */
    
    [self addSubview:self.label];
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.diamondLabel];
    [self addSubview:self.timeLabel];
    
    WS(weakSelf)
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf).with.offset(-7);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 20));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.label);
        make.left.equalTo(weakSelf.label.mas_right);
        make.size.mas_offset(CGSizeMake(38, 20));
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.label);
        make.left.equalTo(weakSelf.moneyLabel.mas_right).with.offset(0);
        make.size.mas_offset(CGSizeMake(88, 20));
    }];
    
    [self.diamondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.label);
        make.left.equalTo(weakSelf.label1.mas_right);
        make.size.mas_offset(CGSizeMake(38, 20));
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.label);
        make.left.equalTo(weakSelf.diamondLabel.mas_right).with.offset(0);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
}
-(void)setModel:(DiamondRecordModel *)model {
    if (!model) {
        return;
    }
    _model = model;
    if (_model.payTime.length < 1) {
        self.timeLabel.text = @"----:--:-- --:--";
    }else self.timeLabel.text = [UserInformation formatTimeStampString:_model.payTime];
    self.diamondLabel.text = _model.diamond;
    self.moneyLabel.text = _model.diamond;
}
-(UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font  = [UIFont systemFontOfSize:12.f];
        _timeLabel.textColor = RGB(68,68,68);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"2000-1-11 12:00";
    }
    return _timeLabel;
    
}

-(UILabel *)diamondLabel{
    
    if (!_diamondLabel) {
        _diamondLabel = [[UILabel alloc]init];
        _diamondLabel.font  = [UIFont systemFontOfSize:14.f];
        _diamondLabel.textColor = RGB(255,98,1);
        _diamondLabel.textAlignment = NSTextAlignmentCenter;
        _diamondLabel.text =@"0000";
    }
    return _diamondLabel;
}
-(UILabel *)moneyLabel{

    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font  = [UIFont systemFontOfSize:14.f];
        _moneyLabel.textColor = RGB(255,0,0);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.text =@"0000";
    }
    return _moneyLabel;
}

-(UILabel *)label2{
    
    if (!_label2) {
        _label2 = [[UILabel alloc]init];
        _label2.font  = [UIFont systemFontOfSize:14.f];
        _label2.text = @"颗";
        
    }
    return _label2;
}
-(UILabel *)label1{
    
    if (!_label1) {
        _label1 = [[UILabel alloc]init];
        _label1.font  = [UIFont systemFontOfSize:14.f];
        _label1.text = @"元，购买钻石";
    }
    return _label1;
}

-(UILabel *)label{

    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.font  = [UIFont systemFontOfSize:14.f];
        _label.text = @"花费";
        
    }
    return _label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
