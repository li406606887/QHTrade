//
//  PersonalTabeSectionView
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalTabeSectionView.h"

#define kItemWidth (SCREEN_WIDTH-70)/3

@implementation PersonalTabeSectionView
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
    [self addSubview:self.headImgView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.sexImgView];
    [self addSubview:self.setButton];
    [self addSubview:self.openAccountBtn];
    
    [self addSubview:self.earningsRate];
    [self addSubview:self.totalAssets];
    [self addSubview:self.totalRevenue];
    [self addSubview:self.positionRate];
    [self addSubview:self.positionNumber];
    [self addSubview:self.myPosition];
    
    [self addSubview:self.subscribeNum];
    [self addSubview:self.partingLine];
    [self addSubview:self.followAction];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.left.equalTo(self.headImgView.mas_right).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(95, 18));
    }];
    
    [self.sexImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nickNameLabel);
        make.left.equalTo(self.nickNameLabel.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    
    [self.openAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImgView);
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    [self.earningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalAssets.mas_left).with.offset(-10);
        make.top.equalTo(self.headImgView.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.totalAssets mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.headImgView.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.totalRevenue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalAssets.mas_right).with.offset(10);
        make.top.equalTo(self.headImgView.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.positionRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.positionNumber.mas_left).with.offset(-10);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.positionNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.myPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.positionNumber.mas_right).with.offset(10);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(kItemWidth, 50));
    }];
    
    [self.subscribeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.offset(40);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    
    [self.partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subscribeNum);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(1.5, 20));
    }];
    
    [self.followAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.offset(40);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [super updateConstraints];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshUI subscribeNext:^(UserModel * model) {
        if (model == nil) {
            return ;
        }
        @strongify(self)
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]];
        [self.headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.nickNameLabel.text = model.userName.length<1 ? @"0":model.userName;
        self.sexImgView.image = [model.gender intValue] == 1 ? [UIImage imageNamed:@"personal_man_icon"]: [UIImage imageNamed:@"personal_woman_icon"];
        self.openAccountBtn.hidden = [model.isAccount intValue] == 1 ? YES: NO;
        self.earningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"收益率\n%@%%",model.incomeRate]
                                                                                  littlefont:12
                                                                                     bigFont:14
                                                                             defultTextColor:RGB(51, 51, 51)
                                                                                specialColor:[UIColor blackColor]
                                                                                       range:NSMakeRange(0, 3)];
        self.totalAssets.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总资产\n%@",model.balance]
                                                                                  littlefont:12
                                                                                     bigFont:14
                                                                             defultTextColor:RGB(51, 51, 51)
                                                                                specialColor:[UIColor blackColor]
                                                                                       range:NSMakeRange(0, 3)];
        self.totalRevenue.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总收益\n%@",model.totalIncome]
                                                                                  littlefont:12
                                                                                     bigFont:14
                                                                             defultTextColor:RGB(51, 51, 51)
                                                                                specialColor:[UIColor blackColor]
                                                                                       range:NSMakeRange(0, 3)];
        self.positionRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"仓位使用率\n%@%%",model.positionRate]
                                                                                  littlefont:12
                                                                                     bigFont:14
                                                                             defultTextColor:RGB(51, 51, 51)
                                                                                specialColor:[UIColor blackColor]
                                                                                       range:NSMakeRange(0, 5)];
        self.positionNumber.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"持仓手数\n%@",model.positionCount]
                                                                                  littlefont:12
                                                                                     bigFont:14
                                                                             defultTextColor:RGB(51, 51, 51)
                                                                                specialColor:[UIColor blackColor]
                                                                                       range:NSMakeRange(0, 4)];
    }];
}
#pragma mark - 我要开户
-(UIButton *)openAccountBtn {
    if (!_openAccountBtn) {
        _openAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openAccountBtn setBackgroundColor:RGB(255,98,1)];
        _openAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_openAccountBtn setTitle:@"我要开户" forState:UIControlStateNormal];
        @weakify(self)
        [[_openAccountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.openAccountCommand execute:nil];
        }];
        _openAccountBtn.layer.cornerRadius = 12.5;
        _openAccountBtn.layer.masksToBounds = YES;
    }
    return _openAccountBtn;
}
//钻石背景
-(UIImageView *)diamondBgView {
    if (!_diamondBgView) {
        _diamondBgView = [[UIImageView alloc]init];
        _diamondBgView.image = [UIImage imageNamed:@"dia_BGView"];
    }
    return _diamondBgView;
    
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

-(UILabel *)IdLabel {
    if (!_IdLabel) {
        _IdLabel = [[UILabel alloc]init];
        _IdLabel.font = [UIFont systemFontOfSize:12.0f];
        _IdLabel.textColor = RGB(68, 68, 68);
        _IdLabel.text = @"我的钻石";
    }
    return _IdLabel;
}

-(UIButton *)setButton {
    if (!_setButton) {
        _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setButton setBackgroundImage:[UIImage imageNamed:@"personal_shezhi"] forState:UIControlStateNormal];
        [[_setButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.setBtnClick sendNext:nil];
        }];
    }
    return _setButton;
}

