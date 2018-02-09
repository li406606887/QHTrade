//
//  ShareCustomView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//  自定义分享弹窗

#import "ShareCustomView.h"
static CGFloat kTransitionDuration = 0.2;
#define MyEditorWidth 310.0f
#define MyEditorHeight 300.0f

@interface ShareCustomView ()

@end
@implementation ShareCustomView
-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title
                       BtnImgArray:(NSArray *)imgArray {
    self = [super init];
    if (self) {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 100, 25)];
        label1.text = title;
        label1.font = [UIFont systemFontOfSize:18];
        label1.textColor = RGB(68, 68, 68);
        label1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label1];
        
        int count = (int)imgArray.count;
        for (int i = 0; i<count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(SCREEN_WIDTH-50-(42*count)+(i*42), 12.5, 22, 22);
            [self addSubview:btn];
        }
        

    }
    return self;
}

-(void)itemBtnClick:(UIButton *)btn {
    if (self.itemBlock) {
        self.itemBlock(btn.tag);
    }
    [self dismissAlert];
}


-(UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:[UIColor whiteColor]];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 4;
        _closeButton.layer.masksToBounds = YES;
    }
    return _closeButton;
}

-(void)closeBtnClick:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self dismissAlert];
}


/*
 * 展示自定义AlertView
 */
- (void)show {
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(20, SCREEN_HEIGHT-108, SCREEN_WIDTH-40, 45);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    
    [topVC.view addSubview:self];
}

- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.closeButton.frame = CGRectMake(20, SCREEN_HEIGHT-60, SCREEN_WIDTH-40, 45);//取消按钮
        [self.backImageView addSubview:self.closeButton];
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
//    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kTransitionDuration/2];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(bounceAnimationStopped)];
//    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
//    [UIView commitAnimations];
    
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

- (void)dismissAlert {
    [self remove];
}

- (void)remove {
    [self.backImageView removeFromSuperview];
    [self removeFromSuperview];
}


@end
