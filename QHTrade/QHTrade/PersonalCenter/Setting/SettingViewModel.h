//
//  SettingViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "UserModel.h"

@interface SettingViewModel : BaseViewModel
@property (nonatomic,strong) RACCommand *userInfoCommand;
@property (nonatomic,strong) RACSubject *refreshUI;//刷新信号
@property (nonatomic,strong) RACSubject *cellClick;
@property (nonatomic,strong) RACSubject *changePhoneClick;

@property (nonatomic,strong) RACCommand *unbindCommand;//解除绑定

@end
