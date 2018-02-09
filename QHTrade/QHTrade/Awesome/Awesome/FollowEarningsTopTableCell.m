//
//  FollowEarningsTopTableCell.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsTopTableCell.h"

@interface FollowEarningsTopTableCell()
@property(nonatomic,strong) UIImageView *icon;//头像
@property(nonatomic,strong) UILabel *name;//名称
@property(nonatomic,strong) UILabel *followAmount;//跟单人数
@property(nonatomic,strong) UILabel *earningsRate;//收益率
@property(nonatomic,strong) UILabel *totalProfit;//总盈利
@end


@implementation FollowEarningsTopTableCell
- (void)setupViews {
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = RGB(222, 222, 222).CGColor;
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.icon];
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
        make.left.equalTo(self.contentView).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
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
-(void)setModel:(FollowEarningsModel *)model{
    if (model) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        self.name.text = model.userName;
        NSString* incomeRate =   model.incomeRate.length<1 ? @"0.00" :[NSString stringWithFormat:@"%.2f",[model.incomeRate floatValue]*100];
        NSString* totalIncome = model.totalIncome.length<1 ? @"0.00":[NSString stringWithFormat:@"%@",model.totalIncome];
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

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _icon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}

-(UILabel *)followAmount {
    if (!_followAmount) {
        _followAmount = [[UILabel alloc] init];
        _followAmount.font = [UIFont systemFontOfSize:12];
        _followAmount.textColor = RGB(49, 49, 49);
    }
    return _followAmount;
}

-(UILabel *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [[UILabel alloc] init];
        
        _earningsRate.numberOfLines =2;
    }
    return _earningsRate;
}

-(UILabel *)totalProfit {
    if (!_totalProfit) {
        _totalProfit = [[UILabel alloc] init];
        _totalProfit.numberOfLines =2;
    }
    return _totalProfit;
}
@end
