//
//  AccountSetMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"

@interface AccountSetMainView : BaseView
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) UIImage *headImage;//头像
@property (nonatomic,strong) NSString *sexStr;
@property (nonatomic,strong) NSArray *dataArray;
@end
