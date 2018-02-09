//
//  ChangePhoneMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangePhoneMainView.h"
#import "ChangePhoneViewModel.h"

@interface ChangePhoneMainView ()

@property (nonatomic,strong) ChangePhoneViewModel *viewModel;
//@property (nonatomic,strong) UIImageView *signImageView;
//@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,strong) UILabel *codeLabel;
//@property (nonatomic,strong) UILabel *passWordLabel;
//@property (nonatomic,strong) UITextField *codeTextfield;
//@property (nonatomic,strong) UITextField *passWordTextfield;
//@property (nonatomic,strong) UILabel *bottomLabel;
//@property (nonatomic,strong) UIButton *commitButton;
@end

@implementation ChangePhoneMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (ChangePhoneViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;

}
-(void)setupViews{

    [self addSubview:self.signImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.codeLabel];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.passWordLabel];
    [self addSubview:self.passWordTextfield];
    [self addSubview:self.bottomLabel];
    [self addSubview:self.commitButton];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}

-(void)updateConstraints{

    
    WS(weakSelf)

    [self.signImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(weakSelf).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.signImageView);
        make.left.equalTo(weakSelf.signImageView.mas_right).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.signImageView.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
    }];
    
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.codeLabel);
        make.left.equalTo(weakSelf.codeLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
    }];
    
    [self.passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.passWordLabel);
        make.left.equalTo(weakSelf.passWordLabel.mas_right).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(35);
    }];

    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.passWordTextfield.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(23);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.bottomLabel.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [super updateConstraints];
}
//提交
-(void)commitClick:(id)sender{

    [self.viewModel.commitBtnClick sendNext:nil];
}
-(UIButton *)commitButton{

    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setTitle:@"提交验证" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_commitButton setBackgroundImage:[UIImage imageNamed:@"btn_ablebg_image"] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

-(UILabel *)bottomLabel{

    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textColor = RGB(183, 142, 73);
        _bottomLabel.text = @"验证短信已发送，请保持手机信号畅通";
        _bottomLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _bottomLabel;
}

-(UITextField *)passWordTextfield{
    
    if (!_passWordTextfield) {
        _passWordTextfield = [[UITextField alloc]init];
        _passWordTextfield.placeholder = @"请输入登录密码";
        _passWordTextfield.font = [UIFont systemFontOfSize:15.0f];
        _passWordTextfield.borderStyle = UITextBorderStyleLine;
        _passWordTextfield.backgroundColor =[UIColor whiteColor];
        _passWordTextfield.layer.borderColor= RGB(235, 235, 235).CGColor;
        _passWordTextfield.layer.borderWidth= 1.0f;
        _passWordTextfield.secureTextEntry = YES;
    }
    return _passWordTextfield;
}
-(UITextField *)codeTextfield{

    if (!_codeTextfield) {
        _codeTextfield = [[UITextField alloc]init];
        _codeTextfield.placeholder = @"请输入验证码";
        _codeTextfield.font = [UIFont systemFontOfSize:15.0f];
        _codeTextfield.borderStyle = UITextBorderStyleLine;
        _codeTextfield.backgroundColor =[UIColor whiteColor];
        
        _codeTextfield.layer.borderColor= RGB(235, 235, 235).CGColor;
        _codeTextfield.layer.borderWidth= 1.0f;
    }
    return _codeTextfield;
}

-(UILabel *)passWordLabel{
    
    if (!_passWordLabel) {
        _passWordLabel = [[UILabel alloc]init];
        _passWordLabel.text = @"登录密码";
        _passWordLabel.textColor = RGB(51, 51, 51);
        _passWordLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _passWordLabel;
}

-(UILabel *)codeLabel{

    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.text = @"验证码";
        _codeLabel.textColor = RGB(51, 51, 51);
        _codeLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _codeLabel;
}
-(UILabel *)titleLabel{

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.numberOfLines  = 0;
        _titleLabel.text = @"更换手机号需重新认证，我们已向***********发送了一条验证短信，请输入短信验证码";
    }
    return _titleLabel;
}
-(UIImageView *)signImageView{

    if (!_signImageView) {
        _signImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting_notice_icon"]];
        _signImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _signImageView;
}
@end
