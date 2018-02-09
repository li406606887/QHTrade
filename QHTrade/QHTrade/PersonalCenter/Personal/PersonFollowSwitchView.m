//
//  PersonFollowSwitchView.m
//  QHTrade
//
//  Created by user on 2017/12/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonFollowSwitchView.h"

@implementation PersonFollowSwitchView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    self.mainView.userInteractionEnabled = YES;
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [self addSubview:self.mainView];
    [self.mainView addSubview:self.title];
    [self.mainView addSubview:self.prompt];
    [self.mainView addSubview:self.manualView];
    [self.mainView addSubview:self.automaticView];
    [self.mainView addSubview:self.cancelBtn];
    [self.mainView addSubview:self.sureBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(325, 250));
    }];
    
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainView);
        make.top.equalTo(self.mainView).with.offset(15);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.mainView);
        make.size.mas_offset(CGSizeMake(300, 55));
    }];
    
    [self.manualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainView);
        make.top.equalTo(self.prompt.mas_bottom).with.offset(5);
        make.size.mas_offset(CGSizeMake(300, 50));
    }];
    
    [self.automaticView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mainView);
        make.top.equalTo(self.manualView.mas_bottom);
        make.size.mas_offset(CGSizeMake(300, 50));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainView);
        make.bottom.equalTo(self.mainView.mas_bottom);
        make.height.offset(35);
        make.width.mas_equalTo(self.mainView.mas_width).multipliedBy(0.5);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mainView.mas_right);
        make.bottom.equalTo(self.mainView.mas_bottom);
        make.height.offset(35);
        make.width.mas_equalTo(self.mainView.mas_width).multipliedBy(0.5);
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 4;
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"跟单选择";
        _title.font = [UIFont systemFontOfSize:18];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

-(UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.text = [self getStateString:[[UserInformation getInformation].userModel.documentary intValue]];
        _prompt.font = [UIFont systemFontOfSize:15];
        _prompt.textColor = RGB(68, 68, 68);
        _prompt.numberOfLines = 0;
        _prompt.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _prompt;
}

-(SwitchItemView *)manualView {
    if (!_manualView) {
        _manualView = [[SwitchItemView alloc] init];
        _manualView.title.text = @"手动跟单";
        _manualView.selected.selected = [[UserInformation getInformation].userModel.documentary intValue] == 2 ? YES: NO;
        _manualView.subtitleTitle.text = @"只接收牛人成交信号，不跟单\n";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            self.type = 2;
            _manualView.selected.selected = YES;
            self.automaticView.selected.selected = NO;
            [self.sureBtn setTitle:@"确认手动跟单" forState:UIControlStateNormal];

        }];
        [_manualView addGestureRecognizer:tap];
    }
    return _manualView;
}

-(SwitchItemView *)automaticView {
    if (!_automaticView) {
        _automaticView = [[SwitchItemView alloc] init];
        _automaticView.selected.selected = [[UserInformation getInformation].userModel.documentary intValue] == 1 ? YES: NO;
        _automaticView.title.text = @"自动跟单";
        _automaticView.subtitleTitle.text = @"接收牛人成交信号并授权本应用进行自动跟单";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            self.manualView.selected.selected = NO;
            _automaticView.selected.selected = YES;
            self.type = 1;
            [self.sureBtn setTitle:@"确认登录并跟单" forState:UIControlStateNormal];
        }];
        [_automaticView addGestureRecognizer:tap];
    }
    return _automaticView;
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_cancelBtn setTitle:@"不切换" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:RGB(229, 229, 229)];
        [_cancelBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self)
            [self removeFromSuperview];
        }];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:RGB(255, 98, 1)];
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.type<1) {
                showMassage(@"请选择跟单方式");
                return ;
            }
            if ([[UserInformation getInformation].userModel.documentary intValue]==self.type) {
                showMassage(@"你选择的跟单方式与目前跟单方式相同");
                return;
            }
            switch (self.type) {
                case 1:
                       [self.viewModel.automaticChooseCommand execute:nil];
                    break;
                    
                case 2:
                    [self.viewModel.manualChooseCommand execute:nil];
                    break;
                default:
                    break;
            }
            [self removeFromSuperview];
        }];
    }
    return _sureBtn;
}

-(NSString *)getStateString:(int)state{
    NSString *title ;
    if (state == 2) {
        title = @"您当前为:手动跟单,只接收牛人信号。是否需要切换状态?\n";
    }else {
        title = @"您当前为：自动跟单，您已授权本应用接收牛人信号并为您自动跟单。是否需要切换状态？";
    }
    return title;
}

-(int)type {
    if (!_type) {
        _type = [[UserInformation getInformation].userModel.documentary intValue];
    }
    return _type;
}
@end


@implementation SwitchItemView
-(instancetype)init {
    self = [super init];
    if (self) {
        [self addChildView];
    }
    return self;
}

-(void)addChildView {
    [self addSubview:self.selected];
    [self addSubview:self.title];
    [self addSubview:self.subtitleTitle];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.selected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).with.offset(5);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];

    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selected.mas_right).with.offset(5);
        make.top.equalTo(self).with.offset(3);
        make.size.mas_offset(CGSizeMake(250, 18));
    }];
    
    [self.subtitleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selected.mas_right).with.offset(5);
        make.top.equalTo(self.title.mas_bottom);
        make.size.mas_offset(CGSizeMake(250, 34));
    }];
    [super updateConstraints];
}

-(UIButton *)selected {
    if (!_selected) {
        _selected = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selected setImage:[UIImage imageNamed:@"Awesome_FollowAction_choose_Normal"] forState:UIControlStateNormal];
        [_selected setImage:[UIImage imageNamed:@"Awesome_FollowAction_choose_Selected"] forState:UIControlStateSelected];
    }
    return _selected;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = RGB(51, 51, 51);
    }
    return _title;
}

-(UILabel *)subtitleTitle {
    if (!_subtitleTitle) {
        _subtitleTitle = [[UILabel alloc] init];
        _subtitleTitle.font = [UIFont systemFontOfSize:14];
        _subtitleTitle.textColor = RGB(102, 102, 102);
        _subtitleTitle.numberOfLines = 0;
    }
    return _subtitleTitle;
}
@end
