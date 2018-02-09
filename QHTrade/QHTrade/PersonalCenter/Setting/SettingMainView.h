//
//  SettingMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"

@interface SettingMainView : BaseView
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL isHaveAccount;//是否绑定交易账户
@property (nonatomic,strong) NSArray *dataArray;
@end
