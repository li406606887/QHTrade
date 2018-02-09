//
//  TradestatisticsCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradeStatisticsModel.h"
static NSString * const  kTradestatisticsCell = @"TradestatisticsCell";
@interface TradestatisticsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (nonatomic,strong) TradeStatisticsModel *model;
@end
