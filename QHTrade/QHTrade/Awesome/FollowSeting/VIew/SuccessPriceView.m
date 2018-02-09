//
//  SuccessPriceView.m
//  QHTrade
//
//  Created by user on 2017/11/22.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SuccessPriceView.h"
#import "FollowSetingViewModel.h"

@interface SuccessPriceView()
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) UIButton *transactionPrice;
@property(nonatomic,strong) UIButton *marketValue;
@property(nonatomic,strong) UIButton *selectedBtn;
@end

@implementation SuccessPriceView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.title];
    [self addSubview:self.prompt];
    [self addSubview:self.transactionPrice];
    [self addSubview:self.marketValue];
    if (self.viewModel.setingModel.priceType==0) {
        self.selectedBtn = self.transactionPrice;
    }else {
        self.selectedBtn = self.marketValue;
    }
    self.selectedBtn.selected = YES;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    [self.transactionPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        make.centerX.equalTo(self).with.offset(-80);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.marketValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transactionPrice);
        make.centerX.equalTo(self).with.offset(80);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.marketValue.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(200, 20));
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
        _title.text = @"每笔跟单委托价位:";
    }
    return _title;
}

-(UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.text = @"如不支持市价，以涨跌停价委托";
        _prompt.font = [UIFont systemFontOfSize:12];
    }
    return _prompt;
}

-(UIButton *)transactionPrice {
    if (!_transactionPrice) {
        _transactionPrice = [self creatButtonWithTitle:@"牛人成交价" tag:0];
    }
    return _transactionPrice;
}

-(UIButton *)marketValue {
    if (!_marketValue) {
        _marketValue = [self creatButtonWithTitle:@"合约市价" tag:1];
    }
    return _marketValue;
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
    button.adjustsImageWhenHighlighted = NO;
    [button setTitleColor:RGB(239, 92, 1) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)buttonClick:(UIButton*)btn {
    if (self.selectedBtn == btn) return;
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    self.viewModel.setingModel.priceType = btn.tag;
    [self.viewModel.valueChangeSubject sendNext:nil];
    [self.viewModel.successPriceClick sendNext:[NSString stringWithFormat:@"%ldd",btn.tag]];
}
@end
