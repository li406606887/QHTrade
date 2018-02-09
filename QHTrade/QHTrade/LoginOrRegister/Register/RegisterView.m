//
//  RegisterView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/21.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//
#define QUICKCOLOE [UIColor colorWithRed:80.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1.0f]
#define LINECOLOE [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1.0f]
#import "RegisterView.h"


@implementation RegisterView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (RegisterViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        
    }
    return self;
}

-(void)quickBtnClick:(id)sender{

    [self.viewModel.quickSubject sendNext:nil];
}
-(void)codeLblClick{
    
    [self.viewModel.getCodeSubject sendNext:nil];

}
-(void)bindViewModel{
    
}
-(void)setupViews{
    
    [self addSubview:self.topImgView];
    [self addSubview:self.phoneNumTextfield];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.codeLabel];
    [self addSubview:self.passWordTextfield];
    [self addSubview:self.line2];
    [self addSubview:self.line];
    [self addSubview:self.line1];
    [self addSubview:self.registerButton];
    [self addSubview:self.phoneImgView];
    [self addSubview:self.codeImgView];
    [self addSubview:self.passwordImgView];
    [self addSubview:self.shengmingLabel];
    [self addSubview:self.tickButton];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakSelf)
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(35);
        make.size.mas_offset(CGSizeMake(75, 75));
    }];
    
    [self.phoneNumTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.topImgView.mas_bottom).with.offset(40);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_offset(30);
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
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.centerY.equalTo(weakSelf.forgetButton);
        make.top.equalTo(weakSelf.phoneNumTextfield.mas_bottom).with.offset(25);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.phoneNumTextfield.mas_bottom).with.offset(25);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf.codeLabel.mas_left).with.offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    [self.codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.codeTextfield).with.offset(2);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeTextfield.mas_bottom).with.offset(4);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeTextfield.mas_bottom).with.offset(25);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(30);
    }];
    
    [self.passwordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.passWordTextfield).with.offset(2);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWordTextfield.mas_bottom).with.offset(4);
        make.left.equalTo(weakSelf).with.offset(58);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.shengmingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line2.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(40);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(20);
    }];
    
    [self.tickButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.shengmingLabel);
        make.left.equalTo(weakSelf).with.offset(16);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.shengmingLabel.mas_bottom).with.offset(45);
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_equalTo(40);
    }];
    
    [super updateConstraints];
}

-(void)tickBtnClick:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        NSLog(@"选中");
        [self.viewModel.tickClickSubject sendNext:@"1"];
    }else{
        
        NSLog(@"未选中");
        [self.viewModel.tickClickSubject sendNext:@"0"];
    }
}
-(UIButton *)tickButton{

    if (!_tickButton) {
        _tickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tickButton.selected = NO;
        [_tickButton setImage:[UIImage imageNamed:@"register_tickBtn"] forState:UIControlStateNormal];
        [_tickButton setImage:[UIImage imageNamed:@"register_tickBtn_xuan"] forState:UIControlStateSelected];
        [_tickButton addTarget:self action:@selector(tickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _tickButton.selected = YES;
    }
    return _tickButton;
}
-(void)shengmingClick:(id)sender {
    [self.viewModel.quickSubject sendNext:nil];
}


-(UILabel *)shengmingLabel{

    if (!_shengmingLabel) {
        _shengmingLabel = [[UILabel alloc]init];
        _shengmingLabel.textAlignment = NSTextAlignmentLeft;
        _shengmingLabel.textColor = RGB(68,68,68);
        _shengmingLabel.font = [UIFont systemFontOfSize:12.0f];
        
        NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:@"注册本应用代表您同意《用户协议及免责声明》"];
        NSRange range2;
        range2 = NSMakeRange(10, 11);
        [string addAttribute:NSForegroundColorAttributeName value:RGB(255, 98, 1) range:range2];
        [_shengmingLabel setAttributedText:string];
        _shengmingLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shengmingClick:)];
        [_shengmingLabel addGestureRecognizer:tap];
        
    }
    return _shengmingLabel;
}

