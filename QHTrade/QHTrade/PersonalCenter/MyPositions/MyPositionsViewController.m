//
//  MyPositionsViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyPositionsViewController.h"
#import "MyPositionsMainView.h"
#import "MyPositionsViewModel.h"

@interface MyPositionsViewController ()
@property(nonatomic, strong) MyPositionsMainView * mainView;
@property(nonatomic,strong) MyPositionsViewModel  * viewModel;
@end

@implementation MyPositionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的持仓";
    
    [self.view addSubview:self.mainView];
    
}
-(void)updateViewConstraints{

    WS(weakSelf)
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(MyPositionsMainView *)mainView{

    if (!_mainView) {
        _mainView = [[MyPositionsMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(MyPositionsViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[MyPositionsViewModel alloc]init];
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
