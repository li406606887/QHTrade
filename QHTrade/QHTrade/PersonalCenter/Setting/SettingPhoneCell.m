//
//  SettingPhoneCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SettingPhoneCell.h"

@implementation SettingPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

-(void)addPhoneNumStr:(NSString *)phoneNumStr{
    
    NSMutableString * str1 = [[NSMutableString alloc]initWithString:phoneNumStr];
    [str1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

    _phoneNumLabel.text = str1;
}


- (IBAction)changeBtnClick:(id)sender {
    
    if (self.changeBtn) {
        self.changeBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
