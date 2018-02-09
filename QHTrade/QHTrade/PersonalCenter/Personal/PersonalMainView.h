//
//  PersonalMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalHeadView.h"
@interface PersonalMainView : BaseView
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)PersonalHeadView * headView;
@end
