//
//  UIButton+BackgroundColorExtension.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BackgroundColorExtension)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
