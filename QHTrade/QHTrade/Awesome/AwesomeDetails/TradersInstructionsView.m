//
//  TradersInstructionsView.m
//  QHTrade
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradersInstructionsView.h"
#import "AwesomeDetailsViewModel.h"



@interface TradersInstructionsView()
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) UILabel *textBody;
@property(nonatomic,strong) UIButton *switchButton;
@property(nonatomic,assign) CGFloat textBodyHeight;//文本高度

@end

@implementation TradersInstructionsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.prompt];
    [self addSubview:self.textBody];
    [self addSubview:self.switchButton];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(16);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.textBody mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.top.equalTo(self.prompt.mas_bottom).with.offset(4);
        make.width.offset(SCREEN_WIDTH-32);
        make.height.offset(12);
    }];
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-1);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.size.mas_offset(CGSizeMake(40, 20));
    }];
}
-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.earningsSumDataSubject subscribeNext:^(id  _Nullable x) {
        
    }];
    [self.viewModel.instructionsRefreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.textBody.text = x;
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(UILabel *)prompt {
    if (!_prompt){
        _prompt = [[UILabel alloc] init];
        _prompt.text = @"操盘说明:";
        _prompt.textColor = RGB(67, 68, 69);
        _prompt.font = [UIFont systemFontOfSize:12];
    }
    return _prompt;
}

-(UILabel *)textBody {
    if (!_textBody) {
        _textBody = [[UILabel alloc] init];
        _textBody.textColor = RGB(67, 68, 69);
        _textBody.numberOfLines = 0;
        _textBody.font = [UIFont systemFontOfSize:12];
        _textBody.backgroundColor = [UIColor clearColor];
        _textBody.text = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",self.viewModel.tradersInstructions];
    }
    return _textBody;
}

-(UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton setImage:[UIImage imageNamed:@"Awesome_Switch_image_nomal"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"Awesome_Switch_image_selected"] forState:UIControlStateSelected];
        @weakify(self)
        [[_switchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x){
            @strongify(self)
            _switchButton.selected = !_switchButton.selected;
            self.textBodyHeight = _switchButton.selected == YES ? self.viewModel.tradersInstructionsHeight:12;
//            self.textBody.numberOfLines =_switchButton.selected == YES ? 0: 1;
            [self.viewModel.tradersInstructionsOpenSubject
             sendNext:[NSString stringWithFormat:@"%d",_switchButton.selected]];
            [self.textBody mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(self.textBodyHeight);
            }];
            
        }];
    }
    return _switchButton;
}

@end
