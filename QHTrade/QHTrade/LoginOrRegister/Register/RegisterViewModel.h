//
//  RegisterViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/21.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface RegisterViewModel : BaseViewModel
@property (nonatomic,strong) NSString *phoneNumStr;
@property (nonatomic,strong) NSString *passWordStr;
@property (nonatomic,strong) NSString *codeStr;

@property (nonatomic,strong, readonly) RACCommand *registerCommand;//登录
@property (nonatomic,strong, readonly) RACSignal *registerBtnEnable;

@property (nonatomic,assign)  BOOL isAgree;

@property (nonatomic,strong) RACCommand *codeCommand;//获取验证码
@property (nonatomic,strong) RACSubject *getCodeSubject;
@property (nonatomic,strong) RACSubject *quickSubject;
@property (nonatomic,strong) RACSubject *tickClickSubject;

@end
