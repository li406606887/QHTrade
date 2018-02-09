//
//  ForgetMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"
#import "ForgetViewModel.h"

@interface ForgetMainView : BaseView

@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneNumTextfield;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UITextField *codeTextfield;
@property (nonatomic,strong) UILabel *getCodeLabel;
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UILabel *passWordLabel;
@property (nonatomic,strong) UITextField *passWordTextfield;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel *againLabel;
@property (nonatomic,strong) UITextField *againPassWordTextfield;

@property (nonatomic,strong) UIButton *commitButton;

@property (nonatomic,strong) ForgetViewModel *viewModel;
@end
