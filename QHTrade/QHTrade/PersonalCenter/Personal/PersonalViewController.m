//
//  PersonalViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalMainView.h"
#import "PersonalViewModel.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "PromptView.h"
#import "SettingViewController.h"
#import "PersonalMasterView.h"
#import "TradeStatisticViewController.h"
#import "DiamondViewController.h"
#import "TradeAccountViewController.h"
#import "MyPositionsViewController.h"
#import "DataReportViewController.h"
#import "AwesomeSignalViewController.h"
#import "TradeManageViewController.h"
//#import "PersonalModel.h"
#import "UserModel.h"
#import "MessageViewController.h"

@interface PersonalViewController ()
@property (nonatomic,strong)PersonalMainView * mainView;
@property (nonatomic,strong)PersonalViewModel * viewModel;
@property (nonatomic,strong)PersonalMasterView * masterView;
@property (nonatomic,strong)UserModel * model;
@property (nonatomic,strong)UserModel * nilModel;
@property (nonatomic,strong)NSString * tcpState;//tcp登录状态
@property (nonatomic,strong)NSArray * totalIncomeArray;//
@property(nonatomic,assign) BOOL loginState;
@property(nonatomic,strong) UIBarButtonItem * messageItems;
@end

@implementation PersonalViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[UserInformation getInformation] getLoginState] != self.loginState) {
        if ([[UserInformation getInformation] getLoginState]) {
            //请求收益曲线
            [self.viewModel.totalIncomeCommand execute:nil];
        }
        self.loginState = [[UserInformation getInformation] getLoginState];
    }
    
    if (![[UserInformation getInformation] getLoginState]) {
        //未登录
        [self.viewModel.tradeAccountIsLogin sendNext:@"0"];//显示top视图
        [self refreshUIWithModel:nil];//退出登录后刷新视图
        self.totalIncomeArray = nil;
        if (self.totalIncomeArray.count < 1) {
            self.masterView.tableFootView.nilLabel.hidden = NO;
        }else self.masterView.tableFootView.nilLabel.hidden = YES;
        [self updateTotalIncome];
    }else{
        [self.viewModel.userInfoCommand execute:nil];
    }
    [self.viewModel.refreshUI sendNext:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.masterView];
    
}
//左按钮
-(UIBarButtonItem *)mainLeftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"white_setting"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(settingBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)updateViewConstraints {
    WS(weakSelf)
    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}


