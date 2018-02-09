//
//  FollowEarningChooseViewController.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningChooseViewController.h"
#import "FollowEarningChooseViewModel.h"
#import "FollowEarningChooseView.h"
#import "DiamondViewController.h"
#import "LoginViewController.h"
#import "TradeAccountViewController.h"
#import "FollowSetingViewController.h"

@interface FollowEarningChooseViewController ()
@property(nonatomic,strong) FollowEarningChooseView *followEarningChooseView;
@property(nonatomic,strong) FollowEarningChooseViewModel *viewModel;
@end

@implementation FollowEarningChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"跟单选择"];
}

-(void)addChildView {
    [self.view addSubview:self.followEarningChooseView];
    
}

-(void)setModel:(AwesomeModel *)model{
    self.viewModel.model = model;
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.followEarningChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.sumbitSuccessfulSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        showMassage(@"跟单成功")
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.viewModel.gotoBuyDiamondSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        DiamondViewController *diamond = [[DiamondViewController alloc] init];
        [self.navigationController pushViewController:diamond animated:YES];
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
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        FollowSetingModel *setingModel = [self.viewModel.setingModelDic objectForKey:[NSString stringWithFormat:@"%d",[x intValue]]];
        FollowSetingViewController *followSeting = [[FollowSetingViewController alloc] init];
//        followSeting.setingModel = setingModel;
//        followSeting.fllowSetingBlock = ^(FollowSetingModel *model) {
//            [self.viewModel.tableReloadSubject sendNext:model];
//        };
        [self.navigationController pushViewController:followSeting animated:YES];
    }];
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
-(FollowEarningChooseViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FollowEarningChooseViewModel alloc] init];
    }
    return _viewModel;
}

-(FollowEarningChooseView *)followEarningChooseView {
    if (!_followEarningChooseView) {
        _followEarningChooseView = [[FollowEarningChooseView alloc] initWithViewModel:self.viewModel];
    }
    return _followEarningChooseView;
}


@end
