//
//  GroupViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupViewModel.h"
#import "GroupModel.h"

@implementation GroupViewModel

-(void)initialize{
    @weakify(self)
    [self.requestGroupDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray*  _Nullable array) {
        @strongify(self)
        if (array.count>0) {
            if (self.pageNum==1) {
                [self.dataArray removeAllObjects];
                [self.cellHeightArray removeAllObjects];
            }
            for (NSDictionary *dic in array) {
                GroupModel *model = [GroupModel mj_objectWithKeyValues:dic];
                NSDictionary *dictionary = @{NSFontAttributeName:[UIFont fontWithName:@"STHeitiSC-Light" size:14]};
                CGRect rect = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-32, 120)
                                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                       attributes:dictionary
                                                          context:nil];
                [self.cellHeightArray addObject:[NSString stringWithFormat:@"%f",rect.size.height+5]];
                
                [self.dataArray addObject:model];
            }
        }
        [self.refreshUISubject sendNext:@(RefreshError)];
    }];
    [self.groupPriseCommand.executionSignals.switchToLatest  subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        GroupModel *model = [GroupModel mj_objectWithKeyValues:x];
        if ([model.state intValue]==2) {
            showMassage(@"点赞成功");
        }else if([model.state intValue]==3) {
            showMassage(@"踩成功");
        }
        [self.refreshPriseStateSubject sendNext:model];
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

-(RACCommand *)requestGroupDataCommand {
    if (!_requestGroupDataCommand) {
        _requestGroupDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.pageNum = input == nil ? self.pageNum : 0;
                self.pageNum++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.pageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/circleContents/list"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            self.pageNum--;
                            [self.refreshUISubject sendNext:@(RefreshError)];
                            showMassage(model.message)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _requestGroupDataCommand;
}

-(RACSubject *)refreshUISubject{
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

-(RACSubject *)groupCellClickSubject{
    if (!_groupCellClickSubject) {
        _groupCellClickSubject = [RACSubject subject];
    }
    return _groupCellClickSubject;
}

-(RACSubject *)refreshPriseStateSubject{
    if (!_refreshPriseStateSubject) {
        _refreshPriseStateSubject = [RACSubject subject];
    }
    return _refreshPriseStateSubject;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray *)cellHeightArray {
    if (!_cellHeightArray) {
        _cellHeightArray = [[NSMutableArray alloc] init];
    }
    return _cellHeightArray;
}
-(RACSubject *)gotoLoginSubject {
    if (!_gotoLoginSubject) {
        _gotoLoginSubject = [RACSubject subject];
    }
    return _gotoLoginSubject;
}
-(int)pageNum{
    if (!_pageNum) {
        _pageNum = 0;
    }
    return _pageNum;
}
@end
