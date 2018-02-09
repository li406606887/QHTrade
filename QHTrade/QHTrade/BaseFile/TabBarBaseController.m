//
//  TabBarBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TabBarBaseController.h"
#import "NavigationBaseController.h"
#import "DynamicsViewController.h"
#import "PersonalViewController.h"
#import "AwesomeViewController.h"
#import "HomeViewController.h"
#import "GroupViewController.h"
#import "QHTabBar.h"
#import "AwesomeSignalViewController.h"
#import "MessageViewController.h"
#import "PromptView.h"

@interface TabBarBaseController ()
@property(nonatomic,assign)int oldIndex;
@end

@implementation TabBarBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    [self setValue:[[QHTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSDictionary *attrs =@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(153, 153, 153),};

    
    NSDictionary *selectedAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(255, 98, 1)};
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    /*
     * 添加子导航栏控制器
     */
    [self setupChildVc:[[HomeViewController alloc] init] title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_select"];
    
    [self setupChildVc:[[AwesomeViewController alloc] init] title:@"牛人" image:@"tabbar_talent" selectedImage:@"tabbar_talent_select"];
    
    [self setupChildVc:[[GroupViewController alloc] init] title:@"圈子" image:@"tabbar_circle" selectedImage:@"tabbar_circle_select"];
    
//    [self setupChildVc:[[DynamicsViewController alloc] init] title:@"交易" image:@"tabbar_circle" selectedImage:@"tabbar_circle_select"];
 
    [self setupChildVc:[[PersonalViewController alloc] init] title:@"个人中心" image:@"tabbar_person" selectedImage:@"tabbar_person_select"];


    [self addNotification];
}


- (UINavigationController *)yq_navigationController {
    return self.selectedViewController;
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NavigationBaseController *nav = [[NavigationBaseController alloc] initWithRootViewController:vc];
    
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_image"] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    [nav.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(51, 51, 51),
                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                }];   
    [self addChildViewController:nav];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
-(void)outLogin{
    NavigationBaseController *nav = [self getCurrentVC];
    if(nav.childViewControllers.count>1){
        [nav popToRootViewControllerAnimated:NO];
    }
    self.selectedIndex = 0;
}
- (NavigationBaseController *)getCurrentVC
{
    NavigationBaseController *nav ;
    int index = (int)self.selectedIndex;
    nav = self.childViewControllers[index]; 
    return nav;
}
-(void)addNotification {
    WS(weakSelf)
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NotificationCenter" object:nil] subscribeNext:^(NSNotification *notification) {
        if (![notification.name isEqualToString:@"NotificationCenter"]) {
            return ;
        }
        NotificationModel *model = (NotificationModel*)notification.object;
        NavigationBaseController *vc = [weakSelf getCurrentVC];
        if ([model.skipType integerValue] == 1) {//内链
            if ([model.pageId integerValue] == 1) {//1消息列表
                PromptView * Pview = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"您有新的消息" LeftBtnTitle:@"取消" RightBtnTitle:@"查看"];
                [Pview show];
                Pview.goonBlock = ^{
                    MessageViewController * MVC = [[MessageViewController alloc]init];
                    [vc pushViewController:MVC animated:YES];
                };
                
            }else{//2牛人信号
                if ([[self getCurrentVC].childViewControllers.lastObject isKindOfClass:[AwesomeSignalViewController class]]) {//直接刷新
                    AwesomeSignalViewController * vc = [self getCurrentVC].childViewControllers.lastObject;
                    PromptView * pView = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"您有新的牛人信号" LeftBtnTitle:@"取消" RightBtnTitle:@"查看"];
                    [pView show];
                    pView.subTitle.font = [UIFont systemFontOfSize:18.0f];
                    pView.goonBlock = ^{
                       [vc.mainView.viewModel.refreshDataCommand execute:nil];
                    };
                    
                }else{
                    PromptView * pView = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"您有新的牛人信号" LeftBtnTitle:@"取消" RightBtnTitle:@"查看"];
                    [pView show];
                    pView.subTitle.font = [UIFont systemFontOfSize:18.0f];
                    pView.goonBlock = ^{
                        AwesomeSignalViewController * AVC = [[AwesomeSignalViewController alloc]init];
                        [vc pushViewController:AVC animated:YES];
                    };
                }
            }
        }else {//外链
            QHNewsViewController * NVC = [[QHNewsViewController alloc]init];
            NVC.url = model.outUrl;
            NVC.titleStr = @"通知消息";
            [vc pushViewController:NVC animated:YES];
        }
        
    }];

}

@end
