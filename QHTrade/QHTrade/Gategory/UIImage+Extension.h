//
//  UIImage+Extension.h
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName orginX:(CGFloat)x orginY:(CGFloat)y;

+(UIImage*)createImageWithColor:(UIColor*) color;


@end
