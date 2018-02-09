//
//  DynamicsView.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DynamicsView.h"
#import "DynamicsViewModel.h"
#import "OptionalContractViewController.h"
#import "MyContractViewController.h"
#import "OptionalContractViewController.h"
#import "MainContractViewController.h"
#import "SHFEViewController.h"
#import "DCEViewController.h"
#import "ZZCEViewController.h"
#import "CFFEXViewController.h"

#define kControllerCount 7;
#define kSegmentControlWidth  560
#define kSegmentControlSubViewWidth  560/7


@interface DynamicsView()<UIScrollViewDelegate>
/*
 * Dynamics 主控制器下滑动底层view
 */
@property(nonatomic,strong)UIScrollView *dynamicsScrollView;
/*
 * 主控制器的ViewModel
 */
@property(nonatomic,strong)DynamicsViewModel *viewModel;
/*
 * segmentedControl 页面切换按钮
 */
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
/*
 * scrollView 页面切换按钮的父视图
 */
@property(nonatomic,strong)UIScrollView *segmentedControlScrollView;
/*
 * scrollView 页面切换按钮的父视图
 */
@property(nonatomic,strong)NSArray *childViewArray;

@property(nonatomic,strong)MyContractViewController* myContractViewController;

@property(nonatomic,strong)OptionalContractViewController* optionalContractViewController;

@property(nonatomic,strong)MainContractViewController* mainContractViewController;

@property(nonatomic,strong)SHFEViewController* shfeViewController;

@property(nonatomic,strong)DCEViewController* dceViewController;

@property(nonatomic,strong)ZZCEViewController* zzceViewController;

@property(nonatomic,strong)CFFEXViewController* cffexViewController;
@end


@implementation DynamicsView

/*
 * 绑定ViewModel(将当前View下的ViewModel指针指向主控制器的ViewModel)
 */
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (DynamicsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
/*
 * 添加子视图
 */
-(void)setupViews{
    [self addSubview:self.segmentedControlScrollView];
    [self.segmentedControlScrollView addSubview:self.segmentedControl];
    [self addSubview:self.dynamicsScrollView];
    [self.dynamicsScrollView addSubview:self.myContractViewController.view];
    [self.dynamicsScrollView addSubview:self.optionalContractViewController.view];
    [self.dynamicsScrollView addSubview:self.mainContractViewController.view];
    [self.dynamicsScrollView addSubview:self.shfeViewController.view];
    [self.dynamicsScrollView addSubview:self.dceViewController.view];
    [self.dynamicsScrollView addSubview:self.zzceViewController.view];
    [self.dynamicsScrollView addSubview:self.cffexViewController.view];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
/*
 * 更新约束
 */
-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.segmentedControlScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.topMargin.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 26));
    }];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.leftMargin.equalTo(self.segmentedControlScrollView);
        make.topMargin.equalTo(self.segmentedControlScrollView);
        make.size.mas_offset(CGSizeMake(kSegmentControlWidth, 26));
    }];
    [self.dynamicsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.myContractViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.dynamicsScrollView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.optionalContractViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.myContractViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.mainContractViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.optionalContractViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.shfeViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.mainContractViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.dceViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.shfeViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.zzceViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.dceViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    [self.cffexViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.dynamicsScrollView);
        make.left.equalTo(self.zzceViewController.view.mas_right);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-134));
    }];
    NSLog(@"%f",SCREEN_HEIGHT-134);
}


