//
//  LoginView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/9.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#define LINECOLOE [UIColor colorWithRed:177.0/255.0 green:134.0/255.0 blue:65.0/255.0 alpha:1.0f]
#define FORGETCOLOE [UIColor colorWithRed:196.0/255.0 green:159.0/255.0 blue:81.0/255.0 alpha:1.0f]
#define QUICKCOLOE [UIColor colorWithRed:80.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0f]
#import "LoginView.h"

@interface LoginView ()

@end

@implementation LoginView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (LoginViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupViews];

    }
    return self;
}
-(void)bindViewModel{
    
}
-(void)quickBtnClick:(id)sender{
    
    [self.viewModel.quickSubject sendNext:nil];
}
-(void)forgetBtnClick:(id)sender{
    
    [self.viewModel.forgetSubject sendNext:nil];
}

-(void)setupViews{

    [self addSubview:self.logoImageView];
    [self addSubview:self.phoneNumTextfield];
    [self addSubview:self.line];
    [self addSubview:self.passWordTextfield];
    [self addSubview:self.line1];
    [self addSubview:self.forgetButton];
    [self addSubview:self.phoneImgView];
    [self addSubview:self.passwordImgView];
    [self addSubview:self.loginButton];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakSelf)
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(35);
        make.size.mas_offset(CGSizeMake(75, 75));
    }];
    
    [self.phoneNumTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logoImageView.mas_bottom).with.offset(60);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(30);
    }];
    [self.phoneImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.phoneNumTextfield).with.offset(2);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.phoneNumTextfield.mas_bottom).with.offset(4);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.phoneNumTextfield.mas_bottom).with.offset(25);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(30);
    }];
    
    [self.passwordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passWordTextfield).with.offset(2);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWordTextfield.mas_bottom).with.offset(4);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.line1.mas_bottom).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
    
    
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.forgetButton.mas_bottom).with.offset(43);
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(40);
    }];

    [super updateConstraints];
}

-(UIImageView *)passwordImgView {
    if (!_passwordImgView) {
        _passwordImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_mima"]];
    }
    return _passwordImgView;
}
-(UIImageView *)phoneImgView {
    if (!_phoneImgView) {
        _phoneImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_shouji"]];
    }
    return _phoneImgView;
}

-(UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"btn_ablebg_image"] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"btn_unable_bg_image"] forState:UIControlStateDisabled];
    }
    return _loginButton;
}

-(UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码了?" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_forgetButton setBackgroundColor:[UIColor whiteColor]];
        [_forgetButton addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

-(UITextField *)passWordTextfield {
    if (!_passWordTextfield) {
        _passWordTextfield = [[UITextField alloc]init];
        _passWordTextfield.placeholder = @"请输入密码";
        _passWordTextfield.font = [UIFont systemFontOfSize:15.0f];
        _passWordTextfield.borderStyle = UITextBorderStyleNone;
        _passWordTextfield.secureTextEntry = YES;
    }
    return _passWordTextfield;
}

-(UITextField *)phoneNumTextfield {
    if (!_phoneNumTextfield) {
        _phoneNumTextfield = [[UITextField alloc]init];
        _phoneNumTextfield.placeholder = @"请输入手机号";
        _phoneNumTextfield.font = [UIFont systemFontOfSize:15.0f];
        _phoneNumTextfield.borderStyle = UITextBorderStyleNone;
        _phoneNumTextfield.backgroundColor =[UIColor whiteColor];
    }
    return _phoneNumTextfield;
}
-(UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = RGB(180,180,180);
    }
    return _line1;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = RGB(180,180,180);
    }
    return _line;
}

-(UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"login_biglogo"];//
    }
    return _logoImageView;
}

@end

