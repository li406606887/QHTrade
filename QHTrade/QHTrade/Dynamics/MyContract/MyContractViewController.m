//
//  MyContractViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyContractViewController.h"
#import "MyContractViewModel.h"
#import "MyContractView.h"

@interface MyContractViewController ()
@property(nonatomic,strong)MyContractViewModel *viewModel;
@property(nonatomic,strong)MyContractView *myContractView;
@end

@implementation MyContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


-(void)addChildView{
    
    [self.view addSubview:self.myContractView];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.myContractView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(MyContractView *)myContractView{
    if (!_myContractView) {
        _myContractView = [[MyContractView alloc] initWithViewModel:self.viewModel];

    }
    return _myContractView;
}

-(MyContractViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MyContractViewModel alloc] init];
    }
    return _viewModel;
}
@end
