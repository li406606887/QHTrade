//
//  FollowEarningsDetailsView.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsDetailsView.h"
#import "FollowEarningsDetailsViewModel.h"
#import "FollowEarningsDetailsModel.h"
#import "EarningsSumDayView.h"
#import "FollowAwesomeModel.h"

@interface FollowEarningsDetailsView()
@property(nonatomic,strong) FollowEarningsDetailsViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scroll;
/**
 个人信息View 以及控件
 */
@property(nonatomic,strong) UIView *personView;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UIImageView *sex;
@property(nonatomic,strong) UIButton *earningsRate;//收益率
@property(nonatomic,strong) UIButton *totalProfit;//总收益
@property(nonatomic,strong) UIButton *positionsUsage;//仓位使用率
/**
 跟随标题
 */
@property(nonatomic,strong) UILabel *followingLabel;//正在跟随
/**
 牛人的View 以及牛人信息控件
 */
@property(nonatomic,strong) UIView *awesomeView;//牛人的View
@property(nonatomic,strong) UIImageView *awesomeIcon;//牛人头像
@property(nonatomic,strong) UILabel *awesomeName;//牛人名称
/**
 收益折线图预览
 */
@property(nonatomic,strong) UIView *earningView;
@property(nonatomic,strong) UIView *bottomLine;//下底线
@property(nonatomic,assign) CGFloat nameWidth;
@property(nonatomic,strong) EarningsSumDayView *earningsSumDayView;//总收益折线图
@property(nonatomic,copy) NSString* awesomeID;
@end

@implementation FollowEarningsDetailsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowEarningsDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.personView];
    [self.personView addSubview:self.icon];
    [self.personView addSubview:self.icon];
    [self.personView addSubview:self.name];
    [self.personView addSubview:self.sex];
    [self.personView addSubview:self.earningsRate];
    [self.personView addSubview:self.totalProfit];
    [self.personView addSubview:self.positionsUsage];
    [self.scroll addSubview:self.followingLabel];
    [self.scroll addSubview:self.awesomeView];
    [self.awesomeView addSubview:self.awesomeIcon];
    [self.awesomeView addSubview:self.awesomeName];
    [self.scroll addSubview:self.bottomLine];
    [self.scroll addSubview:self.earningsSumDayView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 110));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personView).with.offset(10);
        make.left.equalTo(self.personView).with.offset(16);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personView).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(15);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personView).with.offset(13);
        make.left.equalTo(self.name.mas_right).with.offset(5);
        make.size.mas_offset(CGSizeMake(12, 12));
    }];
    
    [self.earningsRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).with.offset(10);
        make.left.equalTo(self.personView).with.offset(16);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)*0.3, 50));
    }];
    
    [self.totalProfit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.personView);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)*0.3, 50));
    }];
    
    [self.positionsUsage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-32)*0.3, 50));
    }];
    
    [self.followingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personView.mas_bottom);
        make.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH+3, 40));
    }];
    
    [self.awesomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.followingLabel.mas_bottom);
        make.left.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    
    [self.awesomeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.awesomeView).with.offset(16);
        make.centerY.equalTo(self.awesomeView);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.awesomeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awesomeView).with.offset(10);
        make.left.equalTo(self.awesomeIcon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH+3, 30));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awesomeView.mas_bottom);
        make.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    
    [self.earningsSumDayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scroll);
        make.top.equalTo(self.bottomLine.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 500));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getUserInfoCommand execute:nil];
    [self.viewModel.followRarningsSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self sendData:x];
    }];
    [self.viewModel.refreshUISubject subscribeNext:^(FollowEarningsDetailsModel*  _Nullable model) {
        @strongify(self)
        self.name.text = [NSString stringWithFormat:@"%@",model.userName];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,model.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
        
        switch ([model.gender intValue]) {
            case 1:
                self.sex.image = [UIImage imageNamed:@"personal_man_icon"];
                break;
            case 2:
                self.sex.image = [UIImage imageNamed:@"personal_woman_icon"];
                break;
            case 3:
                self.sex.image = [UIImage imageNamed:@"personal_man_icon"];
                break;
            default:
                break;
        }
        NSString *incomeRate = [NSString stringWithFormat:@"%.2f",[model.incomeRate floatValue]*100];
        NSString *positionRate = [NSString stringWithFormat:@"%.2f",[model.positionRate floatValue]*100];
        NSString *totalIncome = [NSString stringWithFormat:@"%.2f",[model.totalIncome floatValue]];
        [self.earningsRate setAttributedTitle:[NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"收益率\n%@%%",incomeRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(49,49,49) range:NSMakeRange(0, 3)] forState:UIControlStateNormal];
        [self.totalProfit setAttributedTitle:[NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"总盈利\n%@",totalIncome] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(49,49,49) range:NSMakeRange(0, 3)] forState:UIControlStateNormal];
        [self.positionsUsage setAttributedTitle:[NSAttributedString getAttributedStringWithString:[NSString stringWithFormat:@"仓位使用率\n%@%%",positionRate] littlefont:10 bigFont:15 defultTextColor:[UIColor blackColor] specialColor:RGB(49,49,49) range:NSMakeRange(0, 5)] forState:UIControlStateNormal];
        if (model.okamiList.count<1) {
            self.awesomeView.userInteractionEnabled = NO;
        }else {
            FollowAwesomeModel *awesomeModel = [FollowAwesomeModel mj_objectWithKeyValues:model.okamiList[0]];
            [self.awesomeIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imageLink,awesomeModel.userImg]] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
            self.awesomeName.text = [NSString stringWithFormat:@"%@",awesomeModel.userName];
            self.awesomeID = awesomeModel.userId;
        }
        
        
        [self.viewModel.curveGraphDayCommand execute:nil];
        NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        
        CGRect rect = [model.userName boundingRectWithSize:CGSizeMake(200, 15)
                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                attributes:dictionary
                                                   context:nil];
        self.nameWidth = rect.size.width+4;
        [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(self.nameWidth);
        }];
    }];
}

