//
//  SettingHeadImgCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SettingHeadImgCell.h"

@implementation SettingHeadImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImgView.layer.cornerRadius = 17.5;
    _headImgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
