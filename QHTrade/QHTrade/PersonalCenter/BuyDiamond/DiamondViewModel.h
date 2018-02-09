//
//  DiamondViewModel.h
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface DiamondViewModel : BaseViewModel

@property (nonatomic,strong) RACCommand *aLiPayCommand;

@property (nonatomic,strong) RACSubject *commitBtnSubjet;

@property (nonatomic,strong) RACSubject *cellClickSubject;
@end
