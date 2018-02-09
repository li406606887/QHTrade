//
//  FollowSetingView.m
//  QHTrade
//
//  Created by user on 2017/11/20.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowSetingView.h"
#import "SetingToolView.h"
#import "SetingProportionView.h"
#import "SuccessPriceView.h"
#import "SetingHopsView.h"
#import "FollowSetingViewModel.h"

@interface FollowSetingView ()
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) SetingProportionView *proportionView;
@property(nonatomic,strong) SuccessPriceView *successPriceView;
@property(nonatomic,strong) SetingHopsView *hopsView;
@property(nonatomic,strong) UIView *footView;
@property(nonatomic,strong) SetingToolView *toolView;
@property(nonatomic,copy  ) NSString* promptString;
@property(nonatomic,assign) CGFloat promptHeight;
@property(nonatomic,strong) UIView *hopBackView;
@property(nonatomic,strong) NSDictionary *attributedDic;
@end

@implementation FollowSetingView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.proportionView];
    [self.scroll addSubview:self.successPriceView];
    [self.scroll addSubview:self.hopsView];
    [self.scroll addSubview:self.footView];
    [self addSubview:self.toolView];
    [self addSubview:self.hopBackView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 40, 0));
    }];
    
    [self.proportionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroll).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 120));
    }];
    
    [self.successPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.proportionView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 120));
    }];
    
    [self.hopsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successPriceView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 120));
    }];
    
    [self.hopBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successPriceView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 120));
    }];
    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hopsView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, self.promptHeight+30));
    }];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH+2, 40+NoSafeBarHeight));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.successPriceClick subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.hopBackView.hidden = [x intValue] == 0 ? YES: NO;
//        self.hopsView.userInteractionEnabled = [x intValue] == 0 ? YES: NO;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.contentSize = CGSizeMake(0.1f, self.promptHeight+440);
    }
    return _scroll;
}

-(SetingProportionView *)proportionView {
    if (!_proportionView) {
        _proportionView = [[SetingProportionView alloc] initWithViewModel:self.viewModel];
        _proportionView.layer.masksToBounds = YES;
        _proportionView.layer.cornerRadius = 3;
        _proportionView.layer.borderWidth = 0.5f;
        _proportionView.layer.borderColor = RGB(222, 222, 222).CGColor;
        _proportionView.layer.shadowColor = RGB(255, 98, 1).CGColor;
        _proportionView.layer.shadowOffset = CGSizeMake(3, 3);
        _proportionView.layer.shadowRadius = 3.0;
        _proportionView.layer.shadowOpacity = 0.1;
        _proportionView.clipsToBounds = NO;
    }
    return _proportionView;
}

-(SuccessPriceView *)successPriceView {
    if (!_successPriceView) {
        _successPriceView = [[SuccessPriceView alloc] initWithViewModel:self.viewModel];
        _successPriceView.layer.masksToBounds = YES;
        _successPriceView.layer.cornerRadius = 3;
        _successPriceView.layer.borderWidth = 0.5;
        _successPriceView.layer.borderColor = RGB(222, 222, 222).CGColor;
        _successPriceView.layer.shadowColor = RGB(255, 98, 1).CGColor;
        _successPriceView.layer.shadowOffset = CGSizeMake(3, 3);
        _successPriceView.layer.shadowRadius = 3.0;
        _successPriceView.layer.shadowOpacity = 0.1;
        _successPriceView.clipsToBounds = NO;
    }
    return _successPriceView;
}

-(SetingHopsView *)hopsView {
    if (!_hopsView) {
        _hopsView = [[SetingHopsView alloc] initWithViewModel:self.viewModel];
        _hopsView.layer.masksToBounds = YES;
        _hopsView.layer.cornerRadius = 3;
        _hopsView.layer.borderWidth = 0.5f;
        _hopsView.layer.borderColor = RGB(222, 222, 222).CGColor;
        _hopsView.layer.shadowColor = RGB(255, 98, 1).CGColor;
        _hopsView.layer.shadowOffset = CGSizeMake(3, 3);
        _hopsView.layer.shadowRadius = 3.0;
        _hopsView.layer.shadowOpacity = 0.1;
        _hopsView.clipsToBounds = NO;
        }
    return _hopsView;
}

-(UIView *)footView {
    if (!_footView) {
        _footView = [[UIView alloc] init];
        _footView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] init];
        title.text = @"  跟单说明:";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = RGB(68, 68, 68);
        [_footView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_footView).with.offset(11);
            make.size.mas_offset(CGSizeMake(200, 15));
        }];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.promptString attributes:self.attributedDic];
        [string addAttribute:NSForegroundColorAttributeName value:RGB(0, 108, 255) range:NSMakeRange(0, 44)];
        UILabel *prompt = [[UILabel alloc] init];
        prompt.font = [UIFont systemFontOfSize:14];
        prompt.attributedText = string;
        prompt.numberOfLines = 0;
        [_footView addSubview:prompt];
        [prompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_footView);
            make.top.equalTo(title.mas_bottom);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, self.promptHeight+10));
        }];
    }
    return _footView;
}

-(SetingToolView *)toolView {
    if (!_toolView) {
        _toolView = [[SetingToolView alloc] initWithViewModel:self.viewModel];
        _toolView.layer.borderWidth = 0.5f;
        _toolView.layer.backgroundColor = RGB(244, 244, 244).CGColor;
        _toolView.backgroundColor = [UIColor whiteColor];
    }
    return _toolView;
}

-(NSString *)promptString {
    if (!_promptString) {
        _promptString = @"成功订阅后须在白盘9点前，13点前，夜盘21点前手动登录交易账户后，才会开始自动跟单。\n系统将根据您设置的跟单手数比例、委托价位、每笔跟单跳点进行跟单。例如您设置跟单手数比例为2比1，以牛人成交价为委托价发出跟单，每笔跳点1点，则系统将以此为您进行自动跟单操作，并在无法成交时自动为您进行跳点操作，调整的点位以您设置的点位为准，多次未能成交则将放弃该笔跟单。";
    }
    return _promptString;
}

-(NSDictionary *)attributedDic {
    if (!_attributedDic) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.firstLineHeadIndent = 30; // 首行缩进
        _attributedDic = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:RGB(68, 68, 68)};
    }
    return _attributedDic;
}

-(CGFloat)promptHeight {
    if (!_promptHeight) {
        CGSize size = [NSMutableAttributedString getTextSizeWithText:self.promptString withMaxSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT) dic:self.attributedDic];
        _promptHeight = size.height;
    }
    return _promptHeight;
}

-(UIView *)hopBackView {
    if (!_hopBackView) {
        _hopBackView = [[UIView alloc] init];
        _hopBackView.backgroundColor = [UIColor blackColor];
        _hopBackView.alpha = 0.4;
        _hopBackView.hidden = YES;
        _hopBackView.layer.masksToBounds = YES;
        _hopBackView.layer.cornerRadius = 3;
        _hopBackView.layer.borderWidth = 0.5f;
        _hopBackView.layer.borderColor = RGB(222, 222, 222).CGColor;
    }
    return _hopBackView;
}
@end
