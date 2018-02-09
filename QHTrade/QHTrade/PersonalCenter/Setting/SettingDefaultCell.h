//
//  SettingDefaultCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kSettingDefaultCell  = @"SettingDefaultCell";
@interface SettingDefaultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrImg;

@end
