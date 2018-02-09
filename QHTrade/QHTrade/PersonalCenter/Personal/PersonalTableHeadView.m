//
//  PersonalTableHeadView.m
//  QHTrade
//
//  Created by user on 2017/12/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalTableHeadView.h"
#import "PersonFollowSwitchView.h"

@implementation PersonalTableHeadView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 3.0;
    self.layer.shadowOpacity = 0.1;
    self.clipsToBounds = NO;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.icon];
    [self addSubview:self.awesomeName];
    [self addSubview:self.subscribeNum];
    [self addSubview:self.promptBtn];
    [self addSubview:self.followState];
    [self addSubview:self.proportion];
    [self addSubview:self.tradeType];
    [self addSubview:self.hops];
    [self addSubview:self.followInstructions];
    [self addSubview:self.followManger];
    [self addSubview:self.tradeSignal];
    [self addSubview:self.separatedLine];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    
    [self.awesomeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.height.offset(15);
    }];
    
    [self.subscribeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.promptBtn.mas_left).with.offset(-2);
        make.centerY.equalTo(self.awesomeName);
        make.size.mas_offset(CGSizeMake(100, 12));
    }];
    
    [self.promptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.centerY.equalTo(self.awesomeName);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    
    [self.followState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(66, 14));
    }];
    
    [self.proportion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.followState.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(30, 14));
    }];
    
    [self.tradeType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.proportion.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(75, 14));
    }];
    
    [self.hops mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tradeType.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(40, 14));
    }];
    
    [self.followInstructions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 100));
    }];
    
    [self.followManger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-30)/2-1, 40));
    }];
    
    [self.separatedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.followManger);
        make.size.mas_offset(CGSizeMake(1.5, 20));
    }];
    
    [self.tradeSignal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-30)/2-1, 40));
    }];
    [super updateConstraints];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshUI subscribeNext:^(UserModel * model) {
        @strongify(self)
       
        if ([UserInformation getInformation].getLoginState == NO) {
            [self.promptBtn setTitle:@"去登录" forState:UIControlStateNormal];
        }else if ([[UserInformation getInformation].userModel.state intValue] == 1) {
            [self.promptBtn setTitle:@"去绑定" forState:UIControlStateNormal];
        }else if ([[UserInformation getInformation].userModel.isFollows intValue] != 1) {
            [self.promptBtn setTitle:@"去跟单" forState:UIControlStateNormal];
        }else{
            [self.promptBtn setTitle:@"切换" forState:UIControlStateNormal];
        }
        
        if ([[UserInformation getInformation].userModel.isFollows intValue] != 1) {
            self.icon.image = [UIImage imageNamed:@"touxiang_icon"];
            self.awesomeName.text = @"—";
            self.subscribeNum.text = @"";
            self.proportion.text = @"-";
            self.tradeType.text = @"-";
            self.hops.text = @"-";
            return;
        }
        if (model ==nil) {
            return ;
        }
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.niuUserImg]];
        [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.awesomeName.text = model.niuUserName.length<1 ? @"": model.niuUserName;
        self.subscribeNum.text = [model.documentary intValue] == 1 ? @"正在自动跟单": @"正在手动跟单";
        self.proportion.text = model.numScale.length<1 ? @"": [NSString stringWithFormat:@"1:%@",model.numScale];
        self.tradeType.text = [model.priceType intValue] == 1 ? @"牛人成交价格":@"合约市价";
        self.hops.text = model.jumpPoint.length<1 ? @"": [NSString stringWithFormat:@"跳%@点",model.jumpPoint];
        self.hops.hidden = [model.priceType intValue] == 1 ? NO: YES;
        if ([[UserInformation getInformation].userModel.state intValue]==4) {
            self.subscribeNum.text = @"";
        }
    }];
    
    [self.viewModel.refreshPersonalFollowStateSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.subscribeNum.text = [[UserInformation getInformation].userModel.documentary intValue] == 1 ? @"正在自动跟单": @"正在手动跟单";
    }];
   
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _icon;
}

-(UILabel *)awesomeName {
    if (!_awesomeName) {
        _awesomeName = [[UILabel alloc] init];
        _awesomeName.textColor = RGB(66, 66, 66);
        _awesomeName.font = [UIFont systemFontOfSize:15];
    }
    return _awesomeName;
}

