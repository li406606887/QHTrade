//
//  LineChartView.m
//  QHTrade
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "LineChartView.h"

static CGFloat bounceX = 40;
static CGFloat bounceY = 20;
//static NSInteger countq = 0;
#define kWidth  self.frame.size.width
#define kHeight  self.frame.size.height

@interface LineChartView ()
@property(nonatomic,strong) NSMutableArray *arrayY;
@property(nonatomic,strong) NSMutableArray *labelY;
@property(nonatomic,strong) NSMutableArray *arrayX;
@property(nonatomic,strong) NSMutableArray *labelX;
@property(nonatomic,strong) NSMutableArray *arrayPoint;
@property(nonatomic, weak) UIBezierPath * path1;
@property(nonatomic, strong) CAShapeLayer *lineChartLayer;

@end

@implementation LineChartView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

#pragma mark 创建x轴的数据
- (void)createLabelX{
    CGFloat  month = self.labelX.count;
    for (NSInteger i = 0; i < month; i++) {
        UILabel * dateLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth - 60)/month * i + bounceX, kHeight - bounceY + bounceY*0.3, (kWidth - 2*bounceX)/month- 5, bounceY/2)];
        //        LabelMonth.backgroundColor = [UIColor greenColor];
        dateLabel.tag = 1000 + i;
        dateLabel.text = self.labelX[i];
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dateLabel];
    }
    
}
#pragma mark 创建y轴数据
- (void)createLabelY{
    CGFloat Ydivision = self.labelY.count;
    for (NSInteger i = Ydivision; i > 0; i--) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (kHeight - 2 * bounceY)/(Ydivision-1) *(Ydivision-i)+20, 43, bounceY/2.0)];
        labelYdivision.tag = 2000 + i;
        labelYdivision.text = self.labelY[i-1];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        labelYdivision.textAlignment = NSTextAlignmentRight;
        [self addSubview:labelYdivision];
    }
}

- (void)drawRect:(CGRect)rect{
    /*******画出坐标轴********/
    if (_dataArray.count<1) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.53, 0.53, 0.53, 1);
    CGContextMoveToPoint(context, 45, bounceY);
    CGContextAddLineToPoint(context, 45, rect.size.height - bounceY);
    CGContextAddLineToPoint(context,rect.size.width - 15, rect.size.height - bounceY);
    CGContextStrokePath(context);
    
}

