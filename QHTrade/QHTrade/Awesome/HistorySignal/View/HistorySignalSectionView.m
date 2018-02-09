//
//  HistorySignalSectionView.m
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HistorySignalSectionView.h"

@interface HistorySignalSectionView ()
@property(nonatomic,strong) UIButton *swichBtn;
@property(nonatomic,strong) UIView *backView;
@end

@implementation HistorySignalSectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.backView addSubview:self.swichBtn];
        [self.backView addSubview:self.title];
    }
    return self;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 25)];
        _backView.backgroundColor = RGB(236, 236, 236);
    }
    return _backView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIButton *)swichBtn {
    if (!_swichBtn) {
        _swichBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_swichBtn setImage:[UIImage imageNamed:@"Awesome_HistoryTradingSignalSwitch_Nomarl"] forState:UIControlStateNormal];
        [_swichBtn setImage:[UIImage imageNamed:@"Awesome_HistoryTradingSignalSwitch_Selected"] forState:UIControlStateSelected];
        [_swichBtn setFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 25)];
//        [[_swichBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        }];
    }
    return _swichBtn;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 25)];
        _title.textColor = RGB(85, 85, 85);
        _title.font = [UIFont systemFontOfSize:14];
    }
    return _title;
}
@end
