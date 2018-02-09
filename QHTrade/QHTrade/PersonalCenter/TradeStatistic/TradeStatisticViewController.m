//
//  TradeStatisticViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeStatisticViewController.h"
#import "TradeStatisticViewModel.h"
#import "TradeStatisticMainView.h"
#import "TradeStatisticsModel.h"

@interface TradeStatisticViewController ()
@property (nonatomic,strong)TradeStatisticViewModel * viewModel;
@property (nonatomic,strong)TradeStatisticMainView * mainView;
@property (nonatomic,strong)TradeStatisticsModel * model;
@end

@implementation TradeStatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交易统计";
    [self.view addSubview:self.mainView];
    [self.viewModel.refreshDataCommand execute:nil];
}
-(void)bindViewModel{

    

}
-(void)updateViewConstraints{

    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(weakSelf.view);
    }];
    
    [super updateViewConstraints];
}
-(TradeStatisticViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[TradeStatisticViewModel alloc]init];
    }
    return _viewModel;
}
-(TradeStatisticMainView *)mainView{

    if (!_mainView) {
        _mainView = [[TradeStatisticMainView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = RGB(244, 244, 244);
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
