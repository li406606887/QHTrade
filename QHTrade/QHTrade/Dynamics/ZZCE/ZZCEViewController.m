//
//  ZZCEViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ZZCEViewController.h"
#import "ZZCEViewModel.h"
#import "ZZCEView.h"

@interface ZZCEViewController ()
@property(nonatomic,strong)ZZCEView *zzceView;
@property(nonatomic,strong)ZZCEViewModel *zzceViewModel;
@end

@implementation ZZCEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addChildView{
    [self.view addSubview:self.zzceView];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.zzceView mas_makeConstraints:^(MASConstraintMaker *make) {
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
-(ZZCEView *)zzceView{
    if (!_zzceView) {
        _zzceView = [[ZZCEView alloc] initWithViewModel:self.zzceViewModel];
    }
    return _zzceView;
}
-(ZZCEViewModel *)zzceViewModel{
    if (!_zzceViewModel) {
        _zzceViewModel = [[ZZCEViewModel alloc] init];
    }
    return _zzceViewModel;
}


@end
