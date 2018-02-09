//
//  HomeQuotationView.m
//  QHTrade
//
//  Created by user on 2017/8/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeQuotationView.h"

@interface HomeQuotationView ()
@property(nonatomic,strong) UIImageView *backImageView;
@property(nonatomic,strong) UILabel *name;//名字
@property(nonatomic,strong) UILabel *latestPrice;//价格
@property(nonatomic,strong) UILabel *riseFall;//涨跌
@property(nonatomic,strong) UILabel *riseFallPercentage;//涨跌幅度
@end

@implementation HomeQuotationView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    return [super initWithViewModel:viewModel];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backImageView];
    [self addSubview:self.name];
    [self addSubview:self.latestPrice];
    [self addSubview:self.riseFall];
    [self addSubview:self.riseFallPercentage];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    
    [self.latestPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    
    [self.riseFall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15);
        make.size.mas_offset(CGSizeMake(60, 15));
    }];
    
    [self.riseFallPercentage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-15);
        make.size.mas_offset(CGSizeMake(80, 15));
    }];
}

-(void)setModel:(ContractModel *)model{
    self.name.text = model.name;
    self.latestPrice.text = model.QLastPrice;
    self.riseFall.text = model.QChangeValue;
    self.riseFallPercentage.text = [NSString stringWithFormat:@"%.2f%%",[model.QChangeRate floatValue]];
    self.riseFallPercentage.textColor = [model.QChangeRate doubleValue]<0? RGB(0, 198, 61): [UIColor redColor];
    self.latestPrice.textColor = [model.QChangeValue doubleValue]<0 ? RGB(0, 198, 61):[UIColor redColor];
    self.riseFall.textColor = [model.QChangeValue doubleValue]<0? RGB(0, 198, 61):[UIColor redColor];
}
-(void)setModelData:(HomeQuotationModel *)modelData {
    if (modelData) {
        self.latestPrice.text = modelData.QLastPrice;
        self.riseFall.text = modelData.QChangeValue;
        self.riseFallPercentage.text = [NSString stringWithFormat:@"%.2f%%",[modelData.QChangeRate floatValue]];
        self.riseFallPercentage.textColor = [modelData.QChangeRate doubleValue]<0? RGB(0, 198, 61): [UIColor redColor];
        self.latestPrice.textColor = [modelData.QChangeValue doubleValue]<0 ? RGB(0, 198, 61):[UIColor redColor];
        self.riseFall.textColor = [modelData.QChangeValue doubleValue]<0? RGB(0, 198, 61):[UIColor redColor];
    }
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"合约名称";
        _name.font = [UIFont systemFontOfSize:15];
        _name.textColor = RGB(51, 51, 3);
        _name.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

-(UILabel *)latestPrice {
    if (!_latestPrice) {
        _latestPrice = [[UILabel alloc] init];
        _latestPrice.text = @"----";
        _latestPrice.textAlignment = NSTextAlignmentCenter;
        _latestPrice.textColor = [UIColor redColor];
        _name.font = [UIFont systemFontOfSize:18];
        
    }
    return _latestPrice;
}

-(UILabel *)riseFall {
    if (!_riseFall) {
        _riseFall = [[UILabel alloc] init];
        _riseFall.text = @"--";
        _riseFall.textColor = [UIColor redColor];
        _riseFall.font = [UIFont systemFontOfSize:12];
        
    }
    return _riseFall;
}

-(UILabel *)riseFallPercentage {
    if (!_riseFallPercentage) {
        _riseFallPercentage = [[UILabel alloc] init];
        _riseFallPercentage.text = @"0.00%";
        _riseFallPercentage.textAlignment = NSTextAlignmentRight;
        _riseFallPercentage.font = [UIFont systemFontOfSize:12];
        _riseFallPercentage.textColor = [UIColor redColor];
    }
    return _riseFallPercentage;
}

-(UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageWithStretchableName:@"Home_CollectionView_Background" orginX:20 orginY:14];
    }
    return _backImageView;
}

@end
