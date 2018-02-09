//
//  NavigationBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NavigationBaseController.h"

@interface NavigationBaseController ()
@end

@implementation NavigationBaseController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES;
//        [viewController.navigationController.navigationBar setHidden:NO];
    }else if(self.childViewControllers.count==0){

//        self.navigationItem.rightBarButtonItem = self.messageItems;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

@end
