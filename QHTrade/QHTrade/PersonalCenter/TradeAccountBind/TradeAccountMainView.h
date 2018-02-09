//
//  TradeAccountMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "TradeAccountViewModel.h"

@interface TradeAccountMainView : BaseView

@property (nonatomic,strong) UIImageView *searchImgView;//搜索
@property (nonatomic,strong) UILabel *companyLabel;
@property (nonatomic,strong) UITextField *accountTextfield;
@property (nonatomic,strong) UITextField *passWordTextfield;
@property (nonatomic,strong) UIImageView *companyImgView;
@property (nonatomic,strong) UIImageView *accountImgView;
@property (nonatomic,strong) UIImageView *passwordImgView;

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel * statementLabel;
@property (nonatomic,strong) UIButton *tickButton;//勾选
@property (nonatomic,strong) UILabel *bottomLabel;

@property (nonatomic,strong) TradeAccountViewModel *viewModel;

@end
