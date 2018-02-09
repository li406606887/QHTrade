//
//  ForgetViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface ForgetViewModel : BaseViewModel

@property (nonatomic,strong) NSString *phoneStr;
@property (nonatomic,strong) NSString *codeStr;
@property (nonatomic,strong) NSString *passWordStr;
@property (nonatomic,strong) NSString *againPWStr;

@property (nonatomic,strong, readonly) RACCommand *commitCommand;//登录
@property (nonatomic,strong, readonly) RACSignal *commitBtnEnable;

@property (nonatomic,strong) RACCommand *codeCommand;//获取验证码

@property (nonatomic,strong) RACSubject *getCodeSubject;

@end
