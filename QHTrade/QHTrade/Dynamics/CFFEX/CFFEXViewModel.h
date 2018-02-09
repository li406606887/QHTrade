//
//  CFFEXViewModel.h
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface CFFEXViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject *upFallingClickSubject;//涨幅按钮点击新号
@property(nonatomic,strong)RACSubject *volumeClickSubject;//成交量按钮点击新号
@end
