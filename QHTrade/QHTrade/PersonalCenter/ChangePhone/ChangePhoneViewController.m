//
//  ChangePhoneViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "ChangePhoneMainView.h"
#import "ChangePhoneViewModel.h"
#import "ChangeNextViewController.h"

@interface ChangePhoneViewController ()
@property (nonatomic,strong)ChangePhoneMainView * mainView;
@property(nonatomic,strong)ChangePhoneViewModel *viewModel;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
    self.title =@"更换手机号";
    
}
-(void)updateViewConstraints{

    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
-(void)bindViewModel{
    @weakify(self);
    
    [self.mainView.codeTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        //长度逻辑判断
        NSLog(@"code=%@",x);
        static NSInteger const maxIntegerlength = 6;
        if (x.length) {
            if (x.length < 6) {
                self.mainView.commitButton.userInteractionEnabled = NO;
            }else{
                self.mainView.commitButton.userInteractionEnabled = YES;
            }
            if (x.length > 6) {
                @strongify(self);
                self.mainView.codeTextfield.text = [self.mainView.codeTextfield.text substringToIndex:maxIntegerlength];
            }
        }
    }];
    
    [self.mainView.passWordTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        
        NSLog(@"password=%@",x);
       
        if (x.length) {
            
            if (x.length < 6) {
                self.mainView.commitButton.userInteractionEnabled = NO;
            }else{
                self.mainView.commitButton.userInteractionEnabled = YES;
            }
            
        }
    }];

    
    [[self.viewModel.commitBtnClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        ChangeNextViewController * CVC = [[ChangeNextViewController alloc]init];
        [self.navigationController pushViewController:CVC animated:YES];
        
    }];
}
-(ChangePhoneViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[ChangePhoneViewModel alloc]init];
        
    }
    return _viewModel;
}
-(ChangePhoneMainView *)mainView{

    if (!_mainView) {
        _mainView = [[ChangePhoneMainView alloc]initWithViewModel:self.viewModel];
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
