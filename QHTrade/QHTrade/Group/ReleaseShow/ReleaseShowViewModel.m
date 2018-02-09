//
//  ReleaseShowViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ReleaseShowViewModel.h"

@implementation ReleaseShowViewModel
-(void)initialize {
    @weakify(self)
    [self.releasehowCommmand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.sumbitSuccessfulSubject sendNext:nil];
    }];
}
-(RACCommand *)releasehowCommmand{
    if (!_releasehowCommmand) {
        _releasehowCommmand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:self.content forKey:@"content"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/circleContents"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _releasehowCommmand;
}

-(RACSubject *)sumbitSuccessfulSubject {
    if (!_sumbitSuccessfulSubject) {
        _sumbitSuccessfulSubject = [RACSubject subject];
    }
    return _sumbitSuccessfulSubject;
}
@end
