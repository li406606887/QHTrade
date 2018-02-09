//
//  CFFEXViewController.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "CFFEXViewController.h"
#import "CFFEXView.h"
#import "CFFEXViewModel.h"


@interface CFFEXViewController ()

@property(nonatomic,strong)CFFEXView *cffexView;
@property(nonatomic,strong)CFFEXViewModel *cffexViewModel;
@end

@implementation CFFEXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)addChildView{
    [self.view addSubview:self.cffexView];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.cffexView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
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
-(CFFEXView *)cffexView{
    if (!_cffexView) {
        _cffexView = [[CFFEXView alloc] initWithViewModel:self.cffexViewModel];
    }
    return _cffexView;
}

-(CFFEXViewModel *)cffexViewModel{
    if (!_cffexViewModel) {
        _cffexViewModel = [[CFFEXViewModel alloc] init];
    }
    return _cffexViewModel;
}



@end
