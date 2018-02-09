//
//  MessageViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageMainView.h"
#import "MessageViewModel.h"

@interface MessageViewController ()
@property (nonatomic,strong) MessageMainView * mainView;
@property (nonatomic,strong) MessageViewModel * viewModel;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    [self.view addSubview:self.mainView];
}

-(void)bindViewModel {

}

-(void)updateViewConstraints {
    @weakify(self)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

-(MessageMainView *)mainView {
    if (!_mainView) {
        _mainView = [[MessageMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
}
-(MessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageViewModel alloc]init];
    }
    return _viewModel;
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
