//
//  PieChartView.h
//  QHTrade
//
//  Created by user on 2017/12/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView
/**
 * 值数组
 */
@property(nonatomic,strong) NSArray *valueArray;
/**
 * 颜色数组
 */
@property(nonatomic,strong) NSMutableArray *colorArray;
/**
 * 半径
*/
@property (nonatomic, assign) CGFloat pieR;
/**
 * 环形的宽度
 */
@property (nonatomic, assign) CGFloat pieW;
/**
 * 饼分图的中心点
 */
@property (nonatomic, assign) CGPoint pieCenter;
/**
 * 标签数组
 */
@property(nonatomic,strong) NSArray *upTextItems;
-(void)showPieChartView;
@end
