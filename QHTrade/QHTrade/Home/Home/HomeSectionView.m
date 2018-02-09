//
//  HomeSectionView.m
//  QHTrade
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeSectionView.h"

@interface HomeSectionView ()
@property(nonatomic,strong) UIView *redView;
@property(nonatomic,strong) UIView *backView;
//@property(nonatomic,strong) UIView *middleLine;
@end

@implementation HomeSectionView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.backView];
    [self addSubview:self.redView];
    [self addSubview:self.sectionTitle];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 20));
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(3, 20));
    }];
    
    [self.sectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self.redView.mas_right).with.offset(5);
        make.size.mas_offset(CGSizeMake(99, 20));
    }];
}

-(UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc]init];
        _sectionTitle.font = [UIFont systemFontOfSize:18.0f];
    }
    return _sectionTitle;
}
-(UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = RGB(255, 98, 1);
    }
    return _redView;
}
-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

@end
