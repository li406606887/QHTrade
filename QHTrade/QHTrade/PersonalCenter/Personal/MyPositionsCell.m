//
//  MyPositionsCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/24.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyPositionsCell.h"

@implementation MyPositionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = RGB(255,98,1).CGColor;
    self.bgView.layer.borderWidth = 1.0f;
}

@end
