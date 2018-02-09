//
//  ChangeNextMainView.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseView.h"

@interface ChangeNextMainView : BaseView
@property (nonatomic,strong) UIImageView *signImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *areaLabel;
@property (nonatomic,strong) UILabel *areaNumLabel;
@property (nonatomic,strong) UIImageView *arrowImgView;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UITextField *phoneTextfield;
@property (nonatomic,strong) UILabel * sendCodeLabel;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) UITextField *codeTextfield;
@property (nonatomic,strong) UIButton *commitButton;
@end
