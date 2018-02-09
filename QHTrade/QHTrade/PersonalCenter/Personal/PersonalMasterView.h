//
//  PersonalMasterView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalTabeSectionView.h"
#import "PersonalTableFootView.h"
@interface PersonalMasterView : BaseView
//@property (nonatomic,strong) UIView *topView;
//@property (nonatomic,strong) UILabel *topViewLabel;
//@property (nonatomic,strong) UILabel *topViewLabel1;
//@property (nonatomic,strong) UIButton *topLogButton;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) PersonalTabeSectionView *tableSectionView;
@property (nonatomic,strong) PersonalTableFootView *tableFootView;
@property (nonatomic,assign) BOOL isLogin;//是否登录交易账户
@property(nonatomic,strong) PersonalViewModel * viewModel;
@property (nonatomic,strong) NSArray *dataArray;

@end
