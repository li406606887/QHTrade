//
//  ChooseCompanyViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChooseCompanyViewController.h"
#import "ChooseCompanyMainView.h"
#import "ChooseCompanyViewModel.h"

@interface ChooseCompanyViewController ()
@property (nonatomic, strong) ChooseCompanyMainView * mainView;
@property (nonatomic,strong) ChooseCompanyViewModel * viewModel;
@end

@implementation ChooseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择开户公司";
    [self.view addSubview:self.mainView];
}
-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {
        @strongify(self)
        NSLog(@"^^^%@",x);
        self.callBackBlock(x);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(ChooseCompanyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ChooseCompanyViewModel alloc]init];
    }
    return _viewModel;
}

-(ChooseCompanyMainView *)mainView {
    if (!_mainView) {
        _mainView = [[ChooseCompanyMainView alloc]initWithViewModel:self.viewModel];
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
