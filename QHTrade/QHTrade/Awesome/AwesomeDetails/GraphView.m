//
//  GraphView.m
//  QHTrade
//
//  Created by user on 2017/12/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GraphView.h"
#import "XAxisView.h"
#import "YAxisView.h"

#define leftMargin 50
#define lastSpace 50

@interface GraphView ()
@property (strong, nonatomic) YAxisView *yAxisView;
@property (strong, nonatomic) XAxisView *xAxisView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;
@property (assign, nonatomic) CGFloat defaultSpace;//间距
@property (assign, nonatomic) CGFloat moveDistance;
@end

@implementation GraphView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)showGraphView{
    if (self.xTitleArray.count > 600) {
        _defaultSpace = 5;
    }else if (self.xTitleArray.count > 400 && self.xTitleArray.count <= 600){
        _defaultSpace = 10;
    }else if (self.xTitleArray.count > 200 && self.xTitleArray.count <= 400){
        _defaultSpace = 20;
    }else if (self.xTitleArray.count > 100 && self.xTitleArray.count <= 200){
        _defaultSpace = 30;
    }else {
        _defaultSpace = 40;
    }
    
    self.pointGap = _defaultSpace;
    
    [self creatYAxisView];
    
    [self creatXAxisView];
    
    // 2. 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [self.xAxisView addGestureRecognizer:pinch];
    
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
    [self.xAxisView addGestureRecognizer:longPress];
}

- (void)creatYAxisView {
    self.yAxisView = [[YAxisView alloc]initWithFrame:CGRectMake(0, 0, leftMargin, self.frame.size.height) yMax:self.yMax yMin:self.yMin title:self.titleY];
    [self addSubview:self.yAxisView];
}

-(void)setXTitleArray:(NSArray *)xTitleArray {
    _xTitleArray = xTitleArray;
}

-(void)setYValueArray:(NSArray *)yValueArray {
    _yValueArray = yValueArray;
}

-(void)setYMax:(CGFloat)yMax {
    _yMax = yMax;
}

-(void)setYMin:(CGFloat)yMin {
    _yMin = yMin;
}

-(void)setTitleY:(NSString *)titleY {
    _titleY = titleY;
}

- (void)creatXAxisView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(leftMargin-10, 0, self.frame.size.width-leftMargin, self.frame.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    self.xAxisView = [[XAxisView alloc] initWithFrame:CGRectMake(0, 0, self.xTitleArray.count * self.pointGap + lastSpace, self.frame.size.height) xTitleArray:self.xTitleArray yValueArray:self.yValueArray yMax:self.yMax yMin:self.yMin];
    
    [_scrollView addSubview:self.xAxisView];
    
    _scrollView.contentSize = self.xAxisView.frame.size;
    CGFloat xOffset ;
    if (self.xTitleArray.count > 600) {
        xOffset = 0;
    }
    else if (self.xTitleArray.count > 400 && self.xTitleArray.count <= 600){
        xOffset = 5;
    }
    else if (self.xTitleArray.count > 200 && self.xTitleArray.count <= 400){
        xOffset = 10;
    }
    else if (self.xTitleArray.count > 100 && self.xTitleArray.count <= 200){
        xOffset = 15;
    }
    else {
        xOffset = 20;
    }
    [_scrollView setContentOffset:CGPointMake(xOffset, 0)];

}


// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == 3) {
        
        if (self.xAxisView.frame.size.width-lastSpace <= self.scrollView.frame.size.width) { //当缩小到小于屏幕宽时，松开回复屏幕宽度
            
            CGFloat scale = self.scrollView.frame.size.width / (self.xAxisView.frame.size.width-lastSpace);
            
            self.pointGap *= scale;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = self.xAxisView.frame;
                frame.size.width = self.scrollView.frame.size.width+lastSpace;
                self.xAxisView.frame = frame;
            }];
            
            self.xAxisView.pointGap = self.pointGap;
            
        }else if (self.xAxisView.frame.size.width-lastSpace >= self.xTitleArray.count * _defaultSpace){
            
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = self.xAxisView.frame;
                frame.size.width = self.xTitleArray.count * _defaultSpace + lastSpace;
                self.xAxisView.frame = frame;
                
            }];
            
            self.pointGap = _defaultSpace;
            
            self.xAxisView.pointGap = self.pointGap;
        }
    }else{
        
        CGFloat currentIndex,leftMagin;
        if( recognizer.numberOfTouches == 2 ) {
            //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
            CGPoint p1 = [recognizer locationOfTouch:0 inView:self.xAxisView];
            CGPoint p2 = [recognizer locationOfTouch:1 inView:self.xAxisView];
            CGFloat centerX = (p1.x+p2.x)/2;
            leftMagin = centerX - self.scrollView.contentOffset.x;
            currentIndex = centerX / self.pointGap;
            self.pointGap *= recognizer.scale;
            self.pointGap = self.pointGap > _defaultSpace ? _defaultSpace : self.pointGap;
            if (self.pointGap == _defaultSpace) {
                showMassage(@"已经放至最大")
            }
            self.xAxisView.pointGap = self.pointGap;
            recognizer.scale = 1.0;
            self.xAxisView.frame = CGRectMake(0, 0, self.xTitleArray.count * self.pointGap + lastSpace, self.frame.size.height);
            
            self.scrollView.contentOffset = CGPointMake(currentIndex*self.pointGap-leftMagin, 0);
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.xAxisView.frame.size.width, 0);
    
}


- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:self.xAxisView];
        
        //相对于屏幕的位置
        CGPoint screenLoc = CGPointMake(location.x - self.scrollView.contentOffset.x, location.y);
        [self.xAxisView setScreenLoc:screenLoc];
        
        if (ABS(location.x - _moveDistance) > self.pointGap) { //不能长按移动一点点就重新绘图  要让定位的点改变了再重新绘图
            [self.xAxisView setIsShowLabel:YES];
            [self.xAxisView setIsLongPress:YES];
            self.xAxisView.currentLoc = location;
            _moveDistance = location.x;
        }
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded) {
        //恢复scrollView的滑动
        [self.xAxisView setIsLongPress:NO];
        [self.xAxisView setIsShowLabel:NO];
    }
}

-(void)dealloc {
    NSLog(@"123");
}
@end
