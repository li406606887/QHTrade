//
//  FollowEarningsTopThreeCell.m
//  QHTrade
//
//  Created by user on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsTopThreeCell.h"

@interface FollowEarningsTopThreeCell()
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UIImageView *crownIcon;
@property(nonatomic,strong) UIImageView *crownNum;
@property(nonatomic,strong) UILabel *name;//名称
@property(nonatomic,strong) UILabel *followAmount;//跟单人数
@property(nonatomic,strong) UILabel *earningsRate;//收益率
@property(nonatomic,strong) UILabel *totalProfit;//总盈利
@end

@implementation FollowEarningsTopThreeCell
- (void)setupViews {
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.crownIcon];
    [self.contentView addSubview:self.crownNum];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.followAmount];
    [self.contentView addSubview:self.earningsRate];
    [self.contentView addSubview:self.totalProfit];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 12, 10, 12));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(15);
        make.centerX.equalTo(self.crownNum);
        make.size.mas_offset(CGSizeMake(47, 47));
    }];
    
    [self.crownIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.contentView).with.offset(6.5);
        make.right.equalTo(self.icon.mas_right).with.offset(2);
        make.size.mas_offset(CGSizeMake(22, 17));
    }];
    
    [self.crownNum mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(69, 16));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.icon.mas_right).with.offset(16);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(140,17));
    }];
    
    [self.followAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.icon.mas_right).with.offset(16);
        make.top.equalTo(self.name.mas_bottom).with.offset(4);
        make.size.mas_offset(CGSizeMake(80,15));
    }];
    
    [self.earningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.contentView).with.offset(SCREEN_WIDTH*0.5);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(50,32));
    }];
    
    [self.totalProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(50,32));
    }];
}

-(void)setTag:(NSInteger)tag{
    int index = (int)tag;
    NSString *imageIcon = [NSString stringWithFormat:@"Awesome_FollowEarnings_No.%d",index+1];
    NSString *imageNum = [NSString stringWithFormat:@"Awesome_FollowEarnings_Logo_No.%d",index+1];
    self.crownIcon.image = [UIImage imageNamed:imageIcon];
    self.crownNum.image = [UIImage imageNamed:imageNum];
    self.contentView.layer.borderWidth = 1.0f;
    switch (index) {
        case 0:
            self.contentView.layer.borderColor = RGB(254, 229, 183).CGColor;
            break;
        case 1:
            self.contentView.layer.borderColor = RGB(254, 199, 182).CGColor;
            break;
        case 2:
            self.contentView.layer.borderColor = RGB(180, 221, 254).CGColor;
            break;
        default:
            break;
    }
}

-(void)setModel:(FollowEarningsModel *)model{
    if (model) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.name.text = model.userName;
        NSString* incomeRate = [NSString stringWithFormat:@"%.2f",[model.incomeRate floatValue]*100];
        NSString *totalIncome = [NSString stringWithFormat:@"%.2f",[model.totalIncome floatValue]*100];
        self.followAmount.text = [NSString stringWithFormat:@"跟单:%@人",model.count];
        self.earningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"收益率\n%@%%",incomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB( 49, 49, 49) range:NSMakeRange(0, 3)];
        self.totalProfit.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总盈利\n%@",totalIncome] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB( 49, 49, 49) range:NSMakeRange(0, 3)];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 23.5;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _icon;
}
- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
        _name.text = @"I'm rookie";
    }
    return _name;
}

- (UILabel *)followAmount {
    if (!_followAmount) {
        _followAmount = [[UILabel alloc] init];
        _followAmount.font = [UIFont systemFontOfSize:12];
        _followAmount.textColor = RGB(49, 49, 49);
        _followAmount.text = @"跟单:1341人";
    }
    return _followAmount;
}

- (UILabel *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [[UILabel alloc] init];
        _earningsRate.attributedText = [NSAttributedString getAttributedStringWithString:@"收益率\n818%" littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB( 49, 49, 49) range:NSMakeRange(0, 3)];
        _earningsRate.numberOfLines =2;
    }
    return _earningsRate;
}

- (UILabel *)totalProfit {
    if (!_totalProfit) {
        _totalProfit = [[UILabel alloc] init];
        _totalProfit.attributedText = [NSAttributedString getAttributedStringWithString:@"总盈利\n1234567890" littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB( 49, 49, 49) range:NSMakeRange(0, 3)];
        _totalProfit.numberOfLines =2;
    }
    return _totalProfit;
}

-(UIImageView *)crownIcon {
    if (!_crownIcon) {
        _crownIcon = [[UIImageView alloc] init];
        _crownIcon.image = [UIImage imageNamed:@"Awesome_FollowEarnings_No.1"];
    }
    return _crownIcon;
}

-(UIImageView *)crownNum {
    if (!_crownNum) {
        _crownNum = [[UIImageView alloc] init];
        _crownNum.image = [UIImage imageNamed:@"Awesome_FollowEarnings_Logo_No.1"];
    }
    return _crownNum;
}

@end
