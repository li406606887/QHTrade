//
//  ChooseDateView.m
//  QHTrade
//
//  Created by user on 2017/12/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChooseDateView.h"
#import "HistorySignalViewModel.h"

@interface ChooseDateView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) HistorySignalViewModel *viewModel;
@property(nonatomic,strong) UIView *dateView;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) UIButton *sureBtn;
@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,copy  ) NSString *selectString;
@end

@implementation ChooseDateView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HistorySignalViewModel *)viewModel;
    return  [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [self addSubview:self.dateView];
    [self addSubview:self.closeBtn];
    [self.dateView addSubview:self.title];
    [self.dateView addSubview:self.pickerView];
    [self.dateView addSubview:self.sureBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(170, 180));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateView.mas_right).with.offset(-8);
        make.bottom.equalTo(self.dateView.mas_top).with.offset(12);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dateView);
        make.top.equalTo(self.dateView).with.offset(16);
        make.size.mas_offset(CGSizeMake(180, 18));
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(22);
        make.centerX.equalTo(self.title);
        make.size.mas_offset(CGSizeMake(126, 80));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView.mas_bottom).with.offset(11);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(126, 25));
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.viewModel.tradingMonthArray.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.viewModel.tradingMonthArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectString = self.viewModel.tradingMonthArray[row];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)dateView {
    if (!_dateView) {
        _dateView = [[UIView alloc] init];
        _dateView.backgroundColor = [UIColor whiteColor];
        _dateView.layer.masksToBounds = YES;
        _dateView.layer.cornerRadius = 10;
    }
    return _dateView;
}

-(UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"Awesome_History_Close"] forState:UIControlStateNormal];
        @weakify(self)
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self removeFromSuperview];
        }];
    }
    return _closeBtn;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.text = @"选择日期";
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = RGB(51, 51, 51);
    }
    return _title;
}

-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 5;
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside ] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self removeFromSuperview];
            [self.viewModel.tradingSignalsArray removeAllObjects];
            self.viewModel.month = self.selectString;
            [self.viewModel.tradeSignalsCommand execute:@"1"];
        }];
    }
    return _sureBtn;
}
@end
