//
//  EvaluationViewCell.m
//  QHTrade
//
//  Created by user on 2017/11/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EvaluationViewCell.h"

@interface EvaluationViewCell()
@property(nonatomic,strong) UIImageView *userIcon;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *time;
@property(nonatomic,strong) UILabel *evaluation;
@end

@implementation EvaluationViewCell
-(void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.userIcon];
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.evaluation];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(6, 10, 0, 10));
    }];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(6);
        make.top.equalTo(self.contentView).with.offset(6);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).with.offset(8);
        make.top.equalTo(self.userIcon);
        make.size.mas_offset(CGSizeMake(300, 15));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).with.offset(6);
        make.left.equalTo(self.userIcon.mas_right).with.offset(8);
        make.size.mas_offset(CGSizeMake(200, 12));
    }];
    
    [self.evaluation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).with.offset(8);
        make.centerX.equalTo(self.contentView);
        make.width.offset(SCREEN_WIDTH-40);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-6);
    }];
}

-(void)setModel:(EvaluationModel *)model {
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.userImg] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
    self.userName.text = model.userName;
    self.time.text = [NSDate getReleaseDate:model.createDate format:@"yyyy-MM-dd hh:mm"];
    self.evaluation.text = model.evaluate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.backgroundColor = [UIColor greenColor];
        _userIcon.layer.masksToBounds = YES;
        _userIcon.layer.cornerRadius = 15;
        _userIcon.image = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _userIcon;
}

-(UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.text = @"哈哈哈哈哈哈";
        _userName.textColor = RGB(51, 51, 51);
        _userName.font = [UIFont systemFontOfSize:15];
    }
    return _userName;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = RGB(150, 150, 150);
        _time.font = [UIFont systemFontOfSize:12];
        _time.text = @"2017-09-01 12:10";
    }
    return _time;
}

-(UILabel *)evaluation {
    if (!_evaluation) {
        _evaluation = [[UILabel alloc] init];
        _evaluation.font = [UIFont systemFontOfSize:14];
        _evaluation.textColor = RGB(85, 85, 85);
        _evaluation.numberOfLines = 0;
    }
    return _evaluation;
}
@end
