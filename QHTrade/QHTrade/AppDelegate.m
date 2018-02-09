//
//  AppDelegate.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/5/31.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInformation.h"
#import "PromptView.h"
#import <JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#define jpuchKey @"19a5035fd8f169b828a8a0c4"

#import <AlipaySDK/AlipaySDK.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "NavigationBaseController.h"
#import "PersonalViewController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:jpuchKey
                          channel:@"App Store"
                 apsForProduction:false
            advertisingIdentifier:nil];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
        [defult setObject:registrationID forKey:@"registrationID"];
    }];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //清除角标
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformSubTypeQQFriend),
                                        @(SSDKPlatformSubTypeWechatSession),
                                        @(SSDKPlatformSubTypeWechatTimeline),
//                                        @(SSDKPlatformTypeQQ),

                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;

             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx29df3972eb607580"
                                       appSecret:@"aaece1b05d5de5b49943247b5a36152e"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106483675"
                                      appKey:@"XHaQm5XmLT6QJdCN"
                                    authType:SSDKAuthTypeBoth];
                 break;

            default:
                   break;
                   }
                   }];
    [self getUserData];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.main;
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self.window makeKeyAndVisible];
    
    return YES;
}
//处理通知
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSString *title = [userInfo valueForKey:@"title"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];

    NotificationModel * model = [NotificationModel mj_objectWithKeyValues:extras];
    NSString *msg_type =[NSString stringWithFormat:@"%@",model.msgType];
    if ([msg_type intValue]==1) {
        [self outLogin:content title:title];
    }

    [JPUSHService setBadge:0];
}
-(void)outLogin:(NSString *)content title:(NSString *)title {
    
    PromptView * Pview = [[PromptView alloc]initWithTitleString:@"提示" SubTitleString:content];
    [Pview show];
    [[UserInformation getInformation] cleanUserInfo];
    Pview.goonBlock = ^{
        [self.main outLogin];
    };
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support 程序在前台
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NotificationModel * model = [NotificationModel mj_objectWithKeyValues:userInfo];
    NSString *msg_type =[NSString stringWithFormat:@"%@",model.msgType];

    if ([msg_type integerValue] == 2) {//通知消息

        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationCenter" object:model];
    }
    NSLog(@"pushtop---->%@",userInfo);
}

// iOS 10 Support 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }

//    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NotificationModel * model = [NotificationModel mj_objectWithKeyValues:userInfo];
    NSString *msg_type =[NSString stringWithFormat:@"%@",model.msgType];

    if ([msg_type integerValue] == 2) {//通知消息

        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationCenter" object:model];
    }
    
    completionHandler();  // 系统要求执行这个方法
    NSLog(@"pushdown---->%@",userInfo);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //清除角标
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark- aLiPay
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //清除角标
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    int index = (int)self.main.selectedIndex;
    if (index==3) {
        NavigationBaseController *nav = self.main.viewControllers[3];
        if (nav.childViewControllers.count==1) {
            PersonalViewController *person = nav.childViewControllers[0];
            [person viewWillAppear:YES];
        }
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)getUserData {
    id userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"];
    if (userData) {
        [UserInformation getInformation].userModel = [UserModel mj_objectWithKeyValues:userData];
    }
    //获取七牛token
    [UserInformation requestQiniuToken];
}

-(UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] init];
    }
    return _window;
}

-(TabBarBaseController *)main {
    if (!_main) {
        _main = [[TabBarBaseController alloc] init];
    }
    return _main;
}
@end
