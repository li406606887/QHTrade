//
//  FollowEarningChooseCell.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningChooseCell.h"

@interface FollowEarningChooseCell()
@property(nonatomic,strong) UIButton *selecBtn;//选中按钮
@property(nonatomic,strong) UILabel *titleLabel;//标题
@property(nonatomic,strong) UILabel *text;//标题
@property(nonatomic,strong) UILabel *priceLabel;//价格
@property(nonatomic,strong) UIImageView *diamond;//图标
@property(nonatomic,strong) UILabel *proportion;//比例
@property(nonatomic,strong) UILabel *successPrice;//成交价
@property(nonatomic,strong) UILabel *hops;//跳点
@end

@implementation FollowEarningChooseCell

-(void)setupViews{
    [self.contentView addSubview:self.selecBtn];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.text];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.diamond];
    [self.contentView addSubview:self.proportion];
    [self.contentView addSubview:self.successPrice];
    [self.contentView addSubview:self.hops];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.selecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(5);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.selecBtn.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(100, 15));
    }];
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.selecBtn.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-72, 30));
    }];
    
    [self.diamond mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(13);
        make.right.equalTo(self.priceLabel.mas_left);
        make.size.mas_offset(CGSizeMake(16, 15));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-9);
        make.size.mas_offset(CGSizeMake(65, 20));
    }];
    
    [self.proportion mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.top.equalTo(self.text.mas_bottom).with.offset(5);
        make.left.equalTo(self.text);
        make.size.mas_offset(CGSizeMake(30, 20));
    }];
    
    [self.successPrice mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.top.equalTo(self.text.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.text);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.hops mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.top.equalTo(self.text.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.size.mas_offset(CGSizeMake(40, 20));
    }];
}

-(void)setTextBody:(NSString *)textBody {
    self.text.text = textBody;
}

-(void)setPrice:(NSString *)price {
    self.priceLabel.text = price;
}

-(void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

-(void)setType:(int)type {
    if (type == 1) {
        [self hiddenSubView:YES];
    } else {
        [self hiddenSubView:NO];
    }
}

-(void)hiddenSubView:(BOOL)style {
    self.proportion.hidden = style;
    self.successPrice.hidden = style;
    self.hops.hidden = style;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.selecBtn.selected = selected;
}

-(void)setSetingModel:(FollowSetingModel *)setingModel {
//    self.proportion.text = [FollowSetingModel proportion:setingModel.numScale];
//    self.successPrice.text = [FollowSetingModel successPrice:setingModel.successPrice];
//    self.hops.text = setingModel.successPrice == 0 ? [FollowSetingModel hops:setingModel.jumpPoint]: @"";
//    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIButton *)selecBtn {
    if (!_selecBtn) {
        _selecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selecBtn.userInteractionEnabled = NO;
        _selecBtn.selected = YES;
        [_selecBtn setImage:[UIImage imageNamed:@"Awesome_FollowAction_choose_Normal"] forState:UIControlStateNormal];
        [_selecBtn setImage:[UIImage imageNamed:@"Awesome_FollowAction_choose_Selected"] forState:UIControlStateSelected];
    }
    return _selecBtn;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = RGB(50, 51, 51);
    }
    return _titleLabel;
}

-(UILabel *)text {
    if (!_text) {
        _text = [[UILabel alloc] init];
        _text.textColor = RGB(84, 85, 86);
        _text.font = [UIFont systemFontOfSize:12];
        _text.numberOfLines = 0;
    }
    return _text;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = RGB(84, 85, 86);
    }
    return _priceLabel;
}
//钻石图标
-(UIImageView *)diamond {
    if (!_diamond) {
        _diamond = [[UIImageView alloc] init];
        _diamond.image = [UIImage imageNamed:@"Awesome_FollowChoose_diamond"];
    }
    return _diamond;
}

-(UILabel *)proportion {
    if (!_proportion) {
        _proportion = [[UILabel alloc] init];
        _proportion.font = [UIFont systemFontOfSize:12];
        _proportion.textColor = RGB(84, 85, 86);
        _proportion.text = @"1比1";
    }
    return _proportion;
}

-(UILabel *)successPrice {
    if (!_successPrice) {
        _successPrice = [[UILabel alloc] init];
        _successPrice.font = [UIFont systemFontOfSize:12];
        _successPrice.textColor = RGB(84, 85, 86);
        _successPrice.text = @"牛人成交价";
    }
    return _successPrice;
}

-(UILabel *)hops {
    if (!_hops) {
        _hops = [[UILabel alloc] init];
        _hops.font = [UIFont systemFontOfSize:12];
        _hops.textColor = RGB(84, 85, 86);
        _hops.text = @"1点";
    }
    return _hops;
}
@end
