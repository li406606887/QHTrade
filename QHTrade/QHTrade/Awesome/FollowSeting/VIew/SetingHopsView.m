//
//  SetingHopsView.m
//  QHTrade
//
//  Created by user on 2017/11/23.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SetingHopsView.h"
#import "FollowSetingViewModel.h"

@interface SetingHopsView()
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UIButton *one;
@property(nonatomic,strong) UIButton *two;
@property(nonatomic,strong) UIButton *five;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) NSMutableArray *buttonArray;
@property(nonatomic,assign) int oldIndex;
@end

@implementation SetingHopsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.title];
    [self addSubview:self.one];
    [self addSubview:self.two];
    [self addSubview:self.five];
    [self addSubview:self.prompt];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-42, 30));
    }];
    
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).with.offset(-100);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.five mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).with.offset(100);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.two.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-52, 30));
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.text = @"每笔跟单跳点:";
    }
    return _title;
}

-(UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.text = @"跳点仅在以牛人成交价委托并发生无法成交情况下才会启用";
        _prompt.font = [UIFont systemFontOfSize:12];
    }
    return _prompt;
}

-(UIButton *)one {
    if (!_one) {
        _one = [self creatButtonWithTitle:@"1点" tag:0];
    }
    return _one;
}

-(UIButton *)two {
    if (!_two) {
        _two = [self creatButtonWithTitle:@"2点" tag:1];
    }
    return _two;
}

-(UIButton *)five {
    if (!_five) {
        _five = [self creatButtonWithTitle:@"3点" tag:2];
    }
    return _five;
}

-(NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}

-(UIButton *)creatButtonWithTitle:(NSString *)title tag:(long)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:RGB(239, 92, 1) forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.tag = tag;
    button.layer.borderColor = RGB(222, 222, 222).CGColor;
    button.layer.borderWidth = 0.5;
    button.selected = self.viewModel.setingModel.jumpPoint == tag ? YES: NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitleColor:RGB(239, 92, 1) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonArray addObject:button];
    return button;
}

-(void)buttonClick:(UIButton*)btn {
    int index = (int)btn.tag;
    UIButton *oldButton = self.buttonArray[self.oldIndex];
    UIButton *button = self.buttonArray[index];
    if (oldButton == button) {
        return;
    }
    button.selected = YES;
    oldButton.selected = NO;
    self.oldIndex = index;
    self.viewModel.setingModel.jumpPoint = btn.tag;
    [self.viewModel.valueChangeSubject sendNext:nil];
}
-(int)oldIndex {
    if (!_oldIndex) {
        _oldIndex = (int)self.viewModel.setingModel.jumpPoint;
    }
    return _oldIndex;
}

@end
