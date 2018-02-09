//
//  MyWarehouseCell.h
//  QHTrade
//
//  Created by user on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "WarehouseModel.h"//我的持仓model

@interface MyWarehouseCell : BaseTableViewCell
@property (nonatomic,strong) WarehouseModel * myModel;
@property(nonatomic,assign) BOOL hidden;
@end
