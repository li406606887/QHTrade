//
//  GroupDetailsViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "GroupModel.h"

@interface GroupDetailsViewModel : BaseViewModel
@property(nonatomic,strong) GroupModel *model;
@property(nonatomic,assign) CGFloat textHeight;
@property(nonatomic,strong) RACCommand *groupPriseCommand;//请求圈子数据
@property(nonatomic,strong) RACSubject *refreshPriseStateSubject;//刷新点赞状态
@property(nonatomic,strong) RACSubject *gotoLoginSubject;//刷新点赞状态
@property (nonatomic,strong) RACSubject *backSubject;//回调信号
@end