-(void)setDataArray:(NSMutableArray *)dataArray {
    if (dataArray) {
        _dataArray = dataArray;
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if(dataArray!=nil&&dataArray.count>0){
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                if (self.arrayY.count>0||self.arrayX.count>0||self.arrayPoint>0) {
                    [self.arrayPoint removeAllObjects];
                    [self.arrayY removeAllObjects];
                    [self.labelY removeAllObjects];
                    [self.arrayX removeAllObjects];
                }
                [self calculateDataArray:dataArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self createLabelX];
                    [self createLabelY];
                    [self dravLine];
                    [self setNeedsDisplay];
                });
            });
        }
        
    }
}
- (void)dravLine{
    UILabel * label = (UILabel*)[self viewWithTag:1000];//根据横坐标上面的label 获取直线关键点的x 值
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    UIColor * color = [UIColor greenColor];
    [color set];
    [path moveToPoint:CGPointMake(label.centerX, (600 -arc4random()%600) /600.0 * (self.frame.size.height - bounceY*2 )  )];
    
    //创建折现点标记
    CGFloat count = self.arrayPoint.count;
    for (NSInteger i = 0; i< count; i++) {
        NSValue *value = [self.arrayPoint objectAtIndex:i];
        CGPoint point = [value CGPointValue];
        [path addLineToPoint:point];
    }
    self.path1 = path;
    [self.layer addSublayer:self.lineChartLayer];//直接添加导视图上
}
-(void)calculateDataArray:(NSMutableArray *)data{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSMutableArray *valueArray = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in data) {
        NSString * str = [dic[@"time"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        [self.arrayX addObject:[str substringFromIndex:5]];//时间
        [valueArray addObject:dic[@"value"]];
        
    }
    NSNumber * maxNum = [valueArray valueForKeyPath:@"@max.self"];//最大值
    NSNumber * minNum = [valueArray valueForKeyPath:@"@min.self"];//负最小值
    if ([minNum intValue] == [maxNum intValue] && [minNum intValue] == 0) {
            [self.arrayY addObject:[NSString stringWithFormat:@"0"]];
    }else{
        for (int i = [minNum intValue]; i <= [maxNum intValue]; i++) {
            [self.arrayY addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    int coefficientY = (int)self.arrayY.count/12;
    for (int i = 0; i<13; i++) {
        if (i==12) {
            [self.labelY addObject:[NSString stringWithFormat:@"%d",[self.arrayY.lastObject intValue]]];
        }else  if(i==0){
            int resultValue = [self.arrayY.firstObject floatValue]/100*100;
            if (resultValue<[self.arrayY.firstObject floatValue]) {
                resultValue = resultValue+100;
            }
            [self.labelY addObject:[NSString stringWithFormat:@"%d",resultValue]];
        }else{
            int resultValue = [self.arrayY[i*coefficientY] intValue]/100*100;
            [self.labelY addObject:[NSString stringWithFormat:@"%d",resultValue]];
        }
    }
    int multiple = (int)self.arrayX.count/6;//倍数
    int remainder = (int)self.arrayX.count%6;//余数
    
    if (multiple>0) {
        for (int i = 0; i<6; i++) {
            if (i % multiple == 0) {
                int index = i;
                int coefficient = (int)i/multiple;//系数
                if (remainder >2) {
                    index = coefficient*multiple+1;
                }
                NSString * string = self.arrayX[index];
                [self.labelX addObject:string];
            }
        }
    }else{
        for (int i = 0; i<self.arrayX.count; i++) {
            if (i % 1 == 0) {
                NSString * string = self.arrayX[i];
                [self.labelX addObject:string];
                
            }
        }
    }
    CGFloat pointWith = (kWidth - 60)/data.count;
    CGFloat pointX = pointWith*0.5;
    CGFloat chartViewHeight = kHeight-40;
    for (int i = 0; i < valueArray.count; i++) {
        int key = [valueArray[i] intValue];
        int indexLine = [self.arrayY[key] intValue];
        int absIndexLine = abs(indexLine);
        CGFloat pointY = chartViewHeight * absIndexLine/(self.arrayY.count-1);
        [self.arrayPoint addObject:[NSValue valueWithCGPoint:CGPointMake(pointWith*i+pointX, pointY)]];
    }
   
    dispatch_semaphore_signal(semaphore);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
-(CAShapeLayer *)lineChartLayer {
    if (!_lineChartLayer) {
        _lineChartLayer = [CAShapeLayer layer];
        _lineChartLayer.path = self.path1.CGPath;
        _lineChartLayer.strokeColor = [UIColor redColor].CGColor;
        _lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        _lineChartLayer.lineWidth = 0;
        _lineChartLayer.lineCap = kCALineCapRound;
        _lineChartLayer.lineJoin = kCALineJoinRound;
    }
    return _lineChartLayer;
}

-(NSMutableArray *)arrayY {
    if (!_arrayY) {
        _arrayY = [[NSMutableArray alloc] init];
    }
    return _arrayY;
}

-(NSMutableArray *)arrayX {
    if (!_arrayX) {
        _arrayX = [[NSMutableArray alloc] init];
    }
    return _arrayX;
}

-(NSMutableArray *)arrayPoint {
    if (!_arrayPoint) {
        _arrayPoint = [[NSMutableArray alloc] init];
    }
    return _arrayPoint;
}
-(NSMutableArray *)labelY {
    if (!_labelY) {
        _labelY = [[NSMutableArray alloc] init];
    }
    return _labelY;
}
-(NSMutableArray *)labelX {
    if (!_labelX) {
        _labelX = [[NSMutableArray alloc] init];
    }
    return _labelX;
}
@end
