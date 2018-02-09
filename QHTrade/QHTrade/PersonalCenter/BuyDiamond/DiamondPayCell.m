//
//  DiamondPayCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondPayCell.h"

@interface DiamondPayCell ()
@property (nonatomic,strong) UIButton * selectBtn;
@end

@implementation DiamondPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
-(UIButton *)selectBtn{

    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"diamond_xuanzhong"] forState:UIControlStateSelected];
        [_selectBtn setImage:[UIImage imageNamed:@"diamond_weixuanzhong"] forState:UIControlStateNormal];
        _selectBtn.userInteractionEnabled = NO;
        _selectBtn.selected = YES;
    }
    return _selectBtn;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    self.selectBtn.selected = selected;
}

@end
