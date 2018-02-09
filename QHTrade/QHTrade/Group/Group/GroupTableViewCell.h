//
//  GroupTableViewCell.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupModel.h"
#import "GroupViewModel.h"

@interface GroupTableViewCell : BaseTableViewCell
@property(nonatomic,strong) GroupModel *model;
@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,strong) void(^praiseBlock)(int tag,NSMutableDictionary* param);
@end