-(UIView *)line2{

    if (!_line2) {
        _line2 =[[UIView alloc]init];
        _line2.backgroundColor = LINECOLOE;
    }
    return _line2;
}
-(UIView *)line1{
    
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = LINECOLOE;
    }
    return _line1;
}

-(UIView *)line{
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = LINECOLOE;
    }
    return _line;
}
-(UIButton *)registerButton{
    
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"提交" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"btn_ablebg_image"] forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"btn_unable_bg_image"] forState:UIControlStateDisabled];
    }
    return _registerButton;
}

//-(UIImageView *)smallLogoImgView{
//    
//    if (!_smallLogoImgView) {
//        _smallLogoImgView = [[UIImageView alloc]init];
//        _smallLogoImgView.image = [UIImage imageNamed:@"login_minilogo"];
//    }
//    return _smallLogoImgView;
//}
//
//-(UIButton *)quickLoginButton{
//    
//    if (!_quickLoginButton) {
//        _quickLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_quickLoginButton setTitle:@"使用奇获账号登录" forState:UIControlStateNormal];
//        [_quickLoginButton setTitleColor:QUICKCOLOE forState:UIControlStateNormal];
//        _quickLoginButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        [_quickLoginButton setBackgroundColor:[UIColor whiteColor]];
//        [_quickLoginButton addTarget:self action:@selector(quickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _quickLoginButton;
//}

-(UILabel *)codeLabel{

    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.textColor = RGB(255,98,1);
        _codeLabel.font = [UIFont systemFontOfSize:14.0f];
        _codeLabel.text = @"获取验证码";
        _codeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeLblClick)];
        [_codeLabel addGestureRecognizer:tap];
    }
    return _codeLabel;
}

-(UITextField *)passWordTextfield{
    
    if (!_passWordTextfield) {
        _passWordTextfield = [[UITextField alloc]init];
        _passWordTextfield.placeholder = @"请输入密码";
        _passWordTextfield.font = [UIFont systemFontOfSize:15.0f];
        _passWordTextfield.borderStyle = UITextBorderStyleNone;
        _passWordTextfield.secureTextEntry = YES;
    }
    return _passWordTextfield;
}

-(UITextField *)codeTextfield{

    if (!_codeTextfield) {
        _codeTextfield = [[UITextField alloc]init];
        _codeTextfield.placeholder = @"请输入验证码";
        _codeTextfield.font = [UIFont systemFontOfSize:15.0f];
        _codeTextfield.borderStyle = UITextBorderStyleNone;
        _codeTextfield.backgroundColor =[UIColor whiteColor];
    }
    return _codeTextfield;
}
-(UITextField *)phoneNumTextfield{

    if (!_phoneNumTextfield) {
        _phoneNumTextfield = [[UITextField alloc]init];
        _phoneNumTextfield.placeholder = @"请输入手机号";
        _phoneNumTextfield.font = [UIFont systemFontOfSize:15.0f];
        _phoneNumTextfield.borderStyle = UITextBorderStyleNone;
        _phoneNumTextfield.backgroundColor =[UIColor whiteColor];
    }
    return _phoneNumTextfield;
}
-(UIImageView *)passwordImgView{
    
    if (!_passwordImgView) {
        _passwordImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_mima"]];
        
    }
    return _passwordImgView;
}
-(UIImageView *)phoneImgView{
    
    if (!_phoneImgView) {
        _phoneImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_shouji"]];
        
    }
    return _phoneImgView;
}
-(UIImageView *)codeImgView{
    
    if (!_codeImgView) {
        _codeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_yanzhengma"]];
        
    }
    return _codeImgView;
}

-(UIImageView *)topImgView{

    if (!_topImgView) {
        _topImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_biglogo"]];
    
    }
    return _topImgView;
}
@end
