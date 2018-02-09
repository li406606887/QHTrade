//
//  ChangePhoneMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"

@interface ChangePhoneMainView : BaseView

@property (nonatomic,strong) UIImageView *signImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UILabel *passWordLabel;
@property (nonatomic,strong) UITextField *codeTextfield;
@property (nonatomic,strong) UITextField *passWordTextfield;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UIButton *commitButton;

@end
