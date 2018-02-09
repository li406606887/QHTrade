//
//  AwesomeSignalViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeSignalViewController.h"


@interface AwesomeSignalViewController ()


@end

@implementation AwesomeSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
    self.title = @"牛人信号";
    [self.viewModel.refreshDataCommand execute:nil];
}
-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(AwesomeSignalMainView *)mainView {
    if (!_mainView) {
        _mainView = [[AwesomeSignalMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
}
-(AwesomeSiganlViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AwesomeSiganlViewModel alloc]init];
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
