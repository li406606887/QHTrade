//
//  PersonalHeadView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/2.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "PersonalViewModel.h"
@interface PersonalHeadView : BaseView

@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *nickNameLabel;//头像
@property (nonatomic,strong) UIImageView *sexImgView;//性别
@property (nonatomic,strong) UILabel *yearLabel;//年龄
@property (nonatomic,strong) UILabel *IDLabel;
@property (nonatomic,strong) UILabel *companyLabel;//公司信息
@property (nonatomic,strong) UIImageView *locationImgView;//定位小图片
@property (nonatomic,strong) UILabel *addressLabel;//常住地信息
@property (nonatomic,strong) UILabel *focusLabel;//关注数
@property (nonatomic,strong) UILabel *fansLabel;//粉丝数
@property (nonatomic,strong) UIImageView *diamondImgView;
@property (nonatomic,strong) UILabel *diamondLabel;//钻石数
@property (nonatomic,strong) UIImageView *questionImgView;//问号图片
@property (nonatomic,strong) UILabel *todayVisitorLabel;//今日访客
@property (nonatomic,strong) UILabel *totalVisitorsLabel;//总的访客量

@property (nonatomic,strong) PersonalViewModel *viewModel;

@end

