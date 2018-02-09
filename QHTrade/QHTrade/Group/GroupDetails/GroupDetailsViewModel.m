//
//  GroupDetailsViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupDetailsViewModel.h"

@implementation GroupDetailsViewModel

-(void)initialize{
    @weakify(self)
    [self.groupPriseCommand.executionSignals.switchToLatest  subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.refreshPriseStateSubject sendNext:x];
    }];
}

-(RACCommand *)groupPriseCommand {
    if (!_groupPriseCommand) {
        _groupPriseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/circleContents/operation"
                                                             withParam:input
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
    return _groupPriseCommand;
}
-(RACSubject *)refreshPriseStateSubject{
    if (!_refreshPriseStateSubject) {
        _refreshPriseStateSubject = [RACSubject subject];
    }
    return _refreshPriseStateSubject;
}
-(RACSubject *)backSubject {
    if (!_backSubject) {
        _backSubject = [RACSubject subject];
    }
    return _backSubject;
}
-(CGFloat)textHeight {
    if (!_textHeight) {
        NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGRect rect = [self.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                               attributes:dictionary
                                                  context:nil];

        _textHeight = rect.size.height + 5;
    }
    return _textHeight;
}
-(RACSubject *)gotoLoginSubject {
    if (!_gotoLoginSubject) {
        _gotoLoginSubject = [RACSubject subject];
    }
    return _gotoLoginSubject;
}
@end