#pragma mark segmentedControl 滚动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==10002){
        int width = (int)SCREEN_WIDTH;
        double index = scrollView.mj_offsetX / width;
        int zero = (int)scrollView.mj_offsetX % width;
        if (zero == 0) {
            [self changeSegmentedControlScrollViewIndex:index];
        }
    }else{
        NSLog(@"1123");
    }
}
#pragma mark collectionView 滚动方法
-(void)segmentedChanged:(UISegmentedControl*)segmentedControl{

    [self.dynamicsScrollView setContentOffset:CGPointMake(segmentedControl.selectedSegmentIndex * SCREEN_WIDTH, 0.1) animated:YES];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
 * dynamicsCollectionView的get方法(懒加载)
 */
-(UIScrollView *)dynamicsScrollView{
    if (!_dynamicsScrollView) {
        _dynamicsScrollView = [[UIScrollView alloc] init];
        _dynamicsScrollView.delegate = self;
        _dynamicsScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*7, 0.1);
        _dynamicsScrollView.pagingEnabled = YES;
        _dynamicsScrollView.tag = 10002;
    }
    return _dynamicsScrollView;
}

-(void)changeSegmentedControlScrollViewIndex:(int)index{
    self.segmentedControl.selectedSegmentIndex = index;
    
    if(index*kSegmentControlSubViewWidth-SCREEN_WIDTH*0.4+SCREEN_WIDTH > kSegmentControlWidth){
        [self.segmentedControlScrollView setContentOffset:CGPointMake(kSegmentControlWidth-SCREEN_WIDTH, 0.1) animated:YES];
    }else if(index*kSegmentControlSubViewWidth-SCREEN_WIDTH*0.4<0){
        [self.segmentedControlScrollView setContentOffset:CGPointMake(0, 0.1) animated:YES];
    }else{
        [self.segmentedControlScrollView setContentOffset:CGPointMake(index*kSegmentControlSubViewWidth-SCREEN_WIDTH*0.4, 0.1) animated:YES];
    }
}
-(UIScrollView *)segmentedControlScrollView{
    if (!_segmentedControlScrollView) {
        _segmentedControlScrollView = [[UIScrollView alloc] init];
        _segmentedControlScrollView.contentSize = CGSizeMake(kSegmentControlWidth, 0);
        _segmentedControlScrollView.showsVerticalScrollIndicator = NO;
        _segmentedControlScrollView.delegate = self;
        _segmentedControlScrollView.tag = 10001;
        for (int i = 0; i<6; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((i+1)*80, 4, 1, 18)];
            [line setBackgroundColor:RGB(229, 229, 229)];
            [_segmentedControlScrollView addSubview:line];
        }
    }
    return _segmentedControlScrollView;
}
-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"我的合约",@"自选合约",@"主力合约",@"上期所",@"大商所",@"郑商所",@"中金所", nil]];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = RGB(234, 235, 236);
        _segmentedControl.tintColor = [UIColor clearColor];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(125, 126, 127),
                                                    NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                         forState:UIControlStateNormal];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(190, 155, 95),
                                                    NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                         forState:UIControlStateSelected];
        [_segmentedControl addTarget:self action:@selector(segmentedChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}
-(MyContractViewController *)myContractViewController{
    if (!_myContractViewController) {
        _myContractViewController = [[MyContractViewController alloc] init];
    }
    return _myContractViewController;
}

-(OptionalContractViewController *)optionalContractViewController{
    if (!_optionalContractViewController) {
        _optionalContractViewController = [[OptionalContractViewController alloc] init];
        
    }
    return _optionalContractViewController;
}
-(MainContractViewController *)mainContractViewController{
    if (!_mainContractViewController) {
        _mainContractViewController = [[MainContractViewController alloc] init];
    }
    return _mainContractViewController;
}
-(SHFEViewController *)shfeViewController{
    if (!_shfeViewController) {
        _shfeViewController = [[SHFEViewController alloc] init];
    }
    return _shfeViewController;
}
-(DCEViewController *)dceViewController{
    if (!_dceViewController) {
        _dceViewController = [[DCEViewController alloc] init];
    }
    return _dceViewController;
}
-(ZZCEViewController *)zzceViewController{
    if (!_zzceViewController) {
        _zzceViewController = [[ZZCEViewController alloc] init];
    }
    return _zzceViewController;
}
-(CFFEXViewController *)cffexViewController{
    if (!_cffexViewController) {
        _cffexViewController = [[CFFEXViewController alloc] init];
    }
    return _cffexViewController;
}
@end
