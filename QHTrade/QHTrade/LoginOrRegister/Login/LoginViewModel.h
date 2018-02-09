//
//  LoginViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/9.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel
@property (nonatomic,strong) NSString *phoneNumStr;
@property (nonatomic,strong) NSString *passWordStr;
@property (nonatomic,strong, readonly) RACCommand *loginCommand;//登录
@property (nonatomic,strong, readonly) RACSignal *loginBtnEnable;


@property (nonatomic,strong) RACSubject *forgetSubject;
@property (nonatomic,strong) RACSubject *quickSubject;
@end
