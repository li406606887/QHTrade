//
//  PieChartView.m
//  QHTrade
//
//  Created by user on 2017/12/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PieChartView.h"

#define AnimationTime  1         //动画时间

@interface PieChartView ()
@end

@implementation PieChartView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // 数组求和
    CGFloat max = [[self.valueArray valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat startAngle = -M_PI_2;
    for (int i = 0; i < self.valueArray.count; i++) {
        // 扇形部分
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [self.colorArray[i] CGColor];
        layer.lineWidth = self.pieW;
        [self.layer addSublayer:layer];
        
        CGFloat endAngle = [self.valueArray[i] floatValue]/max * (2*M_PI) + startAngle;
        UIBezierPath *layerPath = [UIBezierPath bezierPathWithArcCenter:self.pieCenter radius:self.pieR startAngle:startAngle endAngle:endAngle clockwise:YES];
        layer.path = layerPath.CGPath;
        
        // 小圆点数据
        CGPoint minPieCenter;// 小圆点中心
        CGFloat picOutR = self.pieR + self.pieW/2.0 + 10;// 外层半径
        CGFloat middleAngle = startAngle + (endAngle - startAngle)/2.0;// 扇形中间点角度
        // 折线数据
        CGPoint line_1_Point;// 转折点
        CGPoint line_2_Point;// 终点
        CGFloat line_1_W = 10;// 1线宽
        CGFloat lineSpace = 15;// 终点距两边的距离
        CGFloat lineAngle = M_PI_2/2;// 短线偏移角度
        
        /**
         * 四种 线条的角度判断
         */
        if (middleAngle >= -M_PI_2 && middleAngle <= 0) {// 1
            CGFloat angle = 0 - middleAngle;
            minPieCenter = CGPointMake(self.pieCenter.x + cosf(angle)*picOutR, self.pieCenter.y - sinf(angle)*picOutR);
            
            if (angle > -M_PI_2/2) {
                lineAngle = M_PI_2/3;
            }
            line_1_Point = CGPointMake(minPieCenter.x + cosf(lineAngle)*line_1_W, minPieCenter.y - sinf(lineAngle)*line_1_W);
            line_2_Point = CGPointMake(self.width - lineSpace, line_1_Point.y);
        }else if (middleAngle >= 0 && middleAngle <= M_PI_2) {// 4
            minPieCenter = CGPointMake(self.pieCenter.x + cosf(middleAngle)*picOutR, self.pieCenter.y + sinf(middleAngle)*picOutR);
            if (middleAngle > M_PI_2/2) {
                lineAngle = M_PI_2/3;
            }
            line_1_Point = CGPointMake(minPieCenter.x + cosf(lineAngle)*line_1_W, minPieCenter.y + sinf(lineAngle)*line_1_W);
            line_2_Point = CGPointMake(self.width - lineSpace, line_1_Point.y);
        }else if (middleAngle >= M_PI_2 && middleAngle <= 2*M_PI_2) {// 3
            CGFloat angle = M_PI - middleAngle;
            minPieCenter = CGPointMake(self.pieCenter.x - cosf(angle)*picOutR, self.pieCenter.y + sinf(angle)*picOutR);
            if (middleAngle < 3*M_PI_2/2) {
                lineAngle = M_PI_2/3;
            }
            line_1_Point = CGPointMake(minPieCenter.x - cosf(lineAngle)*line_1_W, minPieCenter.y + sinf(lineAngle)*line_1_W);
            line_2_Point = CGPointMake(lineSpace, line_1_Point.y);
        }else {// 2
            CGFloat angle = middleAngle - M_PI;
            minPieCenter = CGPointMake(self.pieCenter.x - cosf(angle)*picOutR, self.pieCenter.y - sinf(angle)*picOutR);
            if (middleAngle > 5*M_PI_2/2) {
                lineAngle = M_PI_2/3;
            }
            line_1_Point = CGPointMake(minPieCenter.x - cosf(lineAngle)*line_1_W, minPieCenter.y - sinf(lineAngle)*line_1_W);
            line_2_Point = CGPointMake(lineSpace, line_1_Point.y);
        }
        // 圆点
        CAShapeLayer *minLayer = [CAShapeLayer layer];
        minLayer.fillColor = [self.colorArray[i] CGColor];
        [self.layer addSublayer:minLayer];
        
        UIBezierPath *minPath = [UIBezierPath bezierPathWithArcCenter:minPieCenter radius:3 startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
        minLayer.path = minPath.CGPath;
        // 折线
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.strokeColor = [self.colorArray[i] CGColor];
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:lineLayer];
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:minPieCenter];
        [linePath addLineToPoint:line_1_Point];
        [linePath addLineToPoint:line_2_Point];
        lineLayer.path = linePath.CGPath;
        
        CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        lineAnimation.duration = AnimationTime;
        lineAnimation.repeatCount = 1;
        lineAnimation.fromValue = @(0);
        lineAnimation.toValue = @(1);
        lineAnimation.removedOnCompletion = NO;
        lineAnimation.fillMode = kCAFillModeForwards;
        lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [lineLayer addAnimation:lineAnimation forKey:nil];
        
        
        UILabel *upLabel = nil;
//        UILabel *downLabel = nil;
        // 线上的文字
        if (i < self.upTextItems.count) {
            upLabel = [self createLabel:self.upTextItems[i] endPoint:line_2_Point isUp:YES];
        }

//        // 线下的文字
//        if (i < self.downTextItems.count) {
//            downLabel = [self createLabel:self.downTextItems[i] endPoint:line_2_Point isUp:NO];
//        }
//
        [UIView animateWithDuration:AnimationTime animations:^{
            upLabel.alpha = 1;
//            downLabel.alpha = 1;
        }];
        startAngle = endAngle;
    }
    
    
    // 遮盖的圆
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.fillColor = [UIColor clearColor].CGColor;
    backLayer.strokeColor = self.backgroundColor.CGColor;
    backLayer.lineWidth = self.pieW + 5;
    
    
    UIBezierPath *backLayerPath = [UIBezierPath bezierPathWithArcCenter:self.pieCenter radius:self.pieR startAngle:-M_PI_2 endAngle:3 * M_PI_2 clockwise:YES];
    backLayer.path = backLayerPath.CGPath;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation.duration = AnimationTime;
    animation.repeatCount = 1;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [backLayer addAnimation:animation forKey:nil];
    
    [self.layer addSublayer:backLayer];
}

