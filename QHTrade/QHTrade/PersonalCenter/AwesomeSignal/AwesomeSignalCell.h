//
//  AwesomeSignalCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AwesomeSignalModel.h"

@interface AwesomeSignalCell : BaseTableViewCell
@property (nonatomic,strong) UIView *bgView;//beijing
@property (nonatomic,strong) UILabel *promptLabel;//提示
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thirdLabel;
@property (nonatomic,strong) UILabel *fourthLabel;
@property (nonatomic,strong) UILabel *fivethLabel;
@property (nonatomic,strong) UILabel *sixthLabel;
@property (nonatomic,strong) UILabel *seventhLabel;
@property (nonatomic,strong) UILabel *eighthLabel;
@property (nonatomic,strong) UILabel *awesomeNameLabel;//牛人名字
@property (nonatomic,strong) UILabel *contractLabel;//合约名称
@property (nonatomic,strong) UILabel *orderSideLabel;//下单方向
@property (nonatomic,strong) UILabel *orderPriceLabel;//下单价格
@property (nonatomic,strong) UILabel *orderLotLabel;//下单手数
@property (nonatomic,strong) UILabel *timeLabel;//下单时间
@property (nonatomic,strong) UILabel *tradeStateLabel;//交易状态
@property (nonatomic,strong) AwesomeSignalModel *model;
@end
