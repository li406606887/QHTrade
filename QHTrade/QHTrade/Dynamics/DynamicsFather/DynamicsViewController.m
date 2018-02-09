//
//  DynamicsViewController.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DynamicsViewController.h"
#import "DynamicsViewModel.h"
#import "DynamicsView.h"
#import "DynamicsNavigationCenterView.h"

@interface DynamicsViewController ()
@property(nonatomic,strong)DynamicsView *dynamicsView;
@property(nonatomic,strong)DynamicsNavigationCenterView *navigationCenterView;
@property(nonatomic,strong)DynamicsViewModel *dynamicsViewModel;
@end

@implementation DynamicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
/*
 *添加子控视图
 **/
-(void)addChildView{
    [self.view addSubview:self.dynamicsView];
}

-(void)bindViewModel{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    @weakify(self)
    [self.dynamicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    [self.navigationCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-80, 34));
    }];
    
}
-(UIBarButtonItem *)leftButton{
    return nil;
}
-(UIView *)centerView{
    return self.navigationCenterView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(DynamicsView *)dynamicsView{
    if (!_dynamicsView) {
        _dynamicsView = [[DynamicsView alloc] initWithViewModel:self.dynamicsViewModel];
    }
    return _dynamicsView;
}
-(DynamicsViewModel *)dynamicsViewModel{
    if (!_dynamicsViewModel) {
        _dynamicsViewModel = [[DynamicsViewModel alloc] init];
    }
    return _dynamicsViewModel;
}
-(DynamicsNavigationCenterView*)navigationCenterView{
    if (!_navigationCenterView) {
        _navigationCenterView = [[DynamicsNavigationCenterView alloc] initWithViewModel:self.dynamicsViewModel];
        _navigationCenterView.layer.masksToBounds = YES;
        _navigationCenterView.layer.cornerRadius = 17;
    }
    return _navigationCenterView;
}
@end
