//
//  ReleaseShowView.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ReleaseShowView.h"
#import "ReleaseShowViewModel.h"

@interface ReleaseShowView ()<UITextViewDelegate>
@property(nonatomic,strong) ReleaseShowViewModel *viewModel;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *prompt;
@property(nonatomic,strong) UILabel *placeholderLabel;
@end

@implementation ReleaseShowView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (ReleaseShowViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.textView];
    [self.textView addSubview:self.placeholderLabel];
    [self addSubview:self.line];
    [self addSubview:self.prompt];
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = YES;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)updateConstraints {
    [super updateConstraints];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).with.offset(7);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-14, 260));
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView).with.offset(8.5);
        make.left.equalTo(self.textView).with.offset(5);
        make.size.mas_offset(CGSizeMake(100, 14));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.top.equalTo(self.textView.mas_bottom).with.offset(3);
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

-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.delegate = self;
        @weakify(self)
        [[_textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            if (_textView.text.length<1) {
                self.placeholderLabel.alpha = 1;
            } else {
                self.placeholderLabel.alpha = 0;
            }
            if (_textView.text.length >= 300) {
                _textView.text = [_textView.text substringToIndex:300];
            }
            self.viewModel.content = x;
        }];
    }
    return _textView;
}

-(UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.text = @"最多输入300字";
        _prompt.textColor = RGB(51, 51, 51);
        _prompt.font = [UIFont systemFontOfSize:14];
    }
    return _prompt;
}

-(UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = @"发表您的见解";
        _placeholderLabel.textColor = RGB(136, 136, 136);
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
    }
    return _placeholderLabel;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:RGB(205, 205, 205)];
    }
    return _line;
}
@end
