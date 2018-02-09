//
//  AccountSetViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface AccountSetViewModel : BaseViewModel
@property (nonatomic,strong) RACSubject *cellClick;

@property (nonatomic,strong) RACCommand *uploadHeadImageCommand;//上传图片

@property (nonatomic,strong) RACCommand *logoutCommand;//退出登录

@property (nonatomic,strong) RACSubject *refreshUI;

@end