-(void)sendData:(NSDictionary*)data {
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
    }
    return _name;
}

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15;
        _icon.image = [UIImage imageNamed:@"touxiang_icon"];
        
    }
    return _icon;
}

-(UIImageView *)sex {
    if (!_sex) {
        _sex = [[UIImageView alloc] init];
        [_sex setImage:[UIImage imageNamed:@"personal_woman_icon"]];
    }
    return _sex;
}

-(UIButton *)earningsRate {
    if (!_earningsRate) {
        _earningsRate = [UIButton  buttonWithType:UIButtonTypeCustom];
        [_earningsRate setTitle:@"收益率" forState:UIControlStateNormal];
        [_earningsRate.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _earningsRate.titleLabel.numberOfLines = 2;
        [_earningsRate setBackgroundImage:[UIImage imageNamed:@"personal_dikuang"] forState:UIControlStateNormal];
        [_earningsRate setTitleColor:RGB(50, 51, 52) forState:UIControlStateNormal];
        _earningsRate.userInteractionEnabled = NO;
    }
    return _earningsRate;
}

-(UIButton *)totalProfit {
    if (!_totalProfit) {
        _totalProfit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_totalProfit.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.totalProfit setTitle:@"总盈利" forState:UIControlStateNormal];
        _totalProfit.titleLabel.numberOfLines = 2;
        [_totalProfit setBackgroundImage:[UIImage imageNamed:@"personal_dikuang"] forState:UIControlStateNormal];
        [_totalProfit setTitleColor:RGB(50, 51, 52) forState:UIControlStateNormal];
        [_totalProfit.titleLabel setTextAlignment:NSTextAlignmentCenter];
        _totalProfit.userInteractionEnabled = NO;
    }
    return _totalProfit;
}

-(UIButton *)positionsUsage {
    if (!_positionsUsage) {
        _positionsUsage = [[UIButton alloc] init];
        [_positionsUsage setBackgroundImage:[UIImage imageNamed:@"personal_dikuang"] forState:UIControlStateNormal];
        [_positionsUsage setTitle:@"仓位使用率" forState:UIControlStateNormal];
        [_positionsUsage.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _positionsUsage.titleLabel.numberOfLines = 2;
        [_positionsUsage setTitleColor:RGB(50, 51, 52) forState:UIControlStateNormal];
        _positionsUsage.userInteractionEnabled = NO;
    }
    return _positionsUsage;
}

-(UILabel *)followingLabel {
    if (!_followingLabel) {
        _followingLabel = [[UILabel alloc] init];
        _followingLabel.text = @"    正在跟随";
        _followingLabel.textColor = RGB(67 , 68 , 68);
        _followingLabel.font = [UIFont systemFontOfSize:14];
        _followingLabel.layer.borderWidth = 0.5;
        _followingLabel.layer.borderColor = RGB(220, 220, 220).CGColor;
        _followingLabel.backgroundColor = RGB(235, 235, 235);
    }
    return _followingLabel;
}

-(UIView *)awesomeView {
    if (!_awesomeView) {
        _awesomeView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self.viewModel.awesomeClickSubject sendNext:self.awesomeID];
        }];
        [_awesomeView addGestureRecognizer:tap];
    }
    return _awesomeView;
}

-(UIImageView *)awesomeIcon {
    if (!_awesomeIcon) {
        _awesomeIcon = [[UIImageView alloc] init];
        _awesomeIcon.layer.masksToBounds = YES;
        _awesomeIcon.layer.cornerRadius = 15;
    }
    return _awesomeIcon;
}

-(UILabel *)awesomeName {
    if (!_awesomeName) {
        _awesomeName = [[UILabel alloc] init];
        _awesomeName.text = @"牛人昵称";
        _awesomeName.font = [UIFont systemFontOfSize:14];
    }
    return _awesomeName;
}

-(UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = RGB(218, 218, 218);
    }
    return _bottomLine;
}


-(EarningsSumDayView *)earningsSumDayView {
    if (!_earningsSumDayView) {
        _earningsSumDayView = [[EarningsSumDayView alloc] initWithViewModel:self.viewModel];
    }
    return _earningsSumDayView;
}

-(UIView *)personView {
    if (!_personView) {
        _personView = [[UIView alloc] init];
    }
    return _personView;
}
-(UIView *)earningView{
    if (!_earningView) {
        _earningView = [[UIView alloc] init];
        
    }
    return _earningView;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.contentSize = CGSizeMake(0.5f, 720+NoSafeBarHeight);
    }
    return _scroll;
}
@end
