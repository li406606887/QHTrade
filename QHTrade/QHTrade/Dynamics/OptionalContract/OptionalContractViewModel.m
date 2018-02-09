//
//  OptionalContractViewModel.m
//  QHTrade
//
//  Created by user on 2017/6/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "OptionalContractViewModel.h"

@implementation OptionalContractViewModel
-(RACSubject *)volumeClickSubject{
    if (!_volumeClickSubject) {
        _volumeClickSubject = [RACSubject subject];
    }
    return _volumeClickSubject;
}
-(RACSubject *)upFallingClickSubject{
    if (!_upFallingClickSubject) {
        _upFallingClickSubject = [RACSubject subject];
    }
    return _upFallingClickSubject;
}
@end
