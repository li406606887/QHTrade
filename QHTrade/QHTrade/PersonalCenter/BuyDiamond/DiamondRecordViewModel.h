//
//  DiamondRecordViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface DiamondRecordViewModel : BaseViewModel


@property (nonatomic,strong) RACCommand *requestCommand;

@property (nonatomic,strong) RACSubject *refreshEndSubject;
@property (nonatomic,strong) RACSubject *refreshUI;

@property (nonatomic,strong) NSMutableArray *dataArray;
@end
