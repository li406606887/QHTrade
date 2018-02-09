//
//  YAxisView.m
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "YAxisView.h"

#define xAxisTextGap 5 //x轴文字与坐标轴间隙
#define numberOfYAxisElements 5 // y轴分为几段
#define kChartLineColor         [UIColor blackColor]
#define kChartTextColor         [UIColor blackColor]


@interface YAxisView ()

@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (copy  , nonatomic) NSString* titleY;
@end

@implementation YAxisView

- (id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.yMax = yMax;
        self.yMin = yMin;
        self.titleY = title;
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 计算坐标轴的位置以及大小
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    
    CGSize labelSize = [@"x" sizeWithAttributes:attr];
    
    [self drawLine:context startPoint:CGPointMake(self.frame.size.width-10, 0)
          endPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height - labelSize.height - xAxisTextGap)
         lineColor:[UIColor grayColor]
         lineWidth:1];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentLeft];
    NSDictionary *styleDic = @{NSParagraphStyleAttributeName:style,NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor};
    
    NSDictionary *waterAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    CGSize waterLabelSize = [self.titleY sizeWithAttributes:waterAttr];
    CGRect waterRect = CGRectMake(0, 0,self.frame.size.width,waterLabelSize.height);
    [self.titleY drawInRect:waterRect withAttributes:styleDic];
    
    // Label做占据的高度
    CGFloat allLabelHeight = self.frame.size.height - xAxisTextGap - labelSize.height;
    // Label之间的间隙
    CGFloat labelMargin = (allLabelHeight + labelSize.height - (numberOfYAxisElements + 1) * labelSize.height) / numberOfYAxisElements;
   
    // 添加Label
    for (int i = 0; i < numberOfYAxisElements + 1; i++) {
        CGFloat avgValue = (self.yMax - self.yMin) / numberOfYAxisElements;
        // 判断是不是小数
        if ([self isPureFloat:self.yMin + avgValue * i]) {
            if (avgValue>0.05) {
                CGSize yLabelSize = [[NSString stringWithFormat:@"%.2f", self.yMin + avgValue * i] sizeWithAttributes:waterAttr];
                [[NSString stringWithFormat:@"%.2f", self.yMin + avgValue * i] drawInRect:CGRectMake(0, self.frame.size.height - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, self.frame.size.width, yLabelSize.height) withAttributes:styleDic];
            }else {
                CGSize yLabelSize = [[NSString stringWithFormat:@"%.4f", self.yMin + avgValue * i] sizeWithAttributes:waterAttr];
                [[NSString stringWithFormat:@"%.4f", self.yMin + avgValue * i] drawInRect:CGRectMake(0, self.frame.size.height - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, self.frame.size.width, yLabelSize.height) withAttributes:styleDic];
            }
        }else {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] sizeWithAttributes:waterAttr];
            [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] drawInRect:CGRectMake(0, self.frame.size.height - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, self.frame.size.width, yLabelSize.height) withAttributes:styleDic];
        }
    }
}
// 判断是小数还是整数
- (BOOL)isPureFloat:(CGFloat)num {
    int i = num;
    CGFloat result = num - i;
    // 当不等于0时，是小数
    return result != 0;
}

- (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width {
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}
@end
