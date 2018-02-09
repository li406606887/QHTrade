//
//  EvaluateView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EvaluateView.h"
static CGFloat kTransitionDuration = 0.3;
#define MyEditorWidth 310.0f
#define MyEditorHeight 300.0f
#define MAX_LIMIT_NUMS  140 //最大字数
@interface EvaluateView ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel * placeHolder;
@property (nonatomic,strong) UILabel * limitNum;// 输入字数/最大字数
@end
@implementation EvaluateView
-(instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithTitle:(NSString *)title
                LeftBtnTitle:(NSString *)leftBtnTitle
               RightBtnTitle:(NSString *)rightBtnTitle {
    self = [super init];
    if (self) {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(MyEditorWidth / 2 - 50, 20, 100, 25)];
        label1.text = title;
        label1.font = [UIFont systemFontOfSize:18];
        label1.textColor = RGB(0, 0, 0);
        label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label1];
        
        [self addSubview:self.textView];
        
        [self.closeButton setTitle:leftBtnTitle forState:UIControlStateNormal];
        [self.goonBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
        
        [self addSubview:self.closeButton];
        [self addSubview:self.goonBtn];
    }
    return self;
}
-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.layer.borderWidth = 1.0f;
        _textView.layer.borderColor = RGB(191, 191, 191).CGColor;
        _textView.layer.cornerRadius = 2.0f;
        _textView.layer.masksToBounds = YES;
        [_textView setFrame:CGRectMake(15, 55, MyEditorWidth-30, 150)];
        _textView.font = [UIFont systemFontOfSize:13.0f];
        
        self.placeHolder.frame = CGRectMake(8, 3, 280, 25);
        [_textView addSubview:self.placeHolder];
        self.limitNum.frame = CGRectMake(self.textView.frame.size.width-60, self.textView.frame.size.height-25, 60, 25);
        [_textView addSubview:self.limitNum];
        _textView.delegate = self;
        
        //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
        [topView setItems:buttonsArray];
        [_textView setInputAccessoryView:topView];
        
    }
    return _textView;
}
-(void)textViewDidChange:(UITextView *)textView {
    if (!self.textView.text.length) {
        self.placeHolder.alpha = 1;
    }else {
        self.placeHolder.alpha = 0;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *textContent = textView.text;
    NSInteger existTextNum = textContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS) {//截取到最大位置的字符
        NSString *s = [textContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
    }
    
    //不让显示负数
    self.limitNum.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }else{
            return NO;
        }
    }
    
    NSString *comcatStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputLen = MAX_LIMIT_NUMS - comcatStr.length;
    
    if (caninputLen >= 0) {
        return YES;
    }else {
        NSInteger len = text.length + caninputLen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，一定是最大限制了。
            self.limitNum.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
    
}

//关闭键盘
-(void) dismissKeyBoard {
    [self.textView resignFirstResponder];
}
-(UILabel *)limitNum {
    if (!_limitNum) {
        _limitNum = [[UILabel alloc]init];
        _limitNum.text = [NSString stringWithFormat:@"%d/%d",MAX_LIMIT_NUMS,MAX_LIMIT_NUMS];
        _limitNum.textColor = [UIColor lightGrayColor];
        _limitNum.numberOfLines = 0;
        _limitNum.contentMode = UIViewContentModeRight;
        _limitNum.font = [UIFont systemFontOfSize:13.0f];
    }
    return _limitNum;
}
-(UILabel *)placeHolder {
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc]init];
        _placeHolder.text = [NSString stringWithFormat:@"发表你的评价，%d字以内",MAX_LIMIT_NUMS];
        _placeHolder.textColor = [UIColor lightGrayColor];
        _placeHolder.numberOfLines = 0;
        _placeHolder.contentMode = UIViewContentModeTop;
        _placeHolder.font = [UIFont systemFontOfSize:13.0f];
    }
    return _placeHolder;
}

-(UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:RGB(244, 244, 244)];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:RGB(34, 34, 34) forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(0, MyEditorHeight-50, MyEditorWidth/2, 50)];
    }
    return _closeButton;
}
-(UIButton *)goonBtn {
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
-(void)closeBtnClick:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self dismissAlert];
}
#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender {
    if (self.goonBlock) {
        self.goonBlock(self.textView.text);
    }
    [self dismissAlert];
}

/*
 * 展示自定义AlertView
 */
- (void)show {
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-MyEditorHeight*0.5, MyEditorWidth, MyEditorHeight);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 15;
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
    }
    [topVC.view addSubview:self.backImageView];
    
    // 一系列动画效果,达到反弹效果
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.05, 0.05);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
//    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
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

- (void)dismissAlert {
    [self remove];
}

- (void)remove {
    [self.backImageView removeFromSuperview];
    [self removeFromSuperview];
}
- (void)showCachAccount {
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake(SCREEN_WIDTH/2-MyEditorWidth/2, SCREEN_HEIGHT/2-350*0.5, MyEditorWidth, 350);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [topVC.view addSubview:self];
}

//- (CGFloat)getTextHeight {
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
//    CGRect rect = [self.sting boundingRectWithSize:CGSizeMake(MyEditorWidth-40, MAXFLOAT)
//                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
//                                        attributes:attributes
//                                           context:nil];
//    return rect.size.height;
//}
@end
