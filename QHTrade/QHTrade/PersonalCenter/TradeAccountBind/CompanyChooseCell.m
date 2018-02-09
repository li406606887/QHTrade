//
//  CompanyChooseCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "CompanyChooseCell.h"

@implementation CompanyChooseCell

-(void)setupViews {
    [self.contentView addSubview:self.companyLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [super updateConstraints];
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(36);
        make.size.mas_offset(CGSizeMake(280, 25));
    }];
}
-(void)setModel:(ChooseCompanyModel *)model {
    if (!model) {
        return;
    }
    self.code = _model.code;
    self.companyLabel.text = _model.name;
    self.letter = _model.letter;
    self.sort = _model.sort;
}
-(UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc]init];
        _companyLabel.textColor = [UIColor blackColor];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
        _companyLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _companyLabel;
}
@end
