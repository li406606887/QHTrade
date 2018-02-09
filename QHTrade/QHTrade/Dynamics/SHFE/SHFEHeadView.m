//
//  SHFEHeadView.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SHFEHeadView.h"
#import "SHFEViewModel.h"

@interface SHFEHeadView()
@property(nonatomic,strong)UILabel *typeName;
@property(nonatomic,strong)UILabel *news;
@property(nonatomic,strong)UIButton *upWithFalling;//涨幅和涨跌按钮
@property(nonatomic,strong)UIButton *volume;//成交量or持仓量or日增仓
@property(nonatomic,strong)SHFEViewModel *buttonClickViewModel;
@end

@implementation SHFEHeadView

-(void)setupViews{
    
    [self addSubview:self.typeName];
    [self addSubview:self.news];
    [self addSubview:self.upWithFalling];
    [self addSubview:self.volume];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.buttonClickViewModel = (SHFEViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/4, 30));
    }];
    
    [self.news mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.left.equalTo(self.typeName.mas_right).with.offset(0.5f);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/4, 30));
    }];
    
    [self.upWithFalling mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.left.equalTo(self.news.mas_right).with.offset(0.5f);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/4, 30));
    }];
    
    [self.volume mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self);
        make.left.equalTo(self.upWithFalling.mas_right).with.offset(0.5f);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH/4-1.5f, 30));
    }];
}

-(UILabel *)typeName{
    if (!_typeName) {
        _typeName = [[UILabel alloc] init];
        _typeName.text = @"名称";
        _typeName.backgroundColor = RGB(239, 239, 239);
        _typeName.font = [UIFont systemFontOfSize:14];
        _typeName.textColor = RGB(138, 138, 138);
        _typeName.textAlignment = NSTextAlignmentCenter;
    }
    return _typeName;
}
-(UILabel *)news{
    if (!_news) {
        _news = [[UILabel alloc] init];
        _news.text = @"最新";
        _news.backgroundColor = RGB(239, 239, 239);
        _news.font = [UIFont systemFontOfSize:14];
        _news.textColor = RGB(138, 138, 138);
        _news.textAlignment = NSTextAlignmentCenter;
    }
    return _news;
}
-(UIButton *)upWithFalling{
    if(!_upWithFalling){
        _upWithFalling = [UIButton buttonWithType:UIButtonTypeCustom];
        _upWithFalling.backgroundColor = RGB(142, 142, 142);
        [_upWithFalling setBackgroundImage:[UIImage imageWithStretchableName:@"dynamics_childView_Section" orginX:1 orginY:1] forState:UIControlStateNormal];
        _upWithFalling.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_upWithFalling setTitle:@"涨幅%" forState:UIControlStateNormal];
        
    }
    return _upWithFalling;
}
-(UIButton *)volume{
    if(!_volume){
        _volume = [UIButton buttonWithType:UIButtonTypeCustom];
        _volume.backgroundColor = RGB(142, 142, 142);
        _volume.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_volume setBackgroundImage:[UIImage imageWithStretchableName:@"dynamics_childView_Section" orginX:1 orginY:1] forState:UIControlStateNormal];
        [_volume setTitle:@"成交量" forState:UIControlStateNormal];
    }
    return _volume;
}


@end
