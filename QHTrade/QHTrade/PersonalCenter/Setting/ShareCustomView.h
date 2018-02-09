//
//  ShareCustomView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCustomView : UIView

@property (nonatomic, strong) UIButton * closeButton;

@property (nonatomic, strong) UIView  * backImageView;


@property (nonatomic,copy) void (^closeBlock)(void);
@property (nonatomic,copy) void (^itemBlock)(NSInteger tag);

-(instancetype)initWithTitle:(NSString *)title
                 BtnImgArray:(NSArray *)imgArray;

- (void)show;

@end
