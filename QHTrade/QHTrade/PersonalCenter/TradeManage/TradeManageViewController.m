//
//  TradeManageViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeManageViewController.h"
#import "TradeManageMainView.h"
#import "TradeManageViewModel.h"
#import "EvaluateView.h"
@interface TradeManageViewController ()
@property (nonatomic,strong) TradeManageMainView * mainView;
@property (nonatomic,strong) TradeManageViewModel * viewModel;
@end

@implementation TradeManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
    self.title = @"跟单管理";
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

-(TradeManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TradeManageViewModel alloc]init];
    }
    return _viewModel;
}
-(TradeManageMainView *)mainView {
    if (!_mainView) {
        _mainView = [[TradeManageMainView alloc]initWithViewModel:self.viewModel];

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
