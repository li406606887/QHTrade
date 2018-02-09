//
//  RecommendCell.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/18.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//
#define TITLE_RED_COLOR [UIColor colorWithRed:242.0/255.0 green:108.0/255.0 blue:50.0/255.0 alpha:1.0f]
#define LABEL_GRAY_COLOR [UIColor colorWithRed:143.0/255.0 green:143.0/255.0 blue:143.0/255.0 alpha:1.0f]
#define TITLE_YELLOW_COLOR [UIColor colorWithRed:254.0/255.0 green:184.0/255.0 blue:0.0/255.0 alpha:1.0f]
#import "RecommendCell.h"

@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadViews];
    
}
-(void)leftAndRightViewClick:(UITapGestureRecognizer *)sender {
    NSInteger tag = [sender view].tag;
    switch (tag) {
        case 201:
        {//左边点击
            if (self.leftClickBlock) {
                self.leftClickBlock();
            }
        }
            break;
        case 202:
        {//右上点击
            if (self.rightTopClickBlock) {
                self.rightTopClickBlock();
            }
        }
            break;
        case 203:
        {//右下点击
            if (self.rightBottomClickBlock) {
                self.rightBottomClickBlock();
            }
        }
            break;
            
        default:
            break;
    }

}
//底部4个等分button
-(void)bottomBtnClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    switch (tag) {
        case 101:
        {
            if (self.bottomFirstClickBlock) {
                self.bottomFirstClickBlock();
            }
        }
            break;
        case 102:
        {
            if (self.bottomSecondClickBlock) {
                self.bottomSecondClickBlock();
            }
        }
            break;
        case 103:
        {
            if (self.bottomThirdClickBlock) {
                self.bottomThirdClickBlock();
            }
        }
            break;
        case 104:
        {
            if (self.bottomFourthClickBlock) {
                self.bottomFourthClickBlock();
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)loadViews {

    NSArray * viewArray = @[self.bottomFirstBtn,self.bottomSecondBtn,self.bottomThirdBtn,self.bottomFourthBtn];
    self.bottomBgView = [[UIView alloc]init];
    self.bottomBgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bottomBgView];
    [self.contentView addSubview:self.bottomFirstBtn];
    [self.contentView addSubview:self.bottomSecondBtn];
    [self.contentView addSubview:self.bottomThirdBtn];
    [self.contentView addSubview:self.bottomFourthBtn];
    
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_offset(70);
    }];
    [self makeEqualWidthViews:viewArray inView:self.bottomBgView LRpadding:0.0f viewPadding:0.5f];
    
    [self.contentView addSubview:self.leftBgView];
    [self.contentView addSubview:self.rightTopView];
    [self.contentView addSubview:self.rightBottomView];
    [self.leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.bottom.equalTo(self.bottomBgView.mas_top);
        make.width.mas_offset(SCREEN_WIDTH/2);
    }];
    [self.rightBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.bottomBgView.mas_top);
        make.width.mas_offset(SCREEN_WIDTH/2);
        make.height.mas_offset(87.5);
    }];
    [self.rightTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.rightBottomView.mas_top);
        make.width.mas_offset(SCREEN_WIDTH/2);
    }];
    
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.leftSubTitleLabel];
    [self.contentView addSubview:self.leftImgView];
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.leftBgView).with.offset(8);
        make.right.equalTo(self.leftBgView).with.offset(-8);
        make.height.mas_offset(22);
    }];
    
    [self.leftSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTitleLabel.mas_bottom).with.offset(3);
        make.left.equalTo(self.leftBgView).with.offset(8);
        make.right.equalTo(self.leftBgView).with.offset(-3);
        make.height.mas_offset(22);
    }];
    
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftSubTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.leftBgView).with.offset(8);
        make.right.equalTo(self.leftBgView).with.offset(-8);
        make.bottom.equalTo(self.leftBgView).with.offset(-8);
    }];
    
    [self.contentView addSubview:self.rightTopTitileLabel];
    [self.contentView addSubview:self.rightTopSubTitleLabel];
    [self.contentView addSubview:self.rightTopImgView];
    
    [self.rightTopTitileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.rightTopView).with.offset(8);
        make.height.mas_offset(22);
        make.width.mas_offset(70);
    }];
    [self.rightTopSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightTopTitileLabel.mas_bottom).with.offset(3);
        make.left.equalTo(self.rightTopView).with.offset(8);
        make.width.mas_offset(70);
        make.height.mas_offset(22);
    }];
    [self.rightTopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightTopTitileLabel.mas_top).with.offset(5);
        make.left.equalTo(self.rightTopSubTitleLabel.mas_right).with.offset(3);
        make.right.equalTo(self.rightTopView).with.offset(-8);
        make.bottom.equalTo(self.rightTopView).with.offset(-8);
    }];
    
    
    [self.contentView addSubview:self.rightBottomTitileLabel];
    [self.contentView addSubview:self.rightBottomSubTitleLabel];
    [self.contentView addSubview:self.rightBottomImgView];
    
    [self.rightBottomTitileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.rightBottomView).with.offset(8);
        make.height.mas_offset(22);
        make.width.mas_offset(70);
    }];
    [self.rightBottomSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightBottomTitileLabel.mas_bottom).with.offset(3);
        make.left.equalTo(self.rightBottomView).with.offset(8);
        make.width.mas_offset(70);
        make.height.mas_offset(22);
    }];
    [self.rightBottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightBottomTitileLabel.mas_top).with.offset(5);
        make.left.equalTo(self.rightBottomSubTitleLabel.mas_right).with.offset(3);
        make.right.equalTo(self.rightBottomView).with.offset(-8);
        make.bottom.equalTo(self.rightBottomView).with.offset(-8);
    }];
}
//右下背景
-(UIView *)rightBottomView {
    if (!_rightBottomView) {
        _rightBottomView = [[UIView alloc]init];
        _rightBottomView.backgroundColor = [UIColor whiteColor];
        [_rightBottomView.layer setBorderWidth:0.5f];
        [_rightBottomView.layer setBorderColor:[UIColor grayColor].CGColor];
        _rightBottomView.userInteractionEnabled = YES;
        _rightBottomView.tag = 203;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftAndRightViewClick:)];
        [_rightBottomView addGestureRecognizer:tap];
    }
    return _rightBottomView;
}
-(UIView *)rightTopView {
    if (!_rightTopView) {
        _rightTopView = [[UIView alloc]init];
        _rightTopView.backgroundColor = [UIColor whiteColor];
        [_rightTopView.layer setBorderWidth:0.5f];
        [_rightTopView.layer setBorderColor:[UIColor grayColor].CGColor];
        _rightTopView.userInteractionEnabled = YES;
        _rightTopView.tag = 202;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftAndRightViewClick:)];
        [_rightTopView addGestureRecognizer:tap];
    }
    return _rightTopView;
}
//左上背景
-(UIView *)leftBgView {
    if (!_leftBgView) {
        _leftBgView = [[UIView alloc]init];
        _leftBgView.backgroundColor = [UIColor whiteColor];
        [_leftBgView.layer setBorderWidth:0.5f];
        [_leftBgView.layer setBorderColor:[UIColor grayColor].CGColor];
        _leftBgView.userInteractionEnabled = YES;
        _leftBgView.tag = 201;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftAndRightViewClick:)];
        [_leftBgView addGestureRecognizer:tap];
    }
    return _leftBgView;
}
-(UIImageView *)rightBottomImgView {
    if (!_rightBottomImgView) {
        _rightBottomImgView = [[UIImageView alloc]init];
        _rightBottomImgView.image = [UIImage imageNamed:@"login_biglogo"];
        _rightBottomImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _rightBottomImgView;
}
-(UILabel *)rightBottomSubTitleLabel {
    if (!_rightBottomSubTitleLabel) {
        _rightBottomSubTitleLabel = [[UILabel alloc]init];
        _rightBottomSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        _rightBottomSubTitleLabel.textColor = LABEL_GRAY_COLOR;
        _rightBottomSubTitleLabel.font = [UIFont systemFontOfSize:12.f];
        _rightBottomSubTitleLabel.text = @"右下红烧猪脚";
    }
    return _rightBottomSubTitleLabel;
}
-(UILabel *)rightBottomTitileLabel {
    if (!_rightBottomTitileLabel) {
        _rightBottomTitileLabel = [[UILabel alloc]init];
        _rightBottomTitileLabel.textAlignment = NSTextAlignmentLeft;
        _rightBottomTitileLabel.textColor = TITLE_YELLOW_COLOR;
        _rightBottomTitileLabel.font = [UIFont systemFontOfSize:15.f];
        _rightBottomTitileLabel.text = @"右下猪脚";
    }
    return _rightBottomTitileLabel;
}
-(UIImageView *)rightTopImgView {
    if (!_rightTopImgView) {
        _rightTopImgView = [[UIImageView alloc]init];
        _rightTopImgView.image = [UIImage imageNamed:@"login_biglogo"];
        _rightTopImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _rightTopImgView;
}
-(UILabel *)rightTopSubTitleLabel {
    if (!_rightTopSubTitleLabel) {
        _rightTopSubTitleLabel = [[UILabel alloc]init];
        _rightTopSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        _rightTopSubTitleLabel.textColor = LABEL_GRAY_COLOR;
        _rightTopSubTitleLabel.font = [UIFont systemFontOfSize:12.f];
        _rightTopSubTitleLabel.text = @"右上红烧猪脚";
    }
    return _rightTopSubTitleLabel;
}
-(UILabel *)rightTopTitileLabel {
    if (!_rightTopTitileLabel) {
        _rightTopTitileLabel = [[UILabel alloc]init];
        _rightTopTitileLabel.textAlignment = NSTextAlignmentLeft;
        _rightTopTitileLabel.textColor = TITLE_YELLOW_COLOR;
        _rightTopTitileLabel.font = [UIFont systemFontOfSize:15.f];
        _rightTopTitileLabel.text = @"右上猪脚";
    }
    return _rightTopTitileLabel;
}

-(UIImageView *)leftImgView {
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc]init];
        _leftImgView.image = [UIImage imageNamed:@"login_biglogo"];
        _leftImgView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _leftImgView;
}
-(UILabel *)leftSubTitleLabel {
    if (!_leftSubTitleLabel) {
        _leftSubTitleLabel = [[UILabel alloc]init];
        _leftSubTitleLabel.textAlignment = NSTextAlignmentLeft;
        _leftSubTitleLabel.textColor = LABEL_GRAY_COLOR;
        _leftSubTitleLabel.font = [UIFont systemFontOfSize:12.f];
        _leftSubTitleLabel.text = @"红烧猪脚蜜汁配方，味道独家";
    }
    return _leftSubTitleLabel;
}
//红色
-(UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc]init];
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        _leftTitleLabel.textColor = TITLE_RED_COLOR;
        _leftTitleLabel.font = [UIFont systemFontOfSize:15.f];
        _leftTitleLabel.text = @"红烧猪脚照吃";
    }
    return _leftTitleLabel;
}


