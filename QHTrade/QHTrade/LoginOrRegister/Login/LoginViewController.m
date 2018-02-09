//
//  LoginViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/9.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()
@property(nonatomic, strong)LoginView * loginView;
@property(nonatomic,strong)LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.loginView];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self events];
    
    
}

-(void)events {
    @weakify(self);
    RAC(self.viewModel, phoneNumStr) = self.loginView.phoneNumTextfield.rac_textSignal;
    RAC(self.viewModel, passWordStr) = self.loginView.passWordTextfield.rac_textSignal;
    
    [self.loginView.phoneNumTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x==%@ textfield=%@",x,self.loginView.phoneNumTextfield.text);
        static NSInteger const maxIntegerlength = 11;
        if (x.length) {
            if (x.length > 11) {
                @strongify(self);
                self.loginView.phoneNumTextfield.text = [self.loginView.phoneNumTextfield.text substringToIndex:maxIntegerlength];
            }
        }
    }];
    
    [self.loginView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x==%@ passwordtextfield=%@",x,self.loginView.passWordTextfield.text);
    }];
    
    self.loginView.loginButton.rac_command = self.viewModel.loginCommand;
    
    RAC(self.loginView.loginButton,backgroundColor) = [self.viewModel.loginBtnEnable map:^id _Nullable(NSNumber * value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor whiteColor];
    }];
    
    [self.viewModel.loginBtnEnable subscribeNext:^(NSNumber * x) {
        @strongify(self);
        self.loginView.loginButton.enabled = [x boolValue];
    }];
    
    [[self.viewModel.loginCommand executionSignals] subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(QHRequestModel * model) {
            if ([model.status intValue] == 200) {
                NSLog(@"登录成功返回%@",model.content);
//                showMassage(@"登录成功");
                NSString *userid = [NSString stringWithFormat:@"%@",[model.content objectForKey:@"userId"]];
                NSString *token =[NSString stringWithFormat:@"%@",[model.content objectForKey:@"token"]];
                [[UserInformation getInformation] PostUserInformationDataWithUserId:userid andtoken:token andPhoneNumber:self.loginView.passWordTextfield.text];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else showMassage(model.message)
            
        }];
    }];
    //跳转页面
    [[self.viewModel.forgetSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"forget");
        ForgetPasswordViewController * FVC = [[ForgetPasswordViewController alloc]init];
        FVC.title =@"密码找回";
        [self.navigationController pushViewController:FVC animated:YES];
    }];
    
    [[self.viewModel.quickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"quick");//快速登录
    }];
}

-(void)updateViewConstraints {
    WS(weakSelf)
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
-(void)bindViewModel {
    
    
}
-(void)registerBtnClick:(id)sender {
    RegisterViewController * RVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RVC animated:YES];
}
-(UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 23)];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 23)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
-(void)saveBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithViewModel:self.viewModel];
    }
    return _loginView;
}

-(LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc]init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
