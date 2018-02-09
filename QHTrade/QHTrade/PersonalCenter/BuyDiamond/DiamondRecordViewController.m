//
//  DiamondRecordViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondRecordViewController.h"
#import "DiamondRecordViewModel.h"
#import "DiamondRecordMainView.h"
@interface DiamondRecordViewController ()
@property (nonatomic,strong)DiamondRecordViewModel * viewModel;
@property (nonatomic,strong)DiamondRecordMainView * mainView;
@end

@implementation DiamondRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买记录";
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints{
    
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(DiamondRecordViewModel *)viewModel{


    if (!_viewModel) {
        _viewModel = [[DiamondRecordViewModel alloc]init];
        
    }
    return _viewModel;
}

-(DiamondRecordMainView *)mainView{

    if (!_mainView) {
        _mainView = [[DiamondRecordMainView alloc]initWithViewModel:self.viewModel];
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