/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param LRpadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
-(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding :(CGFloat)viewPadding {
    UIView *lastView;
    for (UIView *view in views) {
        [containerView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}
-(UIButton *)bottomFourthBtn {
    if (!_bottomFourthBtn) {
        _bottomFourthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomFourthBtn setTitle:@"41223" forState:UIControlStateNormal];
        _bottomFourthBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_bottomFourthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bottomFourthBtn setImage:[UIImage imageNamed:@"login_minilogo"] forState:UIControlStateNormal];
        [_bottomFourthBtn setSize:CGSizeMake(60, 50)];
        _bottomFourthBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomFourthBtn setTitleEdgeInsets:UIEdgeInsetsMake(-self.bottomFourthBtn.imageView.frame.size.height, -self.bottomFourthBtn.imageView.frame.size.width-5, 0, 0)];
        [_bottomFourthBtn setImageEdgeInsets:UIEdgeInsetsMake(self.bottomFourthBtn.titleLabel.frame.size.width, self.bottomFourthBtn.titleLabel.frame.size.height+12, 0, 0)];
        [_bottomFourthBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomFourthBtn.layer setBorderWidth:0.5f];
        [_bottomFourthBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        _bottomFourthBtn.tag = 104;
    }
    return _bottomFourthBtn;
}
-(UIButton *)bottomThirdBtn {
    if (!_bottomThirdBtn) {
        _bottomThirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomThirdBtn setTitle:@"41223" forState:UIControlStateNormal];
        _bottomThirdBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_bottomThirdBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bottomThirdBtn setImage:[UIImage imageNamed:@"login_minilogo"] forState:UIControlStateNormal];
        [_bottomThirdBtn setSize:CGSizeMake(60, 50)];
        _bottomThirdBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomThirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(-self.bottomThirdBtn.imageView.frame.size.height, -self.bottomThirdBtn.imageView.frame.size.width-5, 0, 0)];
        [_bottomThirdBtn setImageEdgeInsets:UIEdgeInsetsMake(self.bottomThirdBtn.titleLabel.frame.size.width, self.bottomThirdBtn.titleLabel.frame.size.height+12, 0, 0)];
        [_bottomThirdBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomThirdBtn.layer setBorderWidth:0.5f];
        [_bottomThirdBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        _bottomThirdBtn.tag = 103;
    }
    return _bottomThirdBtn;
}

