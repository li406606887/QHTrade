//
//  TradeAccountViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeAccountViewController.h"
#import "TradeAccountMainView.h"
#import "TradeAccountViewModel.h"
#import "ChooseCompanyViewController.h"
#import "QHPDFViewViewController.h"
#import "ChooseCompanyModel.h"
#import "ChooseSexView.h"
#import "ChooseCompanyView.h"

@interface TradeAccountViewController ()
@property (nonatomic,strong) TradeAccountMainView * mainView;
@property (nonatomic,strong) TradeAccountViewModel * viewModel;
@property (nonatomic,assign) BOOL isAgree;//同意声明
@property (nonatomic,strong) NSString *brokerId;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation TradeAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];
    self.title = @"交易账户绑定";

    self.isAgree = self.viewModel.isAgree =YES;
    self.viewModel.brokerId = self.brokerId;
}

-(void)bindViewModel {
    @weakify(self)
    
    RAC(self.viewModel, accountNumStr) = self.mainView.accountTextfield.rac_textSignal;
    RAC(self.viewModel, passWordStr) = self.mainView.passWordTextfield.rac_textSignal;
    
    [self.mainView.accountTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        NSLog(@"x==%@ textfield=%@",x,self.mainView.accountTextfield.text);
        static NSInteger const maxIntegerlength = 20;
        if (x.length) {
            if (x.length > 20) {
                @strongify(self);
                self.mainView.accountTextfield.text = [self.mainView.accountTextfield.text substringToIndex:maxIntegerlength];
            }
        }
    }];
    
    [self.mainView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        NSLog(@"x==%@ passwordtextfield=%@",x,self.mainView.passWordTextfield.text);
    }];
    
    self.mainView.loginButton.rac_command = self.viewModel.loginCommand;
    
    RAC(self.mainView.loginButton,backgroundColor) = [self.viewModel.loginBtnEnable map:^id _Nullable(NSNumber * value) {
        return [value boolValue] ? [UIColor whiteColor] : [UIColor whiteColor];
    }];
    
    [self.viewModel.loginBtnEnable subscribeNext:^(NSNumber * x) {
        @strongify(self);
        NSLog(@"ceshi---+++=%@",([x boolValue] && self.isAgree) ? @"1":@"2");
        self.mainView.loginButton.enabled = ([x boolValue]);
    }];
    
    [[self.viewModel.loginCommand executionSignals] subscribeNext:^(id  _Nullable x) {
        
        [x subscribeNext:^(QHRequestModel * model) {
            
            if ([model.status intValue] == 200) {
                
                NSLog(@"绑定成功返回%@",model.content);
                showMassage(@"绑定成功");
               

                [self.navigationController popViewControllerAnimated:YES];
                
            }else showMassage(model.message)
                
        }];
    }];

    
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray *  _Nullable x) {
        @strongify(self);
        
        NSLog(@"开户公司=%@",x);
        NSMutableArray * company = [NSMutableArray array];
        for (NSDictionary *dic in x) {
            ChooseCompanyModel *model = [ChooseCompanyModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:model];
            [company addObject:[NSString stringWithFormat:@"%@",model.name]];
        }
        
        [self chooseCompanyWithTitleArray:company ModelArray:self.dataArray];
        
    }];

    
    //选择开户公司 点击
    [[self.viewModel.searchSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//        ChooseCompanyViewController * CVC = [[ChooseCompanyViewController alloc]init];
//        CVC.callBackBlock = ^(NSString *str) {
//            self.mainView.companyTextfield.text = [str componentsSeparatedByString:@"i"][0];
//            self.viewModel.brokerId = [str subStringFrom:@"id=" to:@"z"];
//        };
//        [self.navigationController pushViewController:CVC animated:YES];
    }];
    
    [[self.viewModel.statementSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        QHPDFViewViewController * QVC = [[QHPDFViewViewController alloc]init];
        [self.navigationController pushViewController:QVC animated:YES];
    }];
    
    [[self.viewModel.tickClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {
        self.isAgree = [x isEqualToString:@"1"];
        self.viewModel.isAgree = self.isAgree;
        self.mainView.loginButton.enabled = self.isAgree;
    }];
}
#pragma mark -- 弹窗
-(void)chooseCompanyWithTitleArray:(NSArray *)array ModelArray:(NSArray *)modelArray{
    ChooseCompanyView * cView = [[ChooseCompanyView alloc]initWithTitleArray:array ModelArray:modelArray];
    NSArray * point;
    if ([self.mainView.companyLabel.text isEqualToString:@"模拟账户"]) {
        point = @[@"0",@"1"];
    }else point = @[@"1",@"0"];
    cView.pointArray = point;
    [cView show];
    __weak typeof (self) weakSelf = self;
    cView.goonBlock = ^(ChooseCompanyModel *model) {
        weakSelf.viewModel.brokerId = model.code;
        weakSelf.mainView.companyLabel.text = model.name;
    };
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)updateViewConstraints {
    [super updateViewConstraints];
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(TradeAccountViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TradeAccountViewModel alloc]init];
    }
    return _viewModel;
}

-(TradeAccountMainView *)mainView {
    if (!_mainView) {
        _mainView = [[TradeAccountMainView alloc]initWithViewModel:self.viewModel];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
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

@end
