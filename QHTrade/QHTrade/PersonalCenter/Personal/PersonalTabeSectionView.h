//
//  PersonalTabeSectionView
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "PersonalViewModel.h"
@interface PersonalTabeSectionView : BaseView
@property (nonatomic,strong) PersonalViewModel *viewModel;
@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UILabel *IdLabel;
@property (nonatomic,strong) UIImageView *sexImgView;
@property (nonatomic,strong) UIButton *diamondButton;
@property (nonatomic,strong) UIButton *setButton;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIImageView *diamondBgView;
@property (nonatomic,strong) UIButton *openAccountBtn;
@property (nonatomic,strong) UILabel *earningsRate;//收益率
@property (nonatomic,strong) UILabel *totalAssets;//总资产
@property (nonatomic,strong) UILabel *totalRevenue;//总收益
@property (nonatomic,strong) UILabel *positionRate;//仓位使用率
@property (nonatomic,strong) UILabel *positionNumber;//持仓手数
@property (nonatomic,strong) UILabel *myPosition;//我的持仓
@property (nonatomic,strong) UIButton *subscribeNum;//交易统计
@property (nonatomic,strong) UIImageView *partingLine;//
@property (nonatomic,strong) UIButton *followAction;//数据报表
@end
