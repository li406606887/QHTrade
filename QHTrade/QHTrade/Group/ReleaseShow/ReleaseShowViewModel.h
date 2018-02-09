//
//  ReleaseShowViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"

@interface ReleaseShowViewModel : BaseViewModel
@property(nonatomic,strong) RACCommand *releasehowCommmand;
@property(nonatomic,strong) RACSubject *sumbitSuccessfulSubject;
@property(nonatomic,copy) NSString* content;
@end
