//
//  PersonalTableHeadView.h
//  QHTrade
//
//  Created by user on 2017/12/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalViewModel.h"

@interface PersonalTableHeadView : BaseView
@property(nonatomic,strong) PersonalViewModel *viewModel;
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UILabel *awesomeName;//牛人名称
@property(nonatomic,strong) UILabel *subscribeNum;//订阅数量
@property(nonatomic,strong) UIButton *promptBtn;//风险提示
@property(nonatomic,strong) UILabel *followState;//跟单情况
@property(nonatomic,strong) UILabel *proportion;//比例
@property(nonatomic,strong) UILabel *tradeType;//交易类型
@property(nonatomic,strong) UILabel *hops;//跳点
@property(nonatomic,strong) UILabel *followInstructions;//跟单说明
@property(nonatomic,strong) UIButton *followManger;//跟单说明
@property(nonatomic,strong) UIView *separatedLine ;//跟单说明
@property(nonatomic,strong) UIButton *tradeSignal;//交易信号
@end
