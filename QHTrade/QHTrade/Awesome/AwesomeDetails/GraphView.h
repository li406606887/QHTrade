//
//  GraphView.h
//  QHTrade
//
//  Created by user on 2017/12/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphView : UIView
@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (copy, nonatomic) NSString *titleY;
-(void)showGraphView;
@end
