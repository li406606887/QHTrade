//
//  AwesomeTableViewCell.h
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AwesomeModel.h"
#import "AwesomeViewModel.h"


@interface AwesomeTableViewCell : BaseTableViewCell
@property(nonatomic,strong) AwesomeModel *model;
@property(nonatomic,copy) void (^FollowAwesomeBlock)(AwesomeModel *model);
@end
