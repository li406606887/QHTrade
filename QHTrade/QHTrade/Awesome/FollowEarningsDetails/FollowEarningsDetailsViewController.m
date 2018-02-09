//
//  FollowEarningsDetailsViewController.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsDetailsViewController.h"
#import "FollowEarningsDetailsView.h"
#import "FollowEarningsDetailsViewModel.h"
#import "AwesomeDetailsViewController.h"

@interface FollowEarningsDetailsViewController ()
@property(nonatomic,strong) FollowEarningsDetailsViewModel *viewModel;
@property(nonatomic,strong) FollowEarningsDetailsView *followEarningsDetailsView;
@end

@implementation FollowEarningsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"跟单信息"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.followEarningsDetailsView];
}

-(void)setUserID:(NSString *)userID {
    self.viewModel.userID = userID;
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.followEarningsDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    [[self.viewModel.awesomeClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString*  _Nullable awesomeID) {
        AwesomeDetailsViewController *awesomeDetails = [[AwesomeDetailsViewController alloc] init];
        awesomeDetails.awesomeID = awesomeID;
        [self.navigationController pushViewController:awesomeDetails animated:YES];
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
-(FollowEarningsDetailsView *)followEarningsDetailsView {
    if (!_followEarningsDetailsView) {
        _followEarningsDetailsView = [[FollowEarningsDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _followEarningsDetailsView;
}

-(FollowEarningsDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FollowEarningsDetailsViewModel alloc] init];
    }
    return _viewModel;
}
@end
