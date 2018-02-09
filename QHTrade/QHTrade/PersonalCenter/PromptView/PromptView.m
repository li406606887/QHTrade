//
//  PromptView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PromptView.h"
static CGFloat kTransitionDuration = 0.4;
#define MyEditorWidth 310.0f
#define MyEditorHeight 135.0f+self.textHeight
@interface PromptView()

@property(nonatomic,copy)NSString *sting;
@property(nonatomic,assign)CGFloat textHeight;

@end
@implementation PromptView


-(id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id)initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle
      LeftBtnTitle:(NSString *)leftBtnTitle RightBtnTitle:(NSString *)rightBtnTitle{
    
    self = [super init];
    if (self) {
        self.sting = subTitle;
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 20, 100, 25)];
        label1.text = title;
        label1.font = [UIFont systemFontOfSize:18];
        label1.textColor = RGB(0, 0, 0);
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        
        self.subTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, MyEditorWidth-20, self.textHeight+10)];
         self.subTitle.textColor = RGB(51, 51, 51);
         self.subTitle.numberOfLines = 0;
         self.subTitle.text = subTitle;
        
        
         self.subTitle.font = [UIFont systemFontOfSize:15];
         self.subTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.subTitle];
        
        [self.closeButton setTitle:leftBtnTitle forState:UIControlStateNormal];
        [self.goonBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
        
        [self addSubview:self.closeButton];
        [self addSubview:self.goonBtn];
        
    }
    
    return self;
}

-(id)initWithTitleString:(NSString *)titleString SubTitleString:(NSString *)subTitleString{
    self = [super init];
    if (self) {
        self.sting = subTitleString;
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 20, 100, 25)];
        label1.text = titleString;
        label1.font = [UIFont systemFontOfSize:18];
//        label1.textColor = RGB(69, 68, 68);
        label1.textColor = [UIColor blackColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, MyEditorWidth-20, self.textHeight+10)];
        label2.textColor = RGB(51, 51, 51);
        label2.numberOfLines = 0;
        label2.text = subTitleString;
        label2.font = [UIFont systemFontOfSize:15.0f];
        
        label2.font = [UIFont systemFontOfSize:15];
        label2.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label2];
//        [self addSubview:self.closeButton];

        [self addSubview:self.goonBtn];
//        [self.goonBtn setFrame:CGRectMake(0, MyEditorHeight-50, MyEditorWidth, 50)];
        [self.goonBtn setFrame:CGRectMake(MyEditorWidth / 2 - 75, MyEditorHeight-50, 150, 40)];
        self.goonBtn.layer.cornerRadius = 6.0f;
        self.goonBtn.layer.masksToBounds = YES;
    }
    
    return self;
}
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:RGB(244, 244, 244)];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(0, MyEditorHeight-50,  MyEditorWidth/2, 50)];
    }
    return _closeButton;
}
-(UIButton *)goonBtn{
    if (!_goonBtn) {
        _goonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goonBtn addTarget:self action:@selector(goonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_goonBtn setBackgroundColor:RGB(255, 98, 1)];
        [_goonBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_goonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_goonBtn setFrame:CGRectMake(MyEditorWidth/2, MyEditorHeight-50, MyEditorWidth/2, 50)];
    }
    return _goonBtn;
}
-(void)closeBtnClick:(id)sender{
    
    if (self.closeBlock) {
        self.closeBlock();
    }
    
    [self dismissAlert];
}
#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender
{
    //代码块回掉
    if (self.goonBlock) {
        self.goonBlock();
    }
    [self dismissAlert];
}

/*
 * 展示自定义AlertView
 */
- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
    
    [super willMoveToSuperview:newSuperview];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}


- (void)dismissAlert
{
    [self remove];
}

- (CGFloat)getTextHeight{
   
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGRect rect = [self.sting boundingRectWithSize:CGSizeMake(MyEditorWidth-40, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return rect.size.height;
}
- (void)remove
{
    [self.backImageView removeFromSuperview];
    
    [self removeFromSuperview];
    
}
- (void)showCachAccount
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-350*0.5, MyEditorWidth, 350);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}

-(CGFloat)textHeight{
    if (!_textHeight) {
        _textHeight = [self getTextHeight];
    }
    return _textHeight;
}
@end
