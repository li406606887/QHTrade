//
//  ChangeNickNameViewController.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ViewBaseController.h"
#import "UserModel.h"
typedef void(^BackBlock) (UserModel * model);
@interface ChangeNickNameViewController : ViewBaseController
@property (nonatomic,strong) NSString *oldNickName;
@property (nonatomic,strong) UserModel * model;

@property (nonatomic,copy) BackBlock backblock;
@end