- (UILabel *)createLabel:(NSString *)text endPoint:(CGPoint)endPoint isUp:(BOOL)isUp {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:0.35f green:0.35f blue:0.37f alpha:1.00f];
    label.font = [UIFont systemFontOfSize:10];
    label.text = text;
    label.alpha = 0;
    [self addSubview:label];
    
    if (endPoint.x > self.width/2) {
        label.textAlignment = NSTextAlignmentRight;
    }
    
    if (isUp) {// 线上
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo( - (self.height - endPoint.y));
            
            if (endPoint.x > self.width/2) {
                make.right.mas_equalTo( - (self.width - endPoint.x));
            }else {
                make.left.mas_equalTo(endPoint.x);
            }
        }];
    }else {// 线下
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(endPoint.y);
            if (endPoint.x > self.width/2) {
                make.right.mas_equalTo( - (self.width - endPoint.x));
            }else {
                make.left.mas_equalTo(endPoint.x);
            }
        }];
    }
    
    return label;
}

-(void)showPieChartView {
    [self setNeedsDisplay];
}

-(void)setValueArray:(NSArray *)valueArray {
    if (valueArray) {
        _valueArray = valueArray;
    }
}

-(void)setPieCenter:(CGPoint)pieCenter {
    _pieCenter = pieCenter;
}

-(void)setPieW:(CGFloat)pieW {
    _pieW = pieW;
}

-(void)setPieR:(CGFloat)pieR {
    _pieR = pieR;
}

-(void)setUpTextItems:(NSArray *)upTextItems {
    _upTextItems = upTextItems;
}

-(NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<self.valueArray.count; i++) {
            float a = arc4random()%256;
            float b = arc4random()%256;
            float c = arc4random()%256;
            [_colorArray addObject:RGB(a, b, c)];
        }
    }
    return _colorArray;
}
@end
