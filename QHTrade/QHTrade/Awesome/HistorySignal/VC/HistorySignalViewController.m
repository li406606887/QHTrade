//
//  HistorySignalViewController.m
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HistorySignalViewController.h"
#import "HistorySignalView.h"
#import "HistorySignalViewModel.h"
#import "ChooseDateView.h"

@interface HistorySignalViewController ()
@property(nonatomic,strong) HistorySignalView *signalView;
@property(nonatomic,strong) HistorySignalViewModel *viewModel;
@property(nonatomic,strong) ChooseDateView *chooseDate;
@end

@implementation HistorySignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"牛人历史信号"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.signalView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.signalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)setAwesomeID:(NSString *)awesomeID {
    self.viewModel.awesomeID = awesomeID;
}

-(UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btn setImage:[UIImage imageNamed:@"Awesome_History_Date"] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.chooseDate];
    }];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(HistorySignalView *)signalView {
    if (!_signalView) {
        _signalView = [[HistorySignalView alloc] initWithViewModel:self.viewModel];
    }
    return _signalView;
}

-(HistorySignalViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HistorySignalViewModel alloc] init];
    }
    return _viewModel;
}

-(ChooseDateView *)chooseDate {
    if (!_chooseDate) {
        _chooseDate = [[ChooseDateView alloc] initWithViewModel:self.viewModel];
        _chooseDate.frame = [UIScreen mainScreen].bounds;
    }
    return _chooseDate;
}
@end
