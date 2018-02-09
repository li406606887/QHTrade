//
//  DynamicsNavigationCenterView.m
//  QHTrade
//
//  Created by user on 2017/6/2.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DynamicsNavigationCenterView.h"
#import <sys/utsname.h>


@interface DynamicsNavigationCenterView()
@property(nonatomic,strong)UIView *transparentView;

@property(nonatomic,strong)UIImageView *logoImage;

@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation DynamicsNavigationCenterView

-(void)setupViews{

    [self addSubview:self.transparentView];
    [self addSubview:self.logoImage];
    [self addSubview:self.titleLabel];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{

    [super updateConstraints];
    @weakify(self)
    [self.transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(20, 34));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.leftMargin.equalTo(self.logoImage.mas_right).with.offset(10);
        make.rightMargin.equalTo(self);
        make.height.offset(30);
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)transparentView{

    if (!_transparentView) {
        _transparentView = [[UIView alloc] init];
        _transparentView.backgroundColor = [UIColor blackColor];
        _transparentView.alpha = 0.4;
    }
    return _transparentView;
}
-(UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.image = [UIImage imageNamed:@"dynamics_navigation_centerView_logo"];
        _logoImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"权益:1234.56W 可用:1234.56W";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
@end
