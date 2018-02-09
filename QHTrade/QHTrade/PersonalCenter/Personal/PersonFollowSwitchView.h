//
//  PersonFollowSwitchView.h
//  QHTrade
//
//  Created by user on 2017/12/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalViewModel.h"

@class SwitchItemView;

@interface PersonFollowSwitchView : BaseView
@property(nonatomic,strong) PersonalViewModel *viewModel;
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) SwitchItemView *manualView;
@property(nonatomic,strong) SwitchItemView *automaticView;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *sureBtn;
@property(nonatomic,assign) int type;
@end


@interface SwitchItemView :UIView
@property(nonatomic,strong) UIButton *selected;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *subtitleTitle;
@end
