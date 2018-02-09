//
//  FollowEarningChooseViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningChooseViewModel.h"

@implementation FollowEarningChooseViewModel

-(void)initialize {
    @weakify(self)
    [self.followEarningSumbitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.sumbitSuccessfulSubject sendNext:nil];
    }];
    
    
}

-(RACCommand *)followEarningSumbitCommand {
    if (!_followEarningSumbitCommand) {
        _followEarningSumbitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               loading(@"")
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   NSError *error ;
                   QHRequestModel *model = [QHRequest postDataWithApi:@"/okami/documentary"
                                                           withParam:input
                                                               error:&error];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       hiddenHUD;
                       if (error==nil) {
                           [subscriber sendNext:model.content];
                       }else {
                           
                       }
                       showMassage(model.message)
                       [subscriber sendCompleted];
                   });
               });
               return nil;
           }];
        }];
    }
    return _followEarningSumbitCommand;
}



-(RACSubject *)sumbitSuccessfulSubject {
    if (!_sumbitSuccessfulSubject) {
        _sumbitSuccessfulSubject = [RACSubject subject];
    }
    return _sumbitSuccessfulSubject;
}

-(RACSubject *)gotoBuyDiamondSubject {
    if (!_gotoBuyDiamondSubject) {
        _gotoBuyDiamondSubject = [RACSubject subject];
    }
    return _gotoBuyDiamondSubject;
}

-(RACSubject *)gotoLoginSubject {
    if (!_gotoLoginSubject) {
        _gotoLoginSubject = [RACSubject subject];
    }
    return _gotoLoginSubject;
}

-(RACSubject *)gotoBindCTPAcountSubject {
    if (!_gotoBindCTPAcountSubject) {
        _gotoBindCTPAcountSubject = [RACSubject subject];
    }
    return _gotoBindCTPAcountSubject;
}
-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

-(RACSubject *)tableReloadSubject {
    if (!_tableReloadSubject) {
        _tableReloadSubject = [RACSubject subject];
    }
    return _tableReloadSubject;
}


-(NSMutableDictionary *)setingModelDic {
    if (!_setingModelDic) {
        _setingModelDic = [[NSMutableDictionary alloc] init];
    }
    return _setingModelDic;
}

-(void)setModel:(AwesomeModel *)model {
    _model = model;
}

-(CGFloat)nameWidth {
    if (!_nameWidth) {
        CGRect rect = [self.model.userName boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-32, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                                  context:nil];
        _nameWidth = rect.size.width+4;
    }
    return _nameWidth;
}
@end
