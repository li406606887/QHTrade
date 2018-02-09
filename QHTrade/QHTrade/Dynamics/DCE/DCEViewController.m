//
//  DCEViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DCEViewController.h"
#import "DCEViewModel.h"
#import "DCEView.h"

@interface DCEViewController ()
@property(nonatomic,strong)DCEView *dceView;
@property(nonatomic,strong)DCEViewModel *dceViewModel;
@end

@implementation DCEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addChildView{
    [self.view addSubview:self.dceView];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.dceView mas_makeConstraints:^(MASConstraintMaker *make) {
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
-(DCEView *)dceView{
    if (!_dceView) {
        _dceView = [[DCEView alloc] initWithViewModel:self.dceViewModel];
    }
    return _dceView;
}
-(DCEViewModel *)dceViewModel{
    if (!_dceViewModel) {
        _dceViewModel = [[DCEViewModel alloc] init];
    }
    return _dceViewModel;
}


@end
