//
//  FollowSetingViewController.m
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowSetingViewController.h"
#import "FollowSetingViewModel.h"
#import "FollowSetingView.h"
#import "LoginViewController.h"
#import "TradeAccountViewController.h"
#import "RiskWarningViewController.h"
#import "CallMarginRemindView.h"

@interface FollowSetingViewController ()
@property(nonatomic,strong) FollowSetingView *mainView;
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@end

@implementation FollowSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"跟单设置"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

-(UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btn setTitle:@"风险揭示" forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitleColor:RGB(239, 92, 1) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(riskWarningClick) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)setModel:(AwesomeModel *)model{
    self.viewModel.model = model;
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.sumbitSuccessfulSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        CallMarginRemindView *callMargin = [[CallMarginRemindView alloc] initWithViewModel:self.viewModel];
        callMargin.promptString = [NSString stringWithFormat:@"补仓提醒：\n您的跟单比例为1:%@，如您的持仓与牛人持仓比例低于1:%@，建议您先进行补仓操作。补仓即将持仓进行调整，以不小于跟单比例的持仓数进行跟单，避免因仓位不同而造成的不能跟单的情况。",self.viewModel.setingModel.numScale,self.viewModel.setingModel.numScale];
        [[UIApplication sharedApplication].keyWindow addSubview:callMargin];
        [callMargin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo([UIApplication sharedApplication].keyWindow);
        }];
    }];

    [self.viewModel.gotoLoginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }];
    
    [self.viewModel.gotoBindCTPAcountSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        TradeAccountViewController *bindAcount = [[TradeAccountViewController alloc] init];
        [self.navigationController pushViewController:bindAcount animated:YES];
    }];
    
    [[self.viewModel.popViewControllerSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.viewModel.model.isFollows = @"1";
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

-(void)riskWarningClick{
    RiskWarningViewController *riskwarning = [[RiskWarningViewController alloc] init];
    riskwarning.prompt = @"   想要完全跟得上牛人账户操作，建议根据牛人账户资产规模来调整自己的账号权益，使得自己的账号权益大于或等于牛人资金权益，以便能做到同比例1:1跟单。\n   如果资金量不足，没有实现1:1跟单，可能会出现跟牛人不一样的持仓比例，请注意风险自控。";
    [self.navigationController pushViewController:riskwarning animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(FollowSetingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FollowSetingViewModel alloc] init];
    }
    return _viewModel;
}

-(FollowSetingView *)mainView {
    if (!_mainView) {
        _mainView = [[FollowSetingView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
@end
