//
//  SettingSwitchCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//蓝色#35a4fa   灰色#e1e2e2

#import "SettingSwitchCell.h"

@implementation SettingSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];

    
    WS(weakSelf)
    [self.rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    [self.rightSwitch setOn:YES];
    
    self.rightSwitch.onTintColor = RGB(255,98,1);
//     RGB(230,230,230);
    self.rightSwitch.tintColor = RGB(230,230,230);
    [self.rightSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    self.rightSwitch.transform = CGAffineTransformMakeScale(0.85, 0.85);
}

-(void)switchChange:(UISwitch *)sender{
    
    if ([sender isOn]) {
   
        if (self.switchBlock) {
            self.switchBlock([NSString stringWithFormat:@"%@",@"isOn"]);
        }
    }else{
        if (self.switchBlock) {
            self.switchBlock([NSString stringWithFormat:@"%@",@"isOff"]);
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
