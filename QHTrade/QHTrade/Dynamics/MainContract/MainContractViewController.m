//
//  MainContractViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MainContractViewController.h"
#import "MainContractViewModel.h"
#import "MainContractView.h"
@interface MainContractViewController ()
@property(nonatomic,strong)MainContractView *mainContractView;
@property(nonatomic,strong)MainContractViewModel *mainContractViewModel;

@end

@implementation MainContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addChildView{
    [self.view addSubview:self.mainContractView];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.mainContractView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
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
-(MainContractView *)mainContractView{
    if (!_mainContractView) {
        _mainContractView = [[MainContractView alloc] initWithViewModel:self.mainContractViewModel];
    }
    return _mainContractView;
}
-(MainContractViewModel *)mainContractViewModel{
    if (!_mainContractViewModel) {
        _mainContractViewModel = [[MainContractViewModel alloc] init];
    }
    return _mainContractViewModel;
}
@end
