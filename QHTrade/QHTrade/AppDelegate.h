//
//  AppDelegate.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/5/31.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarBaseController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)  TabBarBaseController *main;
@end

