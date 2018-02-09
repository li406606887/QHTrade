//
//  EvaluateView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateView : UIView
@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UITextView  * textView;
@property (nonatomic, strong) UIButton * closeButton;
@property (nonatomic, strong) UIButton * goonBtn;
@property (nonatomic, strong) UIView  * backImageView;

@property(nonatomic,copy) void (^goonBlock)(NSString * text);
@property (nonatomic,copy) void (^closeBlock)(void);

-(instancetype)initWithTitle:(NSString *)title
               LeftBtnTitle:(NSString *)leftBtnTitle
               RightBtnTitle:(NSString *)rightBtnTitle;

- (void)show;

- (void)showCachAccount;
@end
