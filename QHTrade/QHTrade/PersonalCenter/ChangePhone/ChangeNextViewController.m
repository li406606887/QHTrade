//
//  ChangeNextViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangeNextViewController.h"
#import "ChangeNextMainView.h"
#import "ChangeNextViewModel.h"
@interface ChangeNextViewController ()

@property(nonatomic,strong)ChangeNextMainView * mainView;
@property(nonatomic,strong)ChangeNextViewModel *viewModel;
@end

@implementation ChangeNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更换手机号1";
    
    [self.view addSubview:self.mainView];

    
}
-(void)updateViewConstraints{
    
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
-(void)bindViewModel{


}

-(ChangeNextViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[ChangeNextViewModel alloc]init];
    }
    return _viewModel;
}
-(ChangeNextMainView *)mainView{

    if (!_mainView) {
        _mainView = [[ChangeNextMainView alloc]initWithViewModel:self.viewModel];
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
