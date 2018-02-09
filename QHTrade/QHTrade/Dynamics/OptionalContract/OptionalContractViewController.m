//
//  OptionalContractViewController.m
//  QHTrade
//
//  Created by user on 2017/6/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "OptionalContractViewController.h"
#import "OptionalContractView.h"
#import "OptionalContractViewModel.h"


#define kViewHeight SCREEN_HEIGHT-134

@interface OptionalContractViewController ()
@property(nonatomic,strong)OptionalContractView *optionalContractView;
@property(nonatomic,strong)OptionalContractViewModel *optionalContractViewModel;
@end

@implementation OptionalContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, kViewHeight);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)addChildView{
    
    [self.view addSubview:self.optionalContractView];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.optionalContractView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view);
//        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH,kViewHeight));
        make.edges.equalTo(self.view);
    }];
    NSLog(@"%f",self.view.frame.size.height);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(OptionalContractView *)optionalContractView{
    if (!_optionalContractView) {
        _optionalContractView = [[OptionalContractView alloc] initWithViewModel:self.optionalContractViewModel];
    }
    return _optionalContractView;
}
-(OptionalContractViewModel *)optionalContractViewModel{
    if (!_optionalContractViewModel) {
        _optionalContractViewModel = [[OptionalContractViewModel alloc] init];
    }
    return _optionalContractViewModel;
}
@end
