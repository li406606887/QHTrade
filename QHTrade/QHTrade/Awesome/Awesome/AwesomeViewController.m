//
//  AwesomeViewController.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeViewController.h"
#import "RookieView.h"
#import "AwesomeView.h"
#import "CanFollowView.h"
#import "AwesomeModel.h"
#import "AwesomeViewModel.h"
#import "FollowEarningsTopView.h"
#import "AwesomeDetailsViewController.h"
#import "FollowEarningsDetailsViewController.h"
#import "SegmentedControlView.h"
#import "FollowEarningsModel.h"
#import "FollowSetingViewController.h"
#import "LoginViewController.h"

@interface AwesomeViewController ()
@property(nonatomic,strong) RookieView *rookieView;
@property(nonatomic,strong) AwesomeView *awesomeView;
@property(nonatomic,strong) FollowEarningsTopView *followEarningsTopView;
@property(nonatomic,strong) CanFollowView *canFollowView;
@property(nonatomic,retain) AwesomeViewModel *viewModel;
@property(nonatomic,strong) SegmentedControlView *segmentedControl;
@property(nonatomic,strong) NSMutableArray *btnArray;
@property(nonatomic,assign) int oldIndex;
@property(nonatomic,weak  ) BaseView *childView;
@property(nonatomic,strong) UIView * navView;
@end

@implementation AwesomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.childView isKindOfClass:[RookieView class]]) {
        [self.viewModel.rookieDataCommand execute:@"0"];
    }else if([self.childView isKindOfClass:[AwesomeView class]]) {
        [self.viewModel.awesomeDataCommand execute:@"0"];
    }else if([self.childView isKindOfClass:[CanFollowView class]]) {
        [self.viewModel.canDataCommand execute:@"0"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChildView {
    [self.view addSubview:self.canFollowView];
    self.childView = self.canFollowView;
}

-(UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc]init];
        _navView.backgroundColor = [UIColor redColor];
        [_navView addSubview:self.segmentedControl];
    }
    return _navView;
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    @weakify(self)
    [self.childView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.followEarningsCellClick takeUntil:self.rac_willDeallocSignal ] subscribeNext:^(FollowEarningsModel*  _Nullable model) {
        @strongify(self)
        FollowEarningsDetailsViewController *followEarningsDetails = [[FollowEarningsDetailsViewController alloc] init];
        followEarningsDetails.userID = model.userId;
        [self.navigationController pushViewController:followEarningsDetails animated:YES];
    }];
    
    [[self.viewModel.awesomeCellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(AwesomeModel* _Nullable model) {
        @strongify(self)
        AwesomeDetailsViewController *awesomeDetails = [[AwesomeDetailsViewController alloc] init];
        awesomeDetails.awesomeID = model.userId;
        [self.navigationController pushViewController:awesomeDetails animated:YES];
    }];
 
    [[self.viewModel.awesomeFollowActionClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(AwesomeModel*  _Nullable model) {
        @strongify(self)
        FollowSetingViewController *followEarning = [[FollowSetingViewController alloc] init];
        followEarning.model = model;
        [self.navigationController pushViewController:followEarning animated:YES];
    }];
}

-(UIView *)centerView {
    self.segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.85,  30);
    return self.segmentedControl;
}

-(void)segmentedControlClick:(int)index {
    switch (index) {
        case 0:
            [self.childView removeFromSuperview];
            [self.view addSubview:self.canFollowView];
            self.childView = self.canFollowView;
            break;
        case 1:
            [self.childView removeFromSuperview];
            [self.view addSubview:self.awesomeView];
            self.childView = self.awesomeView;
            break;
        case 2:
            [self.childView removeFromSuperview];
            [self.view addSubview:self.rookieView];
            self.childView = self.rookieView;
            break;
        case 3:
            [self.childView removeFromSuperview];
            [self.view addSubview:self.followEarningsTopView];
            self.childView = self.followEarningsTopView;
            break;
      
            
        default:
            break;
    }
    self.oldIndex = index;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(SegmentedControlView *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[SegmentedControlView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.85, 30) item:[NSArray arrayWithObjects:@"人气榜",@"牛人榜",@"新人榜",@"跟单收益榜", nil]];
        @weakify(self);
        _segmentedControl.itemClick = ^(int index) {
            @strongify(self)
            [self segmentedControlClick:index];
        };
        _segmentedControl.defultTitleColor = RGB(151, 150, 150);
        _segmentedControl.selectedTitleColor = [UIColor whiteColor];
        _segmentedControl.defultBackgroundColor = [UIColor whiteColor];
        _segmentedControl.selectedBackgroundColor = RGB(236, 93, 30);
        _segmentedControl.font = 13;
        _segmentedControl.layer.masksToBounds = YES;
        _segmentedControl.layer.cornerRadius = 15;
        _segmentedControl.layer.borderWidth = 0.5f;
        _segmentedControl.layer.borderColor = RGB(213, 214, 215).CGColor;
    }
    return _segmentedControl;
}

-(int)oldIndex {
    if (!_oldIndex) {
        _oldIndex = 0;
    }
    return _oldIndex;
}

-(AwesomeView *)awesomeView {
    if (!_awesomeView) {
        _awesomeView = [[AwesomeView alloc] initWithViewModel:self.viewModel];
        
    }
    return _awesomeView;
    
}

-(RookieView *)rookieView {
    if (!_rookieView) {
        _rookieView = [[RookieView alloc] initWithViewModel:self.viewModel];
        
    }
    return _rookieView;
}

-(FollowEarningsTopView *)followEarningsTopView {
    if (!_followEarningsTopView) {
        _followEarningsTopView = [[FollowEarningsTopView alloc] initWithViewModel:self.viewModel];
    }
    return _followEarningsTopView;
}

-(CanFollowView *)canFollowView {
    if (!_canFollowView) {
        _canFollowView = [[CanFollowView alloc] initWithViewModel:self.viewModel];
    }
    return _canFollowView;
}

-(AwesomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AwesomeViewModel alloc] init];
    }
    return _viewModel;
}
-(void)gotoLogin {
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];

}
-(BOOL )getState {
    
    if ([UserInformation getInformation].userModel.ctpAccount.length<1) {
        showMassage(@"暂未绑定交易账号")
        return NO;
    }
    return YES;
}
@end
