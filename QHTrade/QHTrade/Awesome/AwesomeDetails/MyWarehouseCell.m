//
//  MyWarehouseCell.m
//  QHTrade
//
//  Created by user on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyWarehouseCell.h"

@interface MyWarehouseCell()
@property(nonatomic,strong) UILabel *contractName;//合约名称
@property(nonatomic,strong) UILabel *moreEmpty;//多空
@property(nonatomic,strong) UILabel *numberHand;//手数
@property(nonatomic,strong) UILabel *canUsed;//可用
@property(nonatomic,strong) UILabel *averageOpen;//开仓均价
@property(nonatomic,strong) UILabel *chasesGains;//逐笔浮盈
@end

@implementation MyWarehouseCell

-(void)setupViews {
    [self.contentView addSubview:self.contractName];
    [self.contentView addSubview:self.moreEmpty];
    [self.contentView addSubview:self.numberHand];
    [self.contentView addSubview:self.canUsed];
    [self.contentView addSubview:self.averageOpen];
    [self.contentView addSubview:self.chasesGains];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(void)updateConstraints {
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
//我的持仓model
-(void)setMyModel:(WarehouseModel *)myModel {
    if (myModel) {
        self.contractName.text = myModel.name;//id
        self.averageOpen.text = myModel.openAmount;
        self.moreEmpty.text = [myModel.posiDirection isEqualToString:@"2"] ==YES ? @"多":@"空";
        self.numberHand.text = myModel.position;
        self.canUsed.text = myModel.position;
        self.chasesGains.text = myModel.positionProfit;//逐笔浮盈
        self.moreEmpty.textColor = [myModel.posiDirection isEqualToString:@"2"] == YES ? RGB(247,56,96):RGB(56,204,110);
        self.chasesGains.textColor = [myModel.positionProfit intValue]>=0 == YES ? RGB(250, 15, 61):RGB(33, 209, 86);
    }
}

//合约名称
-(UILabel *)contractName {
    if (!_contractName) {
        _contractName = [[UILabel alloc] init];
        _contractName.textColor = RGB(67, 68, 69);
        _contractName.textAlignment = NSTextAlignmentCenter;
        _contractName.font = [UIFont systemFontOfSize:15];
    }
    return _contractName;
}
//多空
-(UILabel *)moreEmpty {
    if (!_moreEmpty) {
        _moreEmpty = [[UILabel alloc] init];
        _moreEmpty.textAlignment = NSTextAlignmentCenter;
        _moreEmpty.font = [UIFont systemFontOfSize:15];
    }
    return _moreEmpty;
}
//手数
-(UILabel *)numberHand {
    if (!_numberHand) {
        _numberHand = [[UILabel alloc] init];
//        _numberHand.textColor = RGB(134, 135, 136);
        _numberHand.textAlignment = NSTextAlignmentCenter;
        _numberHand.font = [UIFont systemFontOfSize:15];
    }
    return _numberHand;
}
//可用
-(UILabel *)canUsed {
    if (!_canUsed) {
        _canUsed = [[UILabel alloc] init];
        _canUsed.textAlignment = NSTextAlignmentCenter;
        _canUsed.font = [UIFont systemFontOfSize:15];
    }
    return _canUsed;
}
//开仓均价
-(UILabel *)averageOpen {
    if (!_averageOpen) {
        _averageOpen = [[UILabel alloc] init];
//        _averageOpen.textColor = RGB(134, 135, 136);
        _averageOpen.textAlignment = NSTextAlignmentCenter;
        _averageOpen.font = [UIFont systemFontOfSize:15];
    }
    return _averageOpen;
}
//逐笔浮盈
-(UILabel *)chasesGains {
    if (!_chasesGains) {
        _chasesGains = [[UILabel alloc] init];
        _chasesGains.textAlignment = NSTextAlignmentCenter;
        _chasesGains.font = [UIFont systemFontOfSize:15];
    }
    return _chasesGains;
}

@end
