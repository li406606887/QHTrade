//
//  SetingProportionView.m
//  QHTrade
//
//  Created by user on 2017/11/21.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SetingProportionView.h"
#import "FollowSetingViewModel.h"

@interface SetingProportionView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) UIButton *oneToOne;
@property(nonatomic,strong) UIButton *twoToOne;
@property(nonatomic,strong) UIButton *fiveToOne;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) NSArray *proportionArray;
@property(nonatomic,assign) int oldIndex;
@end

@implementation SetingProportionView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.title];
    [self addSubview:self.pickerView];
    [self addSubview:self.prompt];
    [self.pickerView selectRow:4 inComponent:2 animated:YES];

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
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
//        make.height.equalTo(self);
        make.size.mas_offset(CGSizeMake(280, 85));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pickerView.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-52, 30));
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = 1;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = 1;//根据数组的元素个数返回几行数据
            break;
        case 2:
            result = 9;
            break;
        default:
            break;
    }
    return result;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch (component) {
        case 0:
            title = @"1";
            break;
        case 1:
            title = @":";
            break;
        case 2:
            title = self.proportionArray[row];
            break;
        default:
            break;
    }
    return title;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 2) {
        self.viewModel.setingModel.numScale = self.proportionArray[row];
        [self.viewModel.valueChangeSubject sendNext:nil];
    }
    
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
        _title.text = @"每笔跟单手数比例:";
    }
    return _title;
}

-(UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.text = @"实际跟单中手数不足1手以1手进行跟单";
        _prompt.font = [UIFont systemFontOfSize:12];
    }
    return _prompt;
}

-(UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(NSArray *)proportionArray {
    if (!_proportionArray) {
        _proportionArray = [NSArray arrayWithObjects:@"0.1",@"0.2",@"0.25",@"0.5",@"1",@"2",@"3",@"4",@"5", nil];
    }
    return _proportionArray;
}
@end
