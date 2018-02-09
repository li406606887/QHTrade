//
//  GroupDetailsViewController.h
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ViewBaseController.h"
#import "GroupModel.h"
typedef void(^CallBackBlock) (GroupModel * model);

@interface GroupDetailsViewController : ViewBaseController
@property(nonatomic,strong) GroupModel *model;
@property (nonatomic,copy) CallBackBlock callBackBlock;
@end
