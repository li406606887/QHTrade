//
//  ChooseCompanyViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface ChooseCompanyViewModel : BaseViewModel

@property (nonatomic,strong) RACCommand *requestCommand;
@property (nonatomic,strong) RACSubject *refreshEndSubject;
@property (nonatomic,strong) RACSubject *refreshUI;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) RACSubject *cellClickSubject;
@end