-(UIButton *)bottomSecondBtn {
    if (!_bottomSecondBtn) {
        _bottomSecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomSecondBtn setTitle:@"41223" forState:UIControlStateNormal];
        _bottomSecondBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_bottomSecondBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bottomSecondBtn setImage:[UIImage imageNamed:@"login_minilogo"] forState:UIControlStateNormal];
        
        [_bottomSecondBtn setSize:CGSizeMake(60, 50)];
        _bottomSecondBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomSecondBtn setTitleEdgeInsets:UIEdgeInsetsMake(-self.bottomSecondBtn.imageView.frame.size.height, -self.bottomSecondBtn.imageView.frame.size.width-5, 0, 0)];
        [_bottomSecondBtn setImageEdgeInsets:UIEdgeInsetsMake(self.bottomSecondBtn.titleLabel.frame.size.width, self.bottomSecondBtn.titleLabel.frame.size.height+12, 0, 0)];
        [_bottomSecondBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomSecondBtn.layer setBorderWidth:0.5f];
        [_bottomSecondBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        _bottomSecondBtn.tag = 102;
    }
    return _bottomSecondBtn;
}
-(UIButton *)bottomFirstBtn {
    if (!_bottomFirstBtn) {
        _bottomFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomFirstBtn setTitle:@"41223" forState:UIControlStateNormal];
        _bottomFirstBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_bottomFirstBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_bottomFirstBtn setImage:[UIImage imageNamed:@"login_minilogo"] forState:UIControlStateNormal];
        
        [_bottomFirstBtn setSize:CGSizeMake(60, 50)];
        _bottomFirstBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomFirstBtn setTitleEdgeInsets:UIEdgeInsetsMake(-self.bottomFirstBtn.imageView.frame.size.height, -self.bottomFirstBtn.imageView.frame.size.width-5, 0, 0)];
        [_bottomFirstBtn setImageEdgeInsets:UIEdgeInsetsMake(self.bottomFirstBtn.titleLabel.frame.size.width, self.bottomFirstBtn.titleLabel.frame.size.height+12, 0, 0)];
        [_bottomFirstBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomFirstBtn.layer setBorderWidth:0.5f];
        [_bottomFirstBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        _bottomFirstBtn.tag = 101;
    }
    return _bottomFirstBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
