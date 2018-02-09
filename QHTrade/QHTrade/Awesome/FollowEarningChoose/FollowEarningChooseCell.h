//
//  FollowEarningChooseCell.h
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "FollowSetingModel.h"

@interface FollowEarningChooseCell : BaseTableViewCell
@property(nonatomic,copy) NSString *textBody;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) FollowSetingModel *setingModel;
@property(nonatomic,assign) int type;
@end
