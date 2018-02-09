//
//  AwesomeDetailsView.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeDetailsView.h"
#import "AwesomeModel.h"
#import "AwesomeDetailsViewModel.h"
#import "AwesomeDetailsHeadView.h"
#import "AwesomeIntroductionView.h"
#import "EvaluationView.h"
#import "TradeAnalysisView.h"

@interface AwesomeDetailsView()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) AwesomeDetailsHeadView *awesomeDetailsHeadView;//牛人信息
@property(nonatomic,strong) AwesomeIntroductionView *awesomeIntroductionView;//牛人简介
@property(nonatomic,strong) EvaluationView *evaluationView;//评论
@property(nonatomic,strong) TradeAnalysisView *tradeAnalysisView;//交易分析图
@property(nonatomic,strong) UIButton *followAction;//跟单按钮
@property(nonatomic,weak) BaseView *oldView;
@end

@implementation AwesomeDetailsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.awesomeDetailsHeadView];
    self.oldView = self.awesomeIntroductionView;
    [self addSubview:self.oldView];
    [self addSubview:self.followAction];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.switchSegmentedSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        int index = [x intValue];
        [self.oldView removeFromSuperview];
        switch (index) {
            case 0:
                self.oldView = self.awesomeIntroductionView;
                break;
            case 1:
                self.oldView = self.tradeAnalysisView;
                break;
            case 2:
                self.oldView = self.evaluationView;
                break;                
            default:
                break;
        }
        [self addSubview:self.oldView];
        [self updateConstraints];
    }];
    
    [self.viewModel.awesomeRefreshUISubject subscribeNext:^(AwesomeModel*  _Nullable model) {
        @strongify(self)
        if([model.isFollows intValue]==1){
            [self.followAction setTitle:@"已跟单" forState:UIControlStateNormal];
            self.viewModel.state = 1;
        }
    }];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.awesomeDetailsHeadView mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self)
        make.left.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 80));
    }];
    
    [self.oldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(80, 0, 40+NoSafeBarHeight, 0));
    }];
    
    [self.followAction mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.bottom.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 40+NoSafeBarHeight));
    }];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(AwesomeDetailsHeadView *)awesomeDetailsHeadView {
    if (!_awesomeDetailsHeadView) {
        _awesomeDetailsHeadView = [[AwesomeDetailsHeadView alloc] initWithViewModel:self.viewModel];
        _awesomeDetailsHeadView.layer.shadowOpacity = 0.3;// 阴影透明度
        _awesomeDetailsHeadView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _awesomeDetailsHeadView.layer.shadowRadius = 1;// 阴影扩散的范围控制
        _awesomeDetailsHeadView.layer.shadowOffset  = CGSizeMake(0, 1);// 阴影的范围
    }
    return _awesomeDetailsHeadView;
}

-(AwesomeIntroductionView *)awesomeIntroductionView {
    if (!_awesomeIntroductionView) {
        _awesomeIntroductionView = [[AwesomeIntroductionView alloc] initWithViewModel:self.viewModel];
    }
    return _awesomeIntroductionView;
}

-(EvaluationView *)evaluationView {
    if (!_evaluationView) {
        _evaluationView = [[EvaluationView alloc] initWithViewModel:self.viewModel];
    }
    return _evaluationView;
}

-(UIButton *)followAction {
    if (!_followAction) {
        _followAction = [UIButton buttonWithType:UIButtonTypeCustom];
        _followAction.backgroundColor = RGB(250, 99, 32);
        [_followAction setTitle:@"跟单" forState:UIControlStateNormal];
        [_followAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_followAction rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.viewModel.state==1) {
                showMassage(@"已跟单");
                return ;
            }
            if ([[UserInformation getInformation].userModel.isFollows intValue]==1) {
                showMassage(@"只能跟单一个牛人")
                return;
            }
            [self.viewModel.followEarningSubject sendNext:self.viewModel.model];
        }];
    }
    return _followAction;
}

-(TradeAnalysisView *)tradeAnalysisView {
    if (!_tradeAnalysisView) {
        _tradeAnalysisView = [[TradeAnalysisView alloc] initWithViewModel:self.viewModel];
    }
    return _tradeAnalysisView;
}
@end
