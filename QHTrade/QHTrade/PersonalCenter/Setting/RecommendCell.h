//
//  RecommendCell.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/18.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kRecommendCell  = @"RecommendCell";
@interface RecommendCell : UITableViewCell
@property (nonatomic,strong) UIButton *bottomFirstBtn;
@property (nonatomic,strong) UIButton *bottomSecondBtn;
@property (nonatomic,strong) UIButton *bottomThirdBtn;
@property (nonatomic,strong) UIButton *bottomFourthBtn;
@property (nonatomic,strong) UIView *bottomBgView;
@property (nonatomic,strong) UIView *leftBgView;//左边底
@property (nonatomic,strong) UIView *rightTopView;//右上
@property (nonatomic,strong) UIView *rightBottomView;//右下

@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *leftSubTitleLabel;
@property (nonatomic,strong) UIImageView *leftImgView;

@property (nonatomic,strong) UILabel *rightTopTitileLabel;
@property (nonatomic,strong) UILabel *rightTopSubTitleLabel;
@property (nonatomic,strong) UIImageView *rightTopImgView;

@property (nonatomic,strong) UILabel *rightBottomTitileLabel;
@property (nonatomic,strong) UILabel *rightBottomSubTitleLabel;
@property (nonatomic,strong) UIImageView *rightBottomImgView;

@property (nonatomic,copy) void (^leftClickBlock)(void);//左边图片点击
@property (nonatomic,copy) void (^rightTopClickBlock)(void);//右边图片点击
@property (nonatomic,copy) void (^rightBottomClickBlock)(void);
@property (nonatomic,copy) void (^bottomFirstClickBlock)(void);
@property (nonatomic,copy) void (^bottomSecondClickBlock)(void);
@property (nonatomic,copy) void (^bottomThirdClickBlock)(void);
@property (nonatomic,copy) void (^bottomFourthClickBlock)(void);
@end
