//
//  ReleaseShowViewController.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ReleaseShowViewController.h"
#import "ReleaseShowViewModel.h"
#import "ReleaseShowView.h"

@interface ReleaseShowViewController ()
@property(nonatomic,strong) ReleaseShowView *releaseShowView;
@property(nonatomic,strong) ReleaseShowViewModel *viewModel;
@end

@implementation ReleaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"发布动态"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.releaseShowView];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.sumbitSuccessfulSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.refreshBlock();
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.releaseShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.layer.borderWidth = 0.5f;
    btn.layer.borderColor = RGB(255, 98, 1).CGColor;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3;
    [btn addTarget:self action:@selector(releaseShow) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)releaseShow {
    [self.viewModel.releasehowCommmand execute:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(ReleaseShowView *)releaseShowView {
    if (!_releaseShowView) {
        _releaseShowView = [[ReleaseShowView alloc] initWithViewModel:self.viewModel];
    }
    return _releaseShowView;
}

-(ReleaseShowViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ReleaseShowViewModel alloc] init];
    }
    return _viewModel;
}
@end
