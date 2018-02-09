//
//  HomeViewController.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeViewModel.h"
#import "HomeScrollModel.h"
#import "HomeNewsModel.h"
#import "QHNewsViewController.h"
#import "AwesomeDetailsViewController.h"
#import "GuidViewController.h"
#import "PromptView.h"
#import "LineChartView.h"

@interface HomeViewController ()
@property(nonatomic,strong) HomeView *homeView;
@property(nonatomic,strong) HomeViewModel *viewModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"奇获"];
    BOOL isLaunched = [[NSUserDefaults standardUserDefaults] objectForKey:FIRST_LAUNCHED];
    if (isLaunched == NO){
        [GuidViewController show];
    }else {
        [self checkNotificationSwitch];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 第二种办法：在隐藏导航栏的时候要添加动画
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.viewModel getUDPData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.udpSocket close];
    self.viewModel.udpSocket = nil;
    // 第二种办法：在显示导航栏的时候要添加动画
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.homeView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getContractListCommand execute:nil];
    [[self.viewModel.awesomeScrollClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(HomeScrollModel*  _Nullable model) {
        @strongify(self)
        if ([model.type intValue]==1) {
            AwesomeDetailsViewController *awesomeDetails = [[AwesomeDetailsViewController alloc] init];
            awesomeDetails.awesomeID = model.userId;
            [self.navigationController pushViewController:awesomeDetails animated:YES];
        }else{
            QHNewsViewController *news = [[QHNewsViewController alloc] init];
            news.url = model.link;
            [self.navigationController pushViewController:news animated:YES];
        }
    }];
    
    [[self.viewModel.tableCellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(HomeNewsModel*  _Nullable model) {
        QHNewsViewController *news = [[QHNewsViewController alloc] init];
        news.newsModel = model;
        [self.navigationController pushViewController:news animated:YES];
    }];
}
-(UIBarButtonItem *)leftButton {
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(HomeView *)homeView{
    if (!_homeView) {
        _homeView = [[HomeView alloc] initWithViewModel:self.viewModel];
    }
    return _homeView;
}

-(HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}

-(void)checkNotificationSwitch{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            NSLog(@"推送关闭");
            //跳转设置
//            PromptView * Pview = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"检测到APP系统通知被关闭，关闭系统通知将会错过重要的跟单信息。建议您开启接收通知" LeftBtnTitle:@"仍然关闭" RightBtnTitle:@"去设置"];
//            [Pview show];
//            Pview.goonBlock = ^{
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            };
            
        }else{
            NSLog(@"推送打开");
        }
    }
}
@end
