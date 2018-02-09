//
//  SettingHeadImgCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kSettingHeadImgCell  = @"SettingHeadImgCell";
@interface SettingHeadImgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@end
