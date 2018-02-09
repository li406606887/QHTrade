//
//  CallMarginRemindCell.m
//  PolicyAide
//
//  Created by 吴桂钊 on 2017/12/29.
//  Copyright © 2017年 QHTeam. All rights reserved.
//

#import "CallMarginRemindCell.h"
@interface CallMarginRemindCell ()
@property (nonatomic,strong) UILabel *contractName;//合约名称
@property (nonatomic,strong) UILabel *moreOrEmpty;
@property (nonatomic,strong) UILabel *price;//均价
@property (nonatomic,strong) UILabel *count;//手数
@end

@implementation CallMarginRemindCell
-(void)setupViews {
    [self addSubview:self.contractName];
    [self addSubview:self.moreOrEmpty];
    [self addSubview:self.price];
    [self addSubview:self.count];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)setModel:(WarehouseModel *)model{
    if (model) {
        self.count.text = model.position;
        self.price.text = model.openAmount;
        self.moreOrEmpty.text = [model.posiDirection intValue] == 2 ? @"多": @"空";
        self.moreOrEmpty.textColor = [model.posiDirection intValue] == 2 ? [UIColor redColor]: [UIColor greenColor];
        self.contractName.text = model.instrumentId;
    }
}

-(void)updateConstraints {
    
    [self.moreOrEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(0);
        make.top.bottom.equalTo(self);
        make.width.mas_offset(55);
    }];
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(0);
        make.top.bottom.equalTo(self);
        make.width.mas_offset(55);
    }];
    [self.contractName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.moreOrEmpty.mas_left);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.count.mas_right);
        make.top.bottom.right.equalTo(self);
    }];
    
    [super updateConstraints];
}
-(UILabel *)count {
    if (!_count) {
        _count = [[UILabel alloc]init];
        _count.text = @"手数";
        _count.textAlignment = NSTextAlignmentCenter;
        _count.layer.borderWidth = 1;
        _count.layer.borderColor = RGB(207, 207, 209).CGColor;
        _count.font = [UIFont systemFontOfSize:15];
    }
    return _count;
}
-(UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.text = @"开仓均价";
        _price.textAlignment = NSTextAlignmentCenter;
        _price.layer.borderWidth = 1;
        _price.layer.borderColor = RGB(207, 207, 209).CGColor;
        _price.font = [UIFont systemFontOfSize:15];
    }
    return _price;
}
-(UILabel *)moreOrEmpty {
    if (!_moreOrEmpty) {
        _moreOrEmpty = [[UILabel alloc]init];
        _moreOrEmpty.text = @"多空";
        _moreOrEmpty.textAlignment = NSTextAlignmentCenter;
        _moreOrEmpty.layer.borderWidth = 1;
        _moreOrEmpty.layer.borderColor = RGB(207, 207, 209).CGColor;
        _moreOrEmpty.font = [UIFont systemFontOfSize:15];
    }
    return _moreOrEmpty;
}
-(UILabel *)contractName {
    if (!_contractName) {
        _contractName = [[UILabel alloc]init];
        _contractName.text = @"合约名称";
        _contractName.textAlignment = NSTextAlignmentCenter;
        _contractName.layer.borderWidth = 1;
        _contractName.layer.borderColor = RGB(207, 207, 209).CGColor;
        _contractName.font = [UIFont systemFontOfSize:15];
    }
    return _contractName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
