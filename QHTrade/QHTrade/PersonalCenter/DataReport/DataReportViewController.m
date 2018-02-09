//
//  DataReportViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DataReportViewController.h"
#import "DataReportMainView.h"
#import "DataReportViewModel.h"

@interface DataReportViewController ()
@property (nonatomic,strong) DataReportMainView * mainView;
@property (nonatomic,strong) DataReportViewModel * viewModel;
@end

@implementation DataReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    self.title = @"数据报表";
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

-(DataReportViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[DataReportViewModel alloc]init];
    }
    return _viewModel;
}
-(DataReportMainView *)mainView{

    if (!_mainView) {
        _mainView = [[DataReportMainView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = [UIColor whiteColor];
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
