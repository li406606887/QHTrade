//
//  AwesomeTableViewCell.m
//  QHTrade
//
//  Created by user on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeTableViewCell.h"

@interface AwesomeTableViewCell()
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UILabel *awesomeName;//牛人名称
@property(nonatomic,strong) UIImageView *labelImageView;//牛人标签
@property(nonatomic,strong) UILabel *awesomeLabelOne;//标签1
@property(nonatomic,strong) UILabel *awesomeLabelTwo;//标签2
@property(nonatomic,strong) UILabel *awesomeLabelThree;//标签3
@property(nonatomic,strong) UILabel *awesomeLabelFour;//标签4
@property(nonatomic,strong) UILabel *earningsRate;//收益率
@property(nonatomic,strong) UILabel *todayEarningsRate;//今日收益率
@property(nonatomic,strong) UILabel *positionsUsage;//仓位使用率
@property(nonatomic,strong) UILabel *positionNumber;//持仓数
@property(nonatomic,strong) UILabel *maximumProfit;//单笔最大利润
@property(nonatomic,strong) UILabel *winningProbability;//获胜概率
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *subscribeNum;//订阅数
@property(nonatomic,strong) UIImageView *partingLine;//分割线
@property(nonatomic,strong) UIButton *followAction;//跟单按钮
@property(nonatomic,assign) int state;
@end

@implementation AwesomeTableViewCell
-(void)setupViews {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.shadowOffset = CGSizeMake(3, 3);
    self.contentView.layer.shadowRadius = 3.0;
    self.contentView.layer.shadowOpacity = 0.1;
    self.contentView.clipsToBounds = NO;
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.awesomeName];
    [self.contentView addSubview:self.labelImageView];
    [self.contentView addSubview:self.awesomeLabelOne];
    [self.contentView addSubview:self.awesomeLabelTwo];
    [self.contentView addSubview:self.awesomeLabelThree];
    [self.contentView addSubview:self.awesomeLabelFour];
    [self.contentView addSubview:self.earningsRate];
    [self.contentView addSubview:self.todayEarningsRate];
    [self.contentView addSubview:self.positionsUsage];
    [self.contentView addSubview:self.positionNumber];
    [self.contentView addSubview:self.maximumProfit];
    [self.contentView addSubview:self.partingLine];
    [self.contentView addSubview:self.winningProbability];
    [self.contentView addSubview:self.subscribeNum];
    [self.contentView addSubview:self.followAction];
    [self.contentView addSubview:self.line];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(12);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
    
    [self.awesomeName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(300, 15));
    }];
    
    [self.labelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(14, 14));
    }];
    
    [self.awesomeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelImageView.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelOne.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelTwo.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];
    
    [self.awesomeLabelFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeLabelThree.mas_right).with.offset(5);
        make.top.equalTo(self.awesomeName.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(50, 14));
    }];

    [self.earningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView).with.offset(-(SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.icon.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];

    [self.todayEarningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.icon.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];

    [self.positionsUsage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView).with.offset((SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.icon.mas_bottom).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];

    [self.positionNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView).with.offset(-(SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.maximumProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.winningProbability mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.contentView).with.offset((SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.positionNumber.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 0.5));
    }];
    
    [self.subscribeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.offset(40);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
    }];
    
    [self.partingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.subscribeNum);
        make.centerX.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(1, 30));
    }];
    
    [self.followAction mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.offset(40);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.5);
    }];
}

