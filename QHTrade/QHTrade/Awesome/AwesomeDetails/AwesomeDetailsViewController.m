

//
//  AwesomeDetailsViewController.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeDetailsViewController.h"
#import "AwesomeDetailsViewModel.h"
#import "AwesomeDetailsView.h"
#import "LoginViewController.h"
#import "FollowSetingViewController.h"
#import "RiskWarningViewController.h"
#import "HistorySignalViewController.h"

@interface AwesomeDetailsViewController ()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) AwesomeDetailsView *awesomeDetailsView;
@end

@implementation AwesomeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(243, 244, 245)];
    [self setTitle:@"牛人信息"];
}

-(void)addChildView {
    [self.view addSubview:self.awesomeDetailsView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.awesomeDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(void)setAwesomeID:(NSString *)awesomeID {
    self.viewModel.awesomeID =awesomeID;
    [self.viewModel.awesomeInfoCommand execute:awesomeID];

}

-(void)bindViewModel{
    @weakify(self)
    [[self.viewModel.followEarningSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(AwesomeModel*  _Nullable model) {
        @strongify(self)
        FollowSetingViewController *followSeting = [[FollowSetingViewController alloc] init];
        followSeting.model = model;
        [self.navigationController pushViewController:followSeting animated:YES];
    }];
    [self.viewModel.gotoLoginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }];
    
    [self.viewModel.promptClickSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        RiskWarningViewController *riskWarning = [[RiskWarningViewController alloc] init];
        riskWarning.prompt = @"   想要完全跟得上牛人账户操作，建议根据牛人账户资产规模来调整自己的账号权益，使得自己的账号权益大于或等于牛人资金权益，以便能做到同比例1:1跟单。\n   如果资金量不足，没有实现1:1跟单，可能会出现跟牛人不一样的持仓比例，请注意风险自控。";
        [self.navigationController pushViewController:riskWarning animated:YES];
    }]; 
    
    [[self.viewModel.lookAllHistorySignalSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        HistorySignalViewController *history = [[HistorySignalViewController alloc] init];
        history.awesomeID = self.viewModel.awesomeID;
        [self.navigationController pushViewController:history animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AwesomeDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AwesomeDetailsViewModel alloc] init];
    }
    return _viewModel;
}

-(AwesomeDetailsView *)awesomeDetailsView {
    if (!_awesomeDetailsView) {
        _awesomeDetailsView = [[AwesomeDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _awesomeDetailsView;
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