-(UIButton *)promptBtn {
    if (!_promptBtn) {
        _promptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([UserInformation getInformation].getLoginState == NO) {
            [self.promptBtn setTitle:@"去登录" forState:UIControlStateNormal];
        }else if ([[UserInformation getInformation].userModel.state intValue] == 1) {
            [self.promptBtn setTitle:@"去绑定" forState:UIControlStateNormal];
        }else if ([[UserInformation getInformation].userModel.isFollows intValue] != 1) {
            [self.promptBtn setTitle:@"去跟单" forState:UIControlStateNormal];
        }else {
            [self.promptBtn setTitle:@"切换" forState:UIControlStateNormal];
        }
        [_promptBtn setBackgroundColor:RGB(255, 98, 1)];
        [_promptBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _promptBtn.layer.masksToBounds = YES;
        _promptBtn.layer.cornerRadius = 7.5;
        @weakify(self)
        [[_promptBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([UserInformation getInformation].getLoginState == NO) {
                //@"去登陆"
                [self.viewModel.tradeAccountLoginBtnClick sendNext:@"1"];
            }else if ([[UserInformation getInformation].userModel.state intValue] == 1) {
                //@"去绑定"
                [self.viewModel.tradeAccountLoginBtnClick sendNext:@"2"];
            }else if ([[UserInformation getInformation].userModel.isFollows intValue] != 1) {//去跟单
                [self.viewModel.tradeAccountLoginBtnClick sendNext:@"3"];
            }else {
                if ([[UserInformation getInformation].userModel.state intValue] == 4) {
                    showMassage(@"请在每个交易日8:00,12:00,20:00后切换跟单状态。");
                }else{
                    PersonFollowSwitchView *person = [[PersonFollowSwitchView alloc] initWithViewModel:self.viewModel];
                    [[UIApplication sharedApplication].keyWindow addSubview:person];
                    [person mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo([UIApplication sharedApplication].keyWindow);
                    }];
                }
            }
        }];
    }
    return _promptBtn;
}

-(UILabel *)subscribeNum {
    if (!_subscribeNum) {
        _subscribeNum = [[UILabel alloc] init];
        _subscribeNum.textAlignment = NSTextAlignmentRight;
        _subscribeNum.textColor = RGB(255, 98, 1);
        _subscribeNum.font = [UIFont systemFontOfSize:13];
    }
    return _subscribeNum;
}

-(UILabel *)followState {
    if (!_followState) {
        _followState = [[UILabel alloc] init];
        _followState.text = @"跟单情况:";
        _followState.font = [UIFont systemFontOfSize:14];
        _followState.textColor = RGB(51, 51, 51);
    }
    return _followState;
}

-(UILabel *)proportion {
    if (!_proportion) {
        _proportion = [self creatLabelWithStyle];
        _proportion.text = @"——";
    }
    return _proportion;
}
-(UILabel *)tradeType {
    if (!_tradeType) {
        _tradeType = [self creatLabelWithStyle];
        _tradeType.text = @"——";
    }
    return _tradeType;
}
-(UILabel *)hops {
    if (!_hops) {
        _hops = [self creatLabelWithStyle];
        _hops.text = @"——";
    }
    return _hops;
}
-(UILabel *)followInstructions {
    if (!_followInstructions) {
        _followInstructions = [[UILabel alloc] init];
        _followInstructions.text = @"跟单说明:交易账户登录后将开始自动跟单，否则只接收信号，如需自动跟单，请确认登录并跟单，如需取消跟单，请在跟单管理中取消。\n\n\n";
        _followInstructions.font = [UIFont systemFontOfSize:14];
        _followInstructions.numberOfLines = 0;
        _followInstructions.lineBreakMode = NSLineBreakByWordWrapping;
        _followInstructions.textColor = RGB(51, 51, 51);
    }
    return _followInstructions;
}

-(UIButton *)followManger {
    if (!_followManger) {
        _followManger = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followManger setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_followManger setTitle:@" 跟单管理" forState:UIControlStateNormal];
        [_followManger.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_followManger setImage:[UIImage imageNamed:@"personal_gendanguanli"] forState:UIControlStateNormal];
        @weakify(self)
        [[_followManger rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.middleCellClick sendNext:@"1"];
        }];
    }
    return _followManger;
}

-(UIView *)separatedLine {
    if (!_separatedLine) {
        _separatedLine = [[UIView alloc] init];
        _separatedLine.backgroundColor = RGB(180, 180, 180);
    }
    return _separatedLine;
}

-(UIButton *)tradeSignal {
    if (!_tradeSignal) {
        _tradeSignal = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tradeSignal setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_tradeSignal setTitle:@" 牛人信号" forState:UIControlStateNormal];
        [_tradeSignal.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_tradeSignal setImage:[UIImage imageNamed:@"personal_niurenxinhao"] forState:UIControlStateNormal];
        @weakify(self)
        [[_tradeSignal rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.middleCellClick sendNext:@"2"];
        }];
    }
    return _tradeSignal;
}

-(UILabel *)creatLabelWithStyle {
    UILabel *title = [[UILabel alloc] init];
    title.layer.borderWidth = 0.5f;
    title.layer.borderColor = RGB(255, 98, 1).CGColor;
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 4;
    title.font = [UIFont systemFontOfSize:12];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = RGB(239, 92, 1);
    return title;
}

-(void)dealloc {
    NSLog(@"123");
}
@end
