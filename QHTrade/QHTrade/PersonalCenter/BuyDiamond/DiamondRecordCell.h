//
//  DiamondRecordCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiamondRecordModel.h"
static NSString * const kDiamondRecordCell = @"DiamondRecordCell";
@interface DiamondRecordCell : UITableViewCell


@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *diamondLabel;

@property (nonatomic,strong) DiamondRecordModel *model;

@end
