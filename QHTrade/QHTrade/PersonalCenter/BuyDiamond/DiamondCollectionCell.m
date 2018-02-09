//
//  DiamondCollectionCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondCollectionCell.h"


@interface DiamondCollectionCell ()
@property (nonatomic,strong) UIButton * selectBtn;

@property (nonatomic,strong) UILabel * moneyLabel;
@end

@implementation DiamondCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.moneyLabel];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(70);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).with.offset(5);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
}
-(void)setMoneyStr:(NSString *)moneyStr{

    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",moneyStr];
//    self.selectBtn.titleLabel.text = [NSString stringWithFormat:@"购买%@",moneyStr];
    [self.selectBtn setTitle:[NSString stringWithFormat:@"购买%@",moneyStr] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.selectBtn.selected = selected;
    
   
   
}
-(UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.moneyStr];
        _moneyLabel.font = [UIFont systemFontOfSize:15.0f];
        _moneyLabel.textColor = RGB(0, 0, 0);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;

}
-(UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_selectBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectBtn setBackgroundColor:RGB(255, 98, 1) forState:UIControlStateSelected];
        
        [_selectBtn setTitle:[NSString stringWithFormat:@"购买%@",self.moneyStr] forState:UIControlStateNormal];
        
        [_selectBtn setImage:[UIImage imageNamed:@"diamond_zuanshi_bai"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"diamond_zuanshi_cheng"] forState:UIControlStateNormal];
        
        [_selectBtn setTitleColor:RGB(255,98,1) forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [_selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 18)];
        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 78, 0, -78)];
        
        [_selectBtn.layer setMasksToBounds:YES];
        [_selectBtn.layer setBorderWidth:1.0];
        _selectBtn.layer.borderColor = RGB(207, 205, 205).CGColor;
        
        
        _selectBtn.userInteractionEnabled = NO;
        _selectBtn.selected = NO;
    }
    return _selectBtn;
}

@end
