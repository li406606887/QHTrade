//
//  ChangePhoneViewModel.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/28.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangePhoneViewModel.h"

@implementation ChangePhoneViewModel
-(RACSubject *)commitBtnClick{

    if (!_commitBtnClick) {
        _commitBtnClick = [RACSubject subject];
    }
    return _commitBtnClick;
}
@end
