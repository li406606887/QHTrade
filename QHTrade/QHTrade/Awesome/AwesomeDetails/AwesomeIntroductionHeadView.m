//
//  AwesomeIntroductionHeadView.m
//  QHTrade
//
//  Created by user on 2017/11/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeIntroductionHeadView.h"
#import "AwesomeDetailsViewModel.h"

@interface AwesomeIntroductionHeadView()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UILabel *earningsRate;//收益率
@property(nonatomic,strong) UILabel *todayEarningsRate;//今日收益率
@property(nonatomic,strong) UILabel *positionsUsage;//仓位使用率
@property(nonatomic,strong) UILabel *positionNumber;//持仓数
@property(nonatomic,strong) UILabel *maximumProfit;//单笔最大利润
@property(nonatomic,strong) UILabel *winningProbability;//获胜概率
@end

@implementation AwesomeIntroductionHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.earningsRate];
    [self addSubview:self.todayEarningsRate];
    [self addSubview:self.positionsUsage];
    [self addSubview:self.positionNumber];
    [self addSubview:self.maximumProfit];
    [self addSubview:self.winningProbability];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)updateConstraints {
    [super updateConstraints];
    [self.earningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset(-(SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.todayEarningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.positionsUsage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset((SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self).with.offset(12);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.positionNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset(-(SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.maximumProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
    
    [self.winningProbability mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).with.offset((SCREEN_WIDTH-30)*0.33);
        make.top.equalTo(self.earningsRate.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(80, 40));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.awesomeRefreshUISubject subscribeNext:^(AwesomeModel*  _Nullable model) {
        @strongify(self)
        self.viewModel.model = model;
        NSString* incomeRate = [NSString stringWithFormat:@"%.2f",[model.referenceIncomeRate floatValue]*100];
        NSString* todayIncomeRate = [NSString stringWithFormat:@"%.2f",[model.todayIncomeRate floatValue]*100];
        NSString* positionRate = [NSString stringWithFormat:@"%.2f",[model.positionRate floatValue]*100];
        self.earningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"参考收益率\n%@%%",incomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        self.todayEarningsRate.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"今日收益率\n%@%%",todayIncomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];

        self.positionsUsage.attributedText =[NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"仓位情况\n%@%%",positionRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 4)];
        
        self.positionNumber.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总交易手数\n%@",model.totalTradeNum] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
        
        self.maximumProfit.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"最新净值\n%@",model.netWorthToday] littlefont:10 bigFont:15 defultTextColor:RGB(50, 50, 50) specialColor:[UIColor blackColor] range:NSMakeRange(0, 4)];
        
        self.winningProbability.attributedText = [NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"年化收益率\n%.2f%%",[model.annualYield floatValue]] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(50, 50, 50) range:NSMakeRange(0, 5)];
    }];
}


-(UILabel *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [self creatBackImageLabel];
    }
    return _earningsRate ;
}

-(UILabel *)todayEarningsRate {
    if (!_todayEarningsRate) {
        _todayEarningsRate = [self creatBackImageLabel];
    }
    return _todayEarningsRate ;
}

-(UILabel *)positionsUsage {
    if (!_positionsUsage) {
        _positionsUsage = [self creatBackImageLabel];
    }
    return _positionsUsage;
}

-(UILabel *)positionNumber {
    if (!_positionNumber) {
        _positionNumber = [self creatBackImageLabel];
    }
    return _positionNumber;
}

-(UILabel *)maximumProfit {
    if (!_maximumProfit) {
        _maximumProfit = [self creatBackImageLabel];
    }
    return _maximumProfit;
}

-(UILabel *)winningProbability {
    if (!_winningProbability) {
        _winningProbability = [self creatBackImageLabel];
    }
    return _winningProbability;
}

-(UILabel*)creatBackImageLabel{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    UIImageView *backImageView = [[UIImageView alloc] init];
    [backImageView setImage:[UIImage imageNamed:@"personal_dikuang"]];
    [label addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(label);
    }];
    return label;
}

@end
