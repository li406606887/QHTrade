//
//  SettingSwitchCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SwitchBlock) (NSString * str);

static NSString * const kSettingSwitchCell  = @"SettingSwitchCell";
@interface SettingSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;


@property (nonatomic,copy) SwitchBlock  switchBlock;

@end
