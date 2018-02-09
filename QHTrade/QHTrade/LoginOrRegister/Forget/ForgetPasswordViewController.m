//
//  ForgetPasswordViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ForgetMainView.h"
#import "ForgetViewModel.h"

@interface ForgetPasswordViewController ()
@property (nonatomic,strong) ForgetMainView * mainView;
@property (nonatomic,strong) ForgetViewModel * viewModel;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) BOOL paramAllow;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    [self events];
    self.mainView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap)];
    [self.mainView addGestureRecognizer:tap];
}
-(void)bgTap{
    [self.mainView endEditing:YES];
    
}
-(void)events{
    
    @weakify(self);
    RAC(self.viewModel, phoneStr) = self.mainView.phoneNumTextfield.rac_textSignal;
    RAC(self.viewModel, codeStr) = self.mainView.codeTextfield.rac_textSignal;
    RAC(self.viewModel, passWordStr) = self.mainView.passWordTextfield.rac_textSignal;
    RAC(self.viewModel, againPWStr) = self.mainView.againPassWordTextfield.rac_textSignal;
    
    [self.mainView.phoneNumTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        if (x.length) {
            if (x.length > 11) {
                @strongify(self);
                self.mainView.phoneNumTextfield.text = [self.mainView.phoneNumTextfield.text substringToIndex:11];
            }
        }
    }];
    
    [self.mainView.codeTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
    }];
    
    [self.mainView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
    }];
    
    self.mainView.commitButton.rac_command = self.viewModel.commitCommand;
    
    RAC(self.mainView.commitButton, backgroundColor) = [self.viewModel.commitBtnEnable map:^id _Nullable(NSNumber * value) {
        return [value boolValue] ? [UIColor whiteColor]:[UIColor whiteColor];
    }];
    
    [self.viewModel.commitBtnEnable subscribeNext:^(NSNumber * x) {
        @strongify(self);
        //        self.mainView.registerButton.enabled  = [x boolValue];
        self.paramAllow = [x boolValue];
        self.mainView.commitButton.enabled =  self.paramAllow;
    }];
    
    [[self.viewModel.commitCommand executionSignals] subscribeNext:^(id  _Nullable x) {
        
        [x subscribeNext:^(QHRequestModel* model) {
            NSLog(@"密码找回成功返回数据%@",model);
            if ([model.status intValue] == 200) {
                showMassage(@"成功")
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }];
    

    
}
-(void)bindViewModel{
    WS(weakSelf)
    [[self.viewModel.getCodeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了获取验证码");
        [weakSelf getCode];
    }];
    
}
-(void)getCode{
    
    if (![UserInformation isMobileNumber:self.mainView.phoneNumTextfield.text]) {
        showMassage(@"手机号格式错误")
        return;
    }
    
    WS(weakSelf)
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.mainView.phoneNumTextfield.text forKey:@"mobile"];
    [dic setObject:@"2" forKey:@"check_type"];
    loading(@"")
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel * model = [QHRequest postDataWithApi:@"/smscodes" withParam:dic error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            [MBProgressHUD hideHUDForView:nil];
            if (error == nil) {
                if ([model.status intValue] ==200 ) {
                    weakSelf.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(buttonLoadSecond) userInfo:nil repeats:YES];
                }
                
            }
            showMassage(model.message)
        });
    });
}

-(void)buttonLoadSecond{
    
    self.count++;
    if (60-self.count>0) {
        [self.mainView.getCodeLabel setText:[NSString stringWithFormat:@"%d秒后重试",60-self.count]];
        [self.mainView.getCodeLabel setUserInteractionEnabled:NO];
    }else{
        [self.timer invalidate];
        self.timer= nil;
        self.count = 0;
        [self.mainView.getCodeLabel setText:@"获取验证码"];
        [self.mainView.getCodeLabel setUserInteractionEnabled:YES];
    }
    
}

-(void)updateViewConstraints{

    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}


-(ForgetViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[ForgetViewModel alloc]init];
    }
    return _viewModel;
}
-(ForgetMainView *)mainView{

    if (!_mainView) {
        _mainView = [[ForgetMainView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = RGB(243, 244, 245);
    }
    return _mainView;
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
