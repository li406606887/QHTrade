//
//  DiamondMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "DiamondViewModel.h"
#import "DiamondHeadView.h"

@interface DiamondMainView : BaseView

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) DiamondViewModel *viewModel;

@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) DiamondHeadView *headView;
//@property (nonatomic,strong) UITextField *moneyTextfield;
@property (nonatomic,strong) UIButton * commitButton;

@property (nonatomic,assign) int selectedIndex;//选择索引
@property (nonatomic,strong) NSString *money;
@end
