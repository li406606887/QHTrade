//
//  GroupViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface GroupViewModel : BaseViewModel
@property(nonatomic,strong) RACSubject *groupCellClickSubject;//圈子cell点击
@property(nonatomic,strong) RACSubject *refreshUISubject;//圈子cell点击
@property(nonatomic,strong) RACCommand *requestGroupDataCommand;//请求圈子数据
@property(nonatomic,strong) RACCommand *groupPriseCommand;//请求圈子数据
@property(nonatomic,strong) RACSubject *refreshPriseStateSubject;//刷新点赞状态
@property(nonatomic,strong) NSMutableArray *dataArray;//数据数组
@property(nonatomic,strong) NSMutableArray *cellHeightArray;//cell高度数组
@property(nonatomic,assign) int pageNum;
@property(nonatomic,strong) RACSubject *gotoLoginSubject;//圈子点赞
@end
