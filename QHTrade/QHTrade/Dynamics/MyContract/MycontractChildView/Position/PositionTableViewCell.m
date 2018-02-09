
//
//  PositionTableViewCell.m
//  QHTrade
//
//  Created by user on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PositionTableViewCell.h"

@interface PositionTableViewCell()
@property(nonatomic,strong)UILabel *contractName;//合约名称
@property(nonatomic,strong)UILabel *moreEmpty;//多空
@property(nonatomic,strong)UILabel *numberHand;//手数
@property(nonatomic,strong)UILabel *canUsed;//可用
@property(nonatomic,strong)UILabel *averageOpen;//开仓均价
@property(nonatomic,strong)UILabel *chasesGains;//逐笔浮盈
@end


@implementation PositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupViews{
    [self.contentView addSubview:self.contractName];
    [self.contentView addSubview:self.moreEmpty];
    [self.contentView addSubview:self.numberHand];
    [self.contentView addSubview:self.canUsed];
    [self.contentView addSubview:self.averageOpen];
    [self.contentView addSubview:self.chasesGains];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self);
    [self.contractName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(85, 30));
        
    }];
    [self.moreEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.contractName.mas_right);
        make.size.mas_offset(CGSizeMake(39, 30));
    }];
    [self.numberHand mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.moreEmpty.mas_right);
        make.size.mas_offset(CGSizeMake(55, 30));
    }];
    [self.canUsed mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.numberHand.mas_right);
        make.size.mas_offset(CGSizeMake(55, 30));
    }];
    [self.averageOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.canUsed.mas_right);
        make.size.mas_offset(CGSizeMake(90, 30));
    }];
    [self.chasesGains mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self);
        make.left.equalTo(self.averageOpen.mas_right);
        make.size.mas_offset(CGSizeMake(90, 30));
    }];
}

-(void)setModel:(PositionModel *)model{
    if (model) {
        self.contractName.text = model.contractName;
        self.moreEmpty.text = model.moreEmpty ==YES ? @"多":@"空";
        self.moreEmpty.textColor = model.moreEmpty ==YES ? RGB(247,56,96):RGB(56,204,110);
        self.numberHand.text = model.numberHand;
        self.canUsed.text = model.canUsed;
        self.averageOpen.text = model.averageOpen;
        self.chasesGains.text = model.chasesGains;
    }
}

-(UILabel *)contractName{//合约名称
    if (!_contractName) {
        _contractName = [[UILabel alloc] init];
        _contractName.textColor = RGB(134, 135, 136);
        _contractName.textAlignment = NSTextAlignmentCenter;
        _contractName.font = [UIFont systemFontOfSize:15];
    }
    return _contractName;
}
-(UILabel *)moreEmpty{//多空
    if (!_moreEmpty) {
        _moreEmpty = [[UILabel alloc] init];
        _moreEmpty.textAlignment = NSTextAlignmentCenter;
        _moreEmpty.font = [UIFont systemFontOfSize:15];
    }
    return _moreEmpty;
}
-(UILabel *)numberHand{//手数
    if (!_numberHand) {
        _numberHand = [[UILabel alloc] init];
        _numberHand.textColor = RGB(134, 135, 136);
        _numberHand.textAlignment = NSTextAlignmentCenter;
        _numberHand.font = [UIFont systemFontOfSize:15];
    }
    return _numberHand;
}
-(UILabel *)canUsed{//可用
    if (!_canUsed) {
        _canUsed = [[UILabel alloc] init];
        _canUsed.textColor = RGB(134, 135, 136);
        _canUsed.textAlignment = NSTextAlignmentCenter;
        _canUsed.font = [UIFont systemFontOfSize:15];
    }
    return _canUsed;
}
-(UILabel *)averageOpen{//开仓均价
    if (!_averageOpen) {
        _averageOpen = [[UILabel alloc] init];
        _averageOpen.textColor = RGB(134, 135, 136);
        _averageOpen.textAlignment = NSTextAlignmentCenter;
        _averageOpen.font = [UIFont systemFontOfSize:15];
    }
    return _averageOpen;
}
-(UILabel *)chasesGains{//逐笔浮盈
    if (!_chasesGains) {
        _chasesGains = [[UILabel alloc] init];
        _chasesGains.textAlignment = NSTextAlignmentCenter;
        _chasesGains.font = [UIFont systemFontOfSize:15];
    }
    return _chasesGains;
}

@end
