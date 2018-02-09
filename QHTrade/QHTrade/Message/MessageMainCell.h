//
//  MessageMainCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageModel.h"

@interface MessageMainCell : BaseTableViewCell
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *whiteBGView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) MessageModel *model;
@end
