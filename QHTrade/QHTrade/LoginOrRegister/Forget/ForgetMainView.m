//
//  ForgetMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//
#define LINECOLOE [UIColor colorWithRed:209.0/255.0 green:210.0/255.0 blue:211.0/255.0 alpha:1.0f]
#import "ForgetMainView.h"

@interface ForgetMainView ()

@end

@implementation ForgetMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (ForgetViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)codeLblClick{
    
    [self.viewModel.getCodeSubject sendNext:nil];
    
}
-(void)setupViews{

    [self addSubview:self.topLabel];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.phoneLabel];
    [self.bgView addSubview:self.phoneNumTextfield];
    [self.bgView addSubview:self.line];
    [self.bgView addSubview:self.codeLabel];
    [self.bgView addSubview:self.codeTextfield];
    [self.bgView addSubview:self.getCodeLabel];
    [self.bgView addSubview:self.line1];
    [self.bgView addSubview:self.passWordLabel];
    [self.bgView addSubview:self.passWordTextfield];
    [self.bgView addSubview:self.line2];
    [self.bgView addSubview:self.againLabel];
    [self.bgView addSubview:self.againPassWordTextfield];
    
    [self addSubview:self.commitButton];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)layoutSubviews{
    
    WS(weakSelf)
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_offset(20);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.topLabel.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(183);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgView.mas_bottom).with.offset(50);
        make.left.equalTo(weakSelf).with.offset(16);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.height.mas_offset(40);
    }];

    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.bgView).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.size.mas_offset(CGSizeMake(65, 25));
    }];
    
    [self.phoneNumTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.centerY.equalTo(weakSelf.phoneLabel);
        make.left.equalTo(weakSelf.phoneLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(25);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.line.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.size.mas_offset(CGSizeMake(65, 25));
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.centerY.equalTo(weakSelf.codeLabel);
        make.left.equalTo(weakSelf.codeLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.bgView).with.offset(-100);
        make.height.mas_equalTo(25);
    }];
    
    [self.getCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.centerY.equalTo(weakSelf.codeLabel);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.line1.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.size.mas_offset(CGSizeMake(65, 25));
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.centerY.equalTo(weakSelf.passWordLabel);
        make.left.equalTo(weakSelf.passWordLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(25);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.passWordLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.againLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.line2.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf.bgView).with.offset(16);
        make.size.mas_offset(CGSizeMake(65, 25));
    }];
    
    [self.againPassWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.centerY.equalTo(weakSelf.againLabel);
        make.left.equalTo(weakSelf.againLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.bgView).with.offset(-16);
        make.height.mas_equalTo(25);
    }];
    
    [super layoutSubviews];
}

-(UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setTitle:@"确认" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"btn_ablebg_image"] forState:UIControlStateNormal];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"btn_unable_bg_image"] forState:UIControlStateDisabled];
    }
    return _commitButton;
}
-(UITextField *)againPassWordTextfield{
    
    if (!_againPassWordTextfield) {
        _againPassWordTextfield = [[UITextField alloc]init];
        _againPassWordTextfield.font = [UIFont systemFontOfSize:15.0f];
        _againPassWordTextfield.placeholder = @"请确认密码";
    }
    return _againPassWordTextfield;
}
-(UITextField *)passWordTextfield{

    if (!_passWordTextfield) {
        _passWordTextfield = [[UITextField alloc]init];
        _passWordTextfield.font = [UIFont systemFontOfSize:15.0f];
        _passWordTextfield.placeholder = @"请输入密码";
    }
    return _passWordTextfield;
}
-(UITextField *)codeTextfield{
    
    if (!_codeTextfield) {
        _codeTextfield = [[UITextField alloc]init];
        _codeTextfield.font = [UIFont systemFontOfSize:15.0f];
        _codeTextfield.placeholder = @"请输入验证码";
    }
    return _codeTextfield;
}
-(UITextField *)phoneNumTextfield{

    if (!_phoneNumTextfield) {
        _phoneNumTextfield = [[UITextField alloc]init];
        _phoneNumTextfield.font = [UIFont systemFontOfSize:15.0f];
        _phoneNumTextfield.placeholder = @"请输入手机号";
    }
    return _phoneNumTextfield;
}
-(UIView *)bgView{
    
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setMasksToBounds:YES];
        [_bgView.layer setBorderWidth:1.0];
        _bgView.layer.borderColor = LINECOLOE.CGColor;
    }
    return _bgView;
}
-(UIView *)line2{
    
    if (!_line2) {
        _line2 = [[UIView alloc]init];
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
//获取验证码
-(UILabel *)getCodeLabel{

    if (!_getCodeLabel) {
        _getCodeLabel = [[UILabel alloc]init];
        _getCodeLabel.text = @"获取验证码";
        _getCodeLabel.textAlignment = NSTextAlignmentCenter;
        _getCodeLabel.textColor = RGB(255, 98, 1);
        _getCodeLabel.font = [UIFont systemFontOfSize:12.f];
        _getCodeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeLblClick)];
        [_getCodeLabel addGestureRecognizer:tap];
    }
    return _getCodeLabel;
}

-(UILabel *)againLabel{

    if (!_againLabel) {
        _againLabel = [[UILabel alloc]init];
        _againLabel.text = @"确认密码";
        _againLabel.textAlignment = NSTextAlignmentLeft;
        _againLabel.textColor = RGB(51, 51, 51);
        _againLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _againLabel;
}
-(UILabel *)passWordLabel{

    if (!_passWordLabel) {
        _passWordLabel = [[UILabel alloc]init];
        _passWordLabel.text = @"密码";
        _passWordLabel.textAlignment = NSTextAlignmentLeft;
        _passWordLabel.textColor = RGB(51, 51, 51);
        _passWordLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _passWordLabel;
}
-(UILabel *)codeLabel{

    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.text = @"验证码";
        _codeLabel.textAlignment = NSTextAlignmentLeft;
        _codeLabel.textColor = RGB(51, 51, 51);
        _codeLabel.font = [UIFont systemFontOfSize:15.f];
        
    }
    return _codeLabel;

}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"手机号";
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.textColor = RGB(51, 51, 51);
        _phoneLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _phoneLabel;

}
-(UILabel *)topLabel{

    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = @"请输入你注册时使用的手机号码";
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.textColor = RGB(51, 51, 51);
        _topLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _topLabel;
}
@end
