//
//  PersonalButtonCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalButtonCell.h"

@implementation PersonalButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)manageBtnClick:(id)sender {
    if (self.manageBlock) {
        self.manageBlock();
    }
}
- (IBAction)signalBtnClick:(id)sender {
    if (self.signalBlock) {
        self.signalBlock();
    }
}
- (IBAction)statisticBtnClick:(id)sender {
    
    if (self.statisticBlock) {
        self.statisticBlock();
    }
}
- (IBAction)reportBtnClick:(id)sender {
    if (self.reportBlock) {
        self.reportBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
