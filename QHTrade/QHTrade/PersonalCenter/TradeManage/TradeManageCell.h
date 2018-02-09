//
//  TradeManageCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TradeManageModel.h"
@interface TradeManageCell : BaseTableViewCell
@property (nonatomic,strong) UIImageView * headImgView;
@property (nonatomic,strong) UILabel *nickNameLabel;
@property (nonatomic,strong) UIButton *cancleButton;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) UILabel *followTitle;
@property (nonatomic,strong) UILabel *proportion;//
@property (nonatomic,strong) UILabel *tradeType;//交易类型
@property (nonatomic,strong) UILabel *hops;//跳点

@property (nonatomic,strong) TradeManageModel *model;
@property (nonatomic,copy) void (^cancleBlock)(TradeManageModel *model);
@property (nonatomic,strong) UIButton *evaluatButton;//
@property (nonatomic,copy) void (^evaluatBlock)(TradeManageModel *model);//评价
@end

