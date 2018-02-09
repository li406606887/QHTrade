//
//  SHFEViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SHFEViewController.h"
#import "SHFEView.h"
#import "SHFEViewModel.h"

@interface SHFEViewController ()
@property(nonatomic,strong)SHFEView *shfeView;
@property(nonatomic,strong)SHFEViewModel *shfeViewModel;

@end

@implementation SHFEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addChildView{
    [self.view addSubview:self.shfeView];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.shfeView mas_makeConstraints:^(MASConstraintMaker *make) {
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
-(SHFEView *)shfeView{
    if (!_shfeView) {
        _shfeView = [[SHFEView alloc] initWithViewModel:self.shfeViewModel];
    }
    return _shfeView;
}
-(SHFEViewModel *)shfeViewModel{
    if (!_shfeViewModel) {
        _shfeViewModel = [[SHFEViewModel alloc] init];
    }
    return _shfeViewModel;
}

@end