-(void)setModel:(AwesomeModel *)model{
    if (model) {
        _model = model;
        self.awesomeName.text = model.userName;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",imageLink,model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        NSString* incomeRate = [NSString stringWithFormat:@"%.2f",[model.referenceIncomeRate floatValue]*100];
        NSString* todayIncomeRate = [NSString stringWithFormat:@"%.2f",[model.todayIncomeRate floatValue]*100];
        NSString* positionRate = [NSString stringWithFormat:@"%.2f",[model.positionRate floatValue]*100];
        self.earningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"参考收益率\n%@%%",incomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        self.todayEarningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"今日收益率\n%@%%",todayIncomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        
        self.positionsUsage.attributedText =[NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"仓位情况\n%@%%",positionRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 4)];
        
        self.positionNumber.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总交易手数\n%@",model.totalTradeNum] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        self.maximumProfit.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"最新净值\n%@",model.netWorthToday] littlefont:10 bigFont:15 defultTextColor:RGB(50, 50, 50) specialColor:[UIColor blackColor] range:NSMakeRange(0, 4)];
        self.winningProbability.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"年化收益率\n%.2f%%",[model.annualYield floatValue]] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        self.subscribeNum.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"订阅数:%@",model.subNumber] littlefont:15 bigFont:15 defultTextColor:RGB(239, 92, 1) specialColor:RGB(51, 51, 51) range:NSMakeRange(0, 3)];
        NSString *followActionTitle = [model.isFollows intValue]==1 ? @"已跟单": @"跟单";
        self.state = [model.isFollows intValue]==1 ? 1:0;
        [self.followAction setTitle:followActionTitle forState:UIControlStateNormal];
        
        NSArray *labelArray = [model.labels componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        for (int i = 0 ;i<labelArray.count;i++) {
            switch (i) {
                case 0:
                    self.awesomeLabelOne.text = labelArray[i];
                    break;
                case 1:
                    self.awesomeLabelTwo.text = labelArray[i];
                    break;
                case 2:
                    self.awesomeLabelThree.text = labelArray[i];
                    break;
                case 3:
                    self.awesomeLabelFour.text = labelArray[i];
                    break;
                default:
                    break;
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _icon;
}

-(UILabel *)awesomeName {
    if (!_awesomeName) {
        _awesomeName = [[UILabel alloc] init];
        _awesomeName.textColor = RGB(66, 66, 66);
        _awesomeName.font = [UIFont systemFontOfSize:15];
    }
    return _awesomeName;
}

-(UIImageView *)labelImageView {
    if (!_labelImageView) {
        _labelImageView = [[UIImageView alloc] init];
        _labelImageView.image = [UIImage imageNamed:@"Awesome_Label"];
    }
    return _labelImageView;
}

-(UILabel *)awesomeLabelOne {
    if (!_awesomeLabelOne) {
        _awesomeLabelOne = [self creatLabelWithStyle];
        _awesomeLabelOne.text = @"一二三四";
    }
    return _awesomeLabelOne;
}

-(UILabel *)awesomeLabelTwo {
    if (!_awesomeLabelTwo) {
        _awesomeLabelTwo = [self creatLabelWithStyle];
        _awesomeLabelTwo.text = @"一二三四";
    }
    return _awesomeLabelTwo;
}

-(UILabel *)awesomeLabelThree {
    if (!_awesomeLabelThree) {
        _awesomeLabelThree = [self creatLabelWithStyle];
        _awesomeLabelThree.text = @"一二三四";
    }
    return _awesomeLabelThree;
}

-(UILabel *)awesomeLabelFour {
    if (!_awesomeLabelFour) {
        _awesomeLabelFour = [self creatLabelWithStyle];
        _awesomeLabelFour.text = @"一二三四";
    }
    return _awesomeLabelFour;
}

-(UILabel *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [self creatBackImageLabel];
    }
    return _earningsRate ;
}

-(UILabel *)todayEarningsRate {
    if (!_todayEarningsRate) {
        _todayEarningsRate = [self creatBackImageLabel];
    }
    return _todayEarningsRate ;
}

-(UILabel *)positionsUsage {
    if (!_positionsUsage) {
        _positionsUsage = [self creatBackImageLabel];
    }
    return _positionsUsage;
}

-(UILabel *)positionNumber {
    if (!_positionNumber) {
        _positionNumber = [self creatBackImageLabel];
    }
    return _positionNumber;
}

-(UILabel *)maximumProfit {
    if (!_maximumProfit) {
        _maximumProfit = [self creatBackImageLabel];
    }
    return _maximumProfit;
}

-(UILabel *)winningProbability {
    if (!_winningProbability) {
        _winningProbability = [self creatBackImageLabel];
    }
    return _winningProbability;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(255, 175, 125);
    }
    return _line;
}

-(UILabel *)subscribeNum {
    if (!_subscribeNum) {
        _subscribeNum = [[UILabel alloc] init];
        _subscribeNum.textColor = RGB(252, 179, 43);
        _subscribeNum.font = [UIFont systemFontOfSize:12];
        _subscribeNum.textAlignment = NSTextAlignmentCenter;
    }
    return _subscribeNum;
}

-(UIImageView *)partingLine {
    if (!_partingLine) {
        _partingLine = [[UIImageView alloc] init];
        _partingLine.image = [UIImage imageNamed:@"Group_Icon_Dividing_Line"];
    }
    return _partingLine;
}

-(UIButton *)followAction {
    if (!_followAction) {
        _followAction = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followAction setTitle:@"跟单" forState:UIControlStateNormal];
        [_followAction setTitleColor:RGB(239, 92, 1) forState:UIControlStateNormal];
        _followAction.layer.masksToBounds = YES;
        _followAction.layer.cornerRadius = 3;
        [[_followAction rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.state==1) {
                showMassage(@"已跟单");
                return ;
            }
            if ([[UserInformation getInformation].userModel.isFollows intValue]==1) {
                showMassage(@"只能跟单一个牛人")
                return;
            }
            self.FollowAwesomeBlock(self.model);
        }];
        [_followAction.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _followAction;
}

-(UILabel*)creatBackImageLabel{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setImage:[UIImage imageNamed:@"personal_dikuang"]];
    [label addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label);
    }];
    return label;
}

-(UILabel *)creatLabelWithStyle {
    UILabel *title = [[UILabel alloc] init];
    title.layer.borderWidth = 0.5f;
    title.layer.borderColor = RGB(239, 92, 1).CGColor;
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 3;
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = RGB(239, 92, 1);
    title.textAlignment = NSTextAlignmentCenter;
    return title;
}
@end
