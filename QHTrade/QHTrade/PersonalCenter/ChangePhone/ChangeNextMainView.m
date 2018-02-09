//
//  ChangeNextMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangeNextMainView.h"
#import "ChangeNextViewModel.h"
@interface ChangeNextMainView()
@property (nonatomic,strong)ChangeNextViewModel * viewModel;
@end

@implementation ChangeNextMainView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (ChangeNextViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
    
}
//发送验证码
-(void)sendCodeClick{


}

-(void)areaNumClick{

    
}

-(void)commitClick:(id)sender{
    
}

-(void)setupViews{
    
    [self addSubview:self.signImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.areaLabel];
    [self addSubview:self.areaNumLabel];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.phoneTextfield];
    [self addSubview:self.sendCodeLabel];
    [self addSubview:self.codeLabel];
    [self addSubview:self.codeTextfield];
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
    
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.signImageView.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
    }];
    
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.areaLabel);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];

    [self.areaNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.areaLabel);
        make.right.equalTo(weakSelf.arrowImgView.mas_left).with.offset(-3);
        make.size.mas_equalTo(CGSizeMake(95, 35));
        
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.areaLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
        
    }];
    
    [self.sendCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.phoneLabel);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    
    [self.phoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.phoneLabel);
        make.left.equalTo(weakSelf.phoneLabel.mas_right).with.offset(10);
        make.right.equalTo(weakSelf.sendCodeLabel.mas_left).with.offset(-1);
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.codeLabel);
        make.left.equalTo(weakSelf.codeLabel.mas_right).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.codeTextfield.mas_bottom).with.offset(50);
        make.left.equalTo(weakSelf).with.offset(15);
        make.right.equalTo(weakSelf).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [super updateConstraints];
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

-(UILabel *)codeLabel{
    
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]init];
        _codeLabel.text = @"短信验证";
        _codeLabel.textColor = RGB(51, 51, 51);
        _codeLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _codeLabel;
}

-(UILabel *)sendCodeLabel{

    if (!_sendCodeLabel) {
        _sendCodeLabel = [[UILabel alloc]init];
        _sendCodeLabel.text = @"发送验证码";
        _sendCodeLabel.textColor = RGB(183, 142, 73);
        _sendCodeLabel.font = [UIFont systemFontOfSize:15.0f];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(sendCodeClick)];
        [_areaNumLabel addGestureRecognizer:tap];
    }
    return _sendCodeLabel;
}

-(UITextField *)phoneTextfield{
    
    if (!_phoneTextfield) {
        _phoneTextfield = [[UITextField alloc]init];
        _phoneTextfield.placeholder = @"请输入手机号码";
        _phoneTextfield.font = [UIFont systemFontOfSize:15.0f];
        _phoneTextfield.borderStyle = UITextBorderStyleLine;
        _phoneTextfield.backgroundColor =[UIColor whiteColor];
        
        _phoneTextfield.layer.borderColor= RGB(235, 235, 235).CGColor;
        _phoneTextfield.layer.borderWidth= 1.0f;
    }
    return _phoneTextfield;
}

-(UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"手机号码";
        _phoneLabel.textColor = RGB(51, 51, 51);
        _phoneLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _phoneLabel;
}

-(UIImageView *)arrowImgView{
    
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_right_arr"]];//9*16
        _arrowImgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _arrowImgView;
}

-(UILabel *)areaNumLabel{
    
    if (!_areaNumLabel) {
        _areaNumLabel = [[UILabel alloc]init];
        _areaNumLabel.text = @"中国大陆 +86";
        _areaNumLabel.textColor = RGB(106, 106, 106);
        _areaNumLabel.font = [UIFont systemFontOfSize:15.0f];
        _areaNumLabel.textAlignment = NSTextAlignmentRight;
        
        _areaNumLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(areaNumClick)];
        [_areaNumLabel addGestureRecognizer:tap];
    }
    return _areaNumLabel;
}
-(UILabel *)areaLabel{
    
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc]init];
        _areaLabel.text = @"所属地区";
        _areaLabel.textColor = RGB(51, 51, 51);
        _areaLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _areaLabel;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.numberOfLines  = 0;
        _titleLabel.text = @"验证通过，请更换手机号";
    }
    return _titleLabel;
}
-(UIImageView *)signImageView{

    if (!_signImageView) {
        _signImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting_tick_icon"]];
        _signImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _signImageView;
}
@end