-(UIButton *)diamondButton {
    if (!_diamondButton) {
        _diamondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_diamondButton setImage:[UIImage imageNamed:@"personal_zuanshi"] forState:UIControlStateNormal];
        [_diamondButton setTitle:@"未登录" forState:UIControlStateNormal];
        _diamondButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_diamondButton setTitleColor:RGB(68, 68, 68) forState:UIControlStateNormal];
        _diamondButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [[_diamondButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.diamondBtnClick sendNext:nil];
        }];
    }
    return _diamondButton;
}

-(UIImageView *)sexImgView {
    if (!_sexImgView) {
        _sexImgView = [[UIImageView alloc]init];
        _sexImgView.image = [UIImage imageNamed:@"personal_man_icon"];
    }
    return _sexImgView;
}

-(UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.font = [UIFont systemFontOfSize:16.0f];
        _nickNameLabel.textColor = RGB(100, 100, 100);
        _nickNameLabel.text = @"未登录";
    }
    return _nickNameLabel;
}

-(UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.image = [UIImage imageNamed:@"touxiang_icon"];
        _headImgView.layer.cornerRadius = 15;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            [self.viewModel.headImgClick sendNext:nil];
        }];
        [_headImgView addGestureRecognizer:tap];
    };
    return _headImgView;
}

-(UILabel *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [self creatBackImageLabel:1];
        _earningsRate.text = @"收益率";
    }
    return _earningsRate ;
}

-(UILabel *)totalAssets {
    if (!_totalAssets) {
        _totalAssets = [self creatBackImageLabel:2];
        _totalAssets.text = @"总资产";
    }
    return _totalAssets ;
}

-(UILabel *)totalRevenue {
    if (!_totalRevenue) {
        _totalRevenue = [self creatBackImageLabel:3];
        _totalRevenue.text = @"总收益";
    }
    return _totalRevenue;
}

-(UILabel *)positionRate {
    if (!_positionRate) {
        _positionRate = [self creatBackImageLabel:4];
        _positionRate.text = @"仓位使用率";
    }
    return _positionRate;
}

-(UILabel *)positionNumber {
    if (!_positionNumber) {
        _positionNumber = [self creatBackImageLabel:5];
        _positionNumber.text = @"持仓手数";
    }
    return _positionNumber;
}

-(UILabel *)myPosition {
    if (!_myPosition) {
        _myPosition = [[UILabel alloc] init];
        _myPosition.text = @"我的持仓";
        _myPosition.font = [UIFont systemFontOfSize:16];
        _myPosition.textColor = [UIColor whiteColor];
        _myPosition.backgroundColor = RGB(251, 183, 141);
        _myPosition.textAlignment = NSTextAlignmentCenter;
        _myPosition.userInteractionEnabled = YES;
        _myPosition.layer.borderWidth = 0.5f;
        _myPosition.layer.borderColor = RGB(255, 98, 1).CGColor;
        _myPosition.layer.masksToBounds = YES;
        _myPosition.layer.cornerRadius = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            [self.viewModel.positionsClick sendNext:nil];
        }];
        [_myPosition addGestureRecognizer:tap];
    }
    return _myPosition;
}

-(UIButton *)subscribeNum {
    if (!_subscribeNum) {
        _subscribeNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subscribeNum setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_subscribeNum setTitle:@" 交易统计" forState:UIControlStateNormal];
        [_subscribeNum.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_subscribeNum setImage:[UIImage imageNamed:@"personal_shujutongji"] forState:UIControlStateNormal];
        @weakify(self)
        [[_subscribeNum rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.middleCellClick sendNext:@"3"];
        }];
    }
    return _subscribeNum;
}

-(UIImageView *)partingLine {
    if (!_partingLine) {
        _partingLine = [[UIImageView alloc] init];
        [_partingLine setBackgroundColor:RGB(180, 180, 180)];
    }
    return _partingLine;
}

-(UIButton *)followAction {
    if (!_followAction) {
        _followAction = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followAction setTitle:@" 数据报表" forState:UIControlStateNormal];
        [_followAction setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        [_followAction setImage:[UIImage imageNamed:@"personal_shujubaobiao"] forState:UIControlStateNormal];
        [_followAction.titleLabel setFont:[UIFont systemFontOfSize:14]];
        @weakify(self)
        [[_followAction rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.middleCellClick sendNext:@"4"];
        }];
    }
    return _followAction;
}

-(UILabel *)creatBackImageLabel:(int)tag{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.tag = tag;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setImage:[UIImage imageNamed:@"personal_dikuang"]];
    [label addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label);
    }];
//    label.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//        NSLog(@"123");
//    }];
//    [label addGestureRecognizer:tap];
    return label;
}

@end
