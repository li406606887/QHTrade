
//
//  SHFEViewModel.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SHFEViewModel.h"

@implementation SHFEViewModel
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
