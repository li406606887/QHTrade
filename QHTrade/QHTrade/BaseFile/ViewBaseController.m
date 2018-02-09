//
//  ViewBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import "LoginViewController.h"

@interface ViewBaseController ()<UIGestureRecognizerDelegate>
@end

@implementation ViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
    self.view.backgroundColor= DEFAULT_BG_COLOR;
   
    //右滑pop功能
    //1.获取系统interactivePopGestureRecognizer对象的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
    UIPanGestureRecognizer * pann = [[UIPanGestureRecognizer alloc]initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];//
    //3.设置代理
    pann.delegate = self;
    //4.添加到导航控制器的视图上
    [self.navigationController.view addGestureRecognizer:pann];
    //5.禁用系统的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //只有导航的根控制器不需要右滑的返回的功能。
    if (self.navigationController.viewControllers.count <= 1) return NO;
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



- (void) setUpNavigationBar
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.leftBarButtonItem = self.navigationController.childViewControllers.count==1? [self mainLeftButton] : [self leftButton];//设置导航栏左边按钮
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    self.navigationItem.titleView = [self centerView];//设置titel
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"navigaion_fanhui"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)rightButton {
    return nil;
}

- (UIBarButtonItem *)mainLeftButton {
    return nil;
}
- (UIView *)centerView {
    return nil;
}

- (void)actionOnTouchBackButton:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideTabbar:(BOOL)hidden {
    self.tabBarController.tabBar.hidden = hidden;//隐藏导航栏
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    ViewBaseController *vc = [super allocWithZone:zone];
    @weakify(vc);
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(vc)
        [vc addChildView];
        [vc bindViewModel];
    }];
    
    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        
    }];
    
    return vc;
}

-(void)addChildView {
    
}

-(void)bindViewModel {
    
}

@end
