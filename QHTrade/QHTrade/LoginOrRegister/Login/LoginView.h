//
//  LoginView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/9.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "LoginViewModel.h"
@interface LoginView : BaseView
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UITextField *phoneNumTextfield;
@property (nonatomic,strong) UITextField *passWordTextfield;
@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic,strong) UIImageView *phoneImgView;
@property (nonatomic,strong) UIImageView *passwordImgView;

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) LoginViewModel *viewModel;
@end
