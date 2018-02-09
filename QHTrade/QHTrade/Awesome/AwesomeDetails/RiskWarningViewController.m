//
//  RiskWarningViewController.m
//  QHTrade
//
//  Created by user on 2017/11/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "RiskWarningViewController.h"

@interface RiskWarningViewController ()
@property(nonatomic,strong) UILabel *promptLabel;
@property(nonatomic,assign) CGFloat height;
@end

@implementation RiskWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"风险揭示"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addChildView {
    [self.view addSubview:self.promptLabel];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(16);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, self.height));
    }];
}

-(void)setPrompt:(NSString *)prompt {
    _prompt = prompt;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = _prompt;
        _promptLabel.font = [UIFont systemFontOfSize:15];
//        _promptLabel.preferredMaxLayoutWidth = SCREEN_WIDTH-32;
        _promptLabel.numberOfLines = 0;
    }
    return _promptLabel;
}

-(CGFloat)height {
    if (!_height) {
        CGSize size = [NSAttributedString getTextSizeWithText:_prompt
                                                   withMaxSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT)
                                                          font:15];
        _height = size.height+10;
    }
    return _height;
}
@end
