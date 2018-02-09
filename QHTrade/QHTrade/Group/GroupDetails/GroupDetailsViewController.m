//
//  GroupDetailsViewController.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "GroupDetailsView.h"
#import "GroupDetailsViewModel.h"
#import "LoginViewController.h"

@interface GroupDetailsViewController ()
@property(nonatomic,strong) GroupDetailsView *groupDetailsView;
@property(nonatomic,strong) GroupDetailsViewModel *viewModel;
@property(nonatomic,assign) BOOL isClick;
@end

@implementation GroupDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"圈子详情"];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isClick) {
        self.callBackBlock(self.viewModel.model);
    }
}
-(void)addChildView {
    [self.view addSubview:self.groupDetailsView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.groupDetailsView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.gotoLoginSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }];
    //self.callBackBlock(x);
    [[self.viewModel.backSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(GroupModel * model) {
        self.isClick = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setModel:(GroupModel *)model{
    self.viewModel.model = model;
}
/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(GroupDetailsView *)groupDetailsView {
    if (!_groupDetailsView) {
        _groupDetailsView = [[GroupDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _groupDetailsView;
}

-(GroupDetailsViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[GroupDetailsViewModel alloc] init];
    }
    return _viewModel;
}
@end
