//
//  MBProgressHUD+NJ.m
//  NJWisdomCard
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 Weconex. All rights reserved.
//

#import "MBProgressHUD+NJ.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (NJ)
/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:[UIApplication sharedApplication].keyWindow];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:13];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
}



/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

//-(void)showSuccess:(NSString *)success
//{
//    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
//    HUD.contentColor=[UIColor whiteColor];
//    HUD.bezelView.color=[UIColor blackColor];
//    HUD.mode=MBProgressHUDModeText;
//    HUD.label.text=success;
//    HUD.removeFromSuperViewOnHide=YES;
//    [[self getView] addSubview:HUD];
//    [HUD showAnimated:YES];
//    [HUD hideAnimated:YES afterDelay:1];
//}
//-(UIView *)getView
//{
//    UIView *view;
//    if (self.navigationController.view) {
//        view=self.navigationController.view;
//    }else
//    {
//        view=self.view;
//    }
//    return view;
//}
/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示错误信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:[self getView]];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view  {
    if (view == nil) view = [UIApplication sharedApplication].windows[4];
    // 快速显示一个提示信息
    for (int i = 0;i<view.subviews.count;i++) {
        if ([view.subviews[i] isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *oldHud = view.subviews[i];
            [oldHud hideAnimated:YES];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.graceTime = 10.0f;
 
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:[self getView]];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
//    [self hideHUDForView:view animated:YES];
//    [self hideHUDForView:view animated:YES];
}
//-(void)showSuccess:(NSString *)success
//{
//    MBProgressHUD *HUD=[[MBProgressHUD alloc]initWithView:[self getView]];
//    HUD.contentColor=[UIColor whiteColor];
//    HUD.bezelView.color=[UIColor blackColor];
//    HUD.mode=MBProgressHUDModeText;
//    HUD.label.text=success;
//    HUD.removeFromSuperViewOnHide=YES;
//    [[self getView] addSubview:HUD];
//    [HUD showAnimated:YES];
//    [HUD hideAnimated:YES afterDelay:1];
//}
+(UIView *)getView
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    int index = (int) appDelegate.main.selectedIndex;
    UINavigationController *nav = appDelegate.main.childViewControllers[index];
    return nav.childViewControllers.lastObject.view;
}
@end