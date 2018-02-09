//
//  GroupViewController.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupView.h"
#import "GroupViewModel.h"
#import "GroupViewModel.h"
#import "GroupDetailsViewController.h"
#import "ReleaseShowViewController.h"
#import "LoginViewController.h"

@interface GroupViewController ()
@property(nonatomic,strong) GroupView *groupView;
@property(nonatomic,strong) GroupViewModel *viewModel;
@property(nonatomic,assign) BOOL loginState;
@property(nonatomic,strong) UIButton* releaseBtn;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.loginState = [[UserInformation getInformation] getLoginState];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.loginState == YES&&[[UserInformation getInformation].userModel.fierce intValue]==1){
            self.releaseBtn.hidden = NO;
    }else{
        self.releaseBtn.hidden = YES;

    }
    if ([[UserInformation getInformation] getLoginState] != self.loginState) {
            [self.viewModel.requestGroupDataCommand execute:@"0"];
        self.loginState = [[UserInformation getInformation] getLoginState];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.groupView];
}

-(UIView *)centerView {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    title.text = @"广场";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    return title;
}
-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.groupCellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(GroupModel*  _Nullable model) {
        GroupDetailsViewController *groupDetails = [[GroupDetailsViewController alloc] init];
        groupDetails.model = model;
        groupDetails.callBackBlock = ^(GroupModel *model) {
            [self.viewModel.refreshPriseStateSubject sendNext:model];            
        };
        [self.navigationController pushViewController:groupDetails animated:YES];
    }];
    [self.viewModel.gotoLoginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self gotoLogin];
    }];
}

- (UIBarButtonItem *)rightButton {
    
    return [[UIBarButtonItem alloc] initWithCustomView:self.releaseBtn];
}

-(void)gotoLogin {
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

-(void)actionOnTouchBackButton {
    if (![[UserInformation getInformation] getLoginState]) {
        [self gotoLogin];
        return;
    }
    if ([[UserInformation getInformation].userModel.fierce intValue]!=1) {
        showMassage(@"只有牛人才可以发布内容");
        return;
    }
    ReleaseShowViewController *release = [[ReleaseShowViewController alloc] init];
    release.refreshBlock = ^(){
        [self.viewModel.requestGroupDataCommand execute:@"0"];
    };
    [self.navigationController pushViewController:release animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(UIButton *)releaseBtn {
    if (!_releaseBtn) {
        _releaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [_releaseBtn setImage:[UIImage imageNamed:@"Navigation_ReleaseShow_Image"] forState:UIControlStateNormal];//设置左边按钮的图片
        [_releaseBtn addTarget:self action:@selector(actionOnTouchBackButton) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    }
    return _releaseBtn;
}

-(GroupView *)groupView {
    if (!_groupView) {
        _groupView = [[GroupView alloc] initWithViewModel:self.viewModel];
    }
    return _groupView;
}

-(GroupViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GroupViewModel alloc] init];
    }
    return _viewModel;
}
@end
