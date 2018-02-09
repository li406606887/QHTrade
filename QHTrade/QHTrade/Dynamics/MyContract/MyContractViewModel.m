//
//  MyContractViewModel.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyContractViewModel.h"

@implementation MyContractViewModel


-(RACSubject *)segmentControlClickSubject{
    if (!_segmentControlClickSubject) {
        _segmentControlClickSubject = [RACSubject subject];
    }
    return _segmentControlClickSubject;
}
@end
