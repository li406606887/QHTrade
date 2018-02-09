//
//  SetingToolView.m
//  QHTrade
//
//  Created by user on 2017/11/21.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SetingToolView.h"
#import "FollowSetingViewModel.h"

@interface SetingToolView()
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UIButton *sureBtn;
@property(nonatomic,strong) UILabel *text;
@end

@implementation SetingToolView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.sureBtn];
    [self addSubview:self.text];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.top.equalTo(self);
        make.height.equalTo(@40);
        make.right.equalTo(self.sureBtn);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.bottom.equalTo(self);
        make.width.offset(100);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.valueChangeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSString *numScale = [FollowSetingModel proportion:self.viewModel.setingModel.numScale];
        NSString *priceType = [FollowSetingModel successPrice:self.viewModel.setingModel.priceType];
        NSString *jumpPoint = [FollowSetingModel hops:self.viewModel.setingModel.jumpPoint];
        if ((int)self.viewModel.setingModel.priceType == 0) {
           self.text.text = [NSString stringWithFormat:@"已选: %@  %@  %@  ",numScale,priceType,jumpPoint];
        }else{
            self.text.text = [NSString stringWithFormat:@"已选: %@  %@  ",numScale,priceType];
        }
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setBackgroundColor:RGB(239, 92, 1)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![[UserInformation getInformation] getLoginState]) {
                [self.viewModel.gotoLoginSubject sendNext:nil];
                return ;
            }
            if ([[UserInformation getInformation].userModel.fierce intValue]==1) {
                showMassage(@"牛人不可以跟单");
                return;
            }
            if ([UserInformation getInformation].userModel.ctpAccount.length<1) {
                PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle:@"请先绑定资金账户后才能订阅并跟单" LeftBtnTitle:@"暂不绑定" RightBtnTitle:@"去绑定"];
                promptView.goonBlock = ^(){
                    [self.viewModel.gotoBindCTPAcountSubject sendNext:nil];
                };
                [promptView show];
                return ;
            }
//            NSIndexPath *indexPath = self.table.indexPathForSelectedRow;
//            int index = (int)(indexPath.row +1);
//            if ([self promptTitle:index]!=YES) {
//                PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle:@"钻石数量不足,请先购买" LeftBtnTitle:@"暂不跟单" RightBtnTitle:@"去购买"];
//                promptView.goonBlock = ^(){
//                    [self.viewModel.gotoBuyDiamondSubject sendNext:nil];
//                };
//                [promptView show];
//                return ;
//            }
//            NSString * money;
//            if (index == 1) {
//                money = @"30";
//            }else money = @"300";
//            PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle: [NSString stringWithFormat:@"本次跟单需支付%@钻石，确定跟单吗？",money] LeftBtnTitle:@"暂不跟单" RightBtnTitle:@"马上跟单"];
//            promptView.goonBlock = ^(){
            NSString *jumpPoint = [NSString stringWithFormat:@"%ld",self.viewModel.setingModel.jumpPoint+1];
            NSString *priceType = [NSString stringWithFormat:@"%ld",self.viewModel.setingModel.priceType+1];
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:[NSString stringWithFormat:@"2"] forKey:@"type"];
            [param setObject:self.viewModel.model.userId forKey:@"userId"];
            [param setObject:self.viewModel.setingModel.numScale forKey:@"numScale"];
            [param setObject:jumpPoint forKey:@"jumpPoint"];
            [param setObject:priceType forKey:@"priceType"];
            [self.viewModel.followEarningSumbitCommand execute:param];
//            };
//            [promptView show];
        }];
    }
    return _sureBtn;
}

-(UILabel *)text {
    if (!_text) {
        _text = [[UILabel alloc] init];
        _text.font = [UIFont systemFontOfSize:14];
        _text.textColor = RGB(68, 68, 68);
        NSString *proportion = [FollowSetingModel proportion:self.viewModel.setingModel.numScale];
        NSString *priceType = [FollowSetingModel successPrice:self.viewModel.setingModel.priceType];
        NSString *hops = [FollowSetingModel hops:self.viewModel.setingModel.jumpPoint];
        if ((int)self.viewModel.setingModel.priceType == 0) {
            self.text.text = [NSString stringWithFormat:@"已选: %@  %@  %@  ",proportion,priceType,hops];
        }else{
            self.text.text = [NSString stringWithFormat:@"已选: %@  %@  ",proportion,priceType];
        }
    }
    return _text;
}
@end