-(void)bindViewModel {
    WS(weakSelf)
    [[self.viewModel.middleCellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {
        if (![[UserInformation getInformation] getLoginState]) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        switch ([x integerValue]) {
            case 1:{//跟单管理
                TradeManageViewController * TVC = [[TradeManageViewController alloc]init];
                [self.navigationController pushViewController:TVC animated:YES];
            }
                break;
            case 2: {//牛人信号
                AwesomeSignalViewController * AVC = [[AwesomeSignalViewController alloc]init];
                [self.navigationController pushViewController:AVC animated:YES];
            }
                break;
            case 3:
            {
                switch ([[UserInformation getInformation].userModel.state integerValue]) {
                    case 1: {
                        showMassage(@"未绑定交易账号");
                    }
                        break;
                    case 2: {
                        showMassage(@"交易账号未登录");
                    }
                        break;
                    case 3: {
                        TradeStatisticViewController * TVC = [[TradeStatisticViewController alloc]init];
                        [weakSelf.navigationController pushViewController:TVC animated:YES];
                    }
                        break;
                    case 4: {
                        TradeStatisticViewController * TVC = [[TradeStatisticViewController alloc]init];
                        [weakSelf.navigationController pushViewController:TVC animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
            case 4:
            {
                DataReportViewController * DVC = [[DataReportViewController alloc]init];
                [weakSelf.navigationController pushViewController:DVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    
    [[self.viewModel.setBtnClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if (![[UserInformation getInformation] getLoginState]) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        SettingViewController * SVC = [[SettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:SVC animated:YES];
    }];
    
    [[self.viewModel.headImgClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if (![[UserInformation getInformation] getLoginState]) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        SettingViewController * SVC = [[SettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:SVC animated:YES];
    }];
    //钻石点击
    [[self.viewModel.diamondBtnClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if (![[UserInformation getInformation] getLoginState]) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        DiamondViewController * DVC = [[DiamondViewController alloc]init];
        [weakSelf.navigationController pushViewController:DVC animated:YES];
    }];
    
    //登录交易账户
    [[self.viewModel.tradeAccountLoginBtnClick  takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if ([[UserInformation getInformation] getLoginState]==NO) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        switch ([x intValue]) {
            case 1: {//1未登录
                LoginViewController * LVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:LVC animated:YES];
            }
                break;
            case 2: {//绑定交易账号
                TradeAccountViewController * TVC = [[TradeAccountViewController alloc]init];
                [weakSelf.navigationController pushViewController:TVC animated:YES];
            }
                break;
            case 3: {//去跟单
                self.tabBarController.selectedIndex = 1;
            }
                break;
            default:
                break;
        }
        
        
    }];
    //tcp
    [[[self.viewModel.tcpAccountCommand executionSignals] switchToLatest] subscribeNext:^(NSString * x) {
        if ([x isEqualToString:@"200"]) {//交易账户登录成功
            showMassage(@"交易账户登录成功")
        }
    }];
    
    //持仓
    [[self.viewModel.positionsClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        if (![[UserInformation getInformation] getLoginState]) {
            LoginViewController * LVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            return;
        }
        MyPositionsViewController * MVC = [[MyPositionsViewController alloc]init];
        [weakSelf.navigationController pushViewController:MVC animated:YES];
    }];
    //刷新UI信号
    [[self.viewModel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(UserModel  *model) {
        NSLog(@"user=%@",model);
        //更新UI
        weakSelf.model = model;
        [weakSelf refreshUIWithModel:model];
    }];
    
    //总收益曲线数据
    [[[self.viewModel.totalIncomeCommand executionSignals] switchToLatest] subscribeNext:^(NSArray * x) {
        if ([x isEqualToArray:weakSelf.totalIncomeArray]) {
            return;
        }
        weakSelf.totalIncomeArray = x;
        NSLog(@"118返回=%@",x);
        if (x.count == 0) {
            weakSelf.masterView.tableFootView.nilLabel.hidden = NO;
            return;
        }else weakSelf.masterView.tableFootView.nilLabel.hidden = YES;
        
        [weakSelf updateTotalIncome];
        
    }];
}
-(void)updateTotalIncome {
    if (self.totalIncomeArray == nil) {
        [self.masterView.tableFootView.lineChartView removeFromSuperview];
        self.masterView.tableFootView.lineChartView = nil;
        return;
    }
    [self.masterView.tableFootView.lineChartView removeFromSuperview];
    self.masterView.tableFootView.lineChartView = nil;
    [self.masterView.tableFootView addSubview:self.masterView.tableFootView.lineChartView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *dataY = [NSMutableArray array];//数据源
        NSMutableArray *dataX = [NSMutableArray array];//数据源
        for (NSDictionary *dic in self.totalIncomeArray) {
            [dataY addObject:[NSString stringWithFormat:@"%.2f",[dic[@"value"] floatValue]]];
            NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
            [dataX addObject:[str substringFromIndex:5]];//时间
            
        }
        NSNumber *maxNum = [dataY valueForKeyPath:@"@max.floatValue"];
        
        NSNumber *minNum = [dataY valueForKeyPath:@"@min.floatValue"];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 按顺序执行
            [self.masterView.tableFootView.lineChartView setYValueArray:dataY];
            [self.masterView.tableFootView.lineChartView setXTitleArray:dataX];
            [self.masterView.tableFootView.lineChartView setYMax:[maxNum floatValue]];
            [self.masterView.tableFootView.lineChartView setYMin:[minNum floatValue]];
            [self.masterView.tableFootView.lineChartView setTitleY:@""];
            [self.masterView.tableFootView.lineChartView showGraphView];
        });
        
    });
}
//更新
-(void)refreshUIWithModel:(UserModel *)model {
    if (model == nil) {
//        self.masterView.topViewLabel.text = @"未绑定交易账号";
//        [self.masterView.topLogButton setTitle:@"绑定交易账号" forState:UIControlStateNormal];
    }
    model == nil ? model = self.nilModel : model;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]];
    [self.masterView.tableSectionView.headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
    if (self.totalIncomeArray.count < 1) {
        self.masterView.tableFootView.nilLabel.hidden = NO;
    }else self.masterView.tableFootView.nilLabel.hidden = YES;
    self.masterView.tableSectionView.nickNameLabel.text = model.userName;
    [self.masterView.tableSectionView.diamondButton setTitle:model.diamond forState:UIControlStateNormal];
    if ([model.gender isEqualToString:@"1"]) {//性别
        self.masterView.tableSectionView.sexImgView.image = [UIImage imageNamed:@"personal_man_icon"];
    }else if ([model.gender isEqualToString:@"2"]){
        self.masterView.tableSectionView.sexImgView.image = [UIImage imageNamed:@"personal_woman_icon"];
    }else self.masterView.tableSectionView.sexImgView.image = [UIImage imageNamed:@"personal_man_icon"];
    
    NSArray * data = @[[NSString stringWithFormat:@"%.2f%%",[model.incomeRate doubleValue]*100],
                       [NSString stringWithFormat:@"%@",model.balance],
                       [NSString stringWithFormat:@"%@",model.totalIncome],
                       [NSString stringWithFormat:@"%.2f%%",[model.positionRate doubleValue]*100],
                       [NSString stringWithFormat:@"%@",model.positionCount]];
    
    self.masterView.dataArray = data;
    [self.masterView.tableView reloadData];
    self.tcpState = model.state;
    //状态 1未绑定交易账号 2未登录 3已登录 4不显示登录提示
//    switch ([model.state integerValue]) {
//        case 1:
//        {
//            self.masterView.topViewLabel.text = @"未绑定交易账号";
//            [self.masterView.topLogButton setTitle:@"绑定交易账号" forState:UIControlStateNormal];
//            [self.viewModel.tradeAccountIsLogin sendNext:@"0"];//显示top视图
//        }
//            break;
//        case 2:
//        {
//            self.masterView.topViewLabel.text = @"未登录";
//            [self.masterView.topLogButton setTitle:@"登录并跟单" forState:UIControlStateNormal];
//            [self.viewModel.tradeAccountIsLogin sendNext:@"0"];//显示top视图
//        }
//            break;
//        case 3:
//        {
//            self.masterView.topViewLabel.text = @"已登录";
//            [self.masterView.topLogButton setTitle:@"已登录" forState:UIControlStateNormal];
//            [self.viewModel.tradeAccountIsLogin sendNext:@"1"];//不显示top视图
//        }
//            break;
//        case 4:
//        {
//            [self.masterView.topLogButton setTitle:@"hidden" forState:UIControlStateNormal];
//            [self.viewModel.tradeAccountIsLogin sendNext:@"1"];//不显示top视图
//        }
//            break;
//
//        default:
//            break;
//    }
    
    if ([model.brokerId isEqualToString:@"9999"] || [model.isAccount isEqualToString:@"1"]) {//模拟账户 或者 未点击过开户
        self.masterView.tableSectionView.openAccountBtn.hidden = NO;
    }else {
        self.masterView.tableSectionView.openAccountBtn.hidden = YES;
    }
}

-(void)settingBtnClick:(id)sender {
    if (![[UserInformation getInformation] getLoginState]) {
        LoginViewController * LVC = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:LVC animated:YES];
        return;
    }
    SettingViewController * SVC = [[SettingViewController alloc]init];
    SVC.model = self.model;
    [self.navigationController pushViewController:SVC animated:YES];
}
-(UserModel *)nilModel {
    if (!_nilModel) {
        _nilModel = [[UserModel alloc]init];
        _nilModel.userName = @"未登录";
        _nilModel.diamond = @"未登录";
        _nilModel.gender = @"";
        _nilModel.incomeRate = @"--";
        _nilModel.balance = @"--";
        _nilModel.totalIncome = @"--";
        _nilModel.positionRate = @"--";
        _nilModel.positionCount = @"--";
        _nilModel.userImg = @"touxiang_icon";
        _nilModel.state = @"";
        self.totalIncomeArray = nil;
    }
    return _nilModel;
}
-(PersonalMasterView *)masterView {
    if (!_masterView) {
        _masterView = [[PersonalMasterView alloc]initWithViewModel:self.viewModel];
    }
    return _masterView;
}

-(PersonalViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PersonalViewModel alloc]init];
    }
    return _viewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)messageBtnClick:(UIButton *)sender {
    if (![[UserInformation getInformation] getLoginState]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    MessageViewController * MVC = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:MVC animated:YES];
}

-(UIBarButtonItem *)messageItems {
    if (!_messageItems) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"message_icon"] forState:UIControlStateSelected];
        btn.frame = CGRectMake(0, 0, 20, 20);
        [btn addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _messageItems = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _messageItems;
}
-(UIBarButtonItem *)rightButton {
    return self.messageItems;
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
