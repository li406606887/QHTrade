//
//  HomeViewModel.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeNewsModel.h"
#import "HomeScrollModel.h"
#import "ContractModel.h"

#define kHostAddress @"118.31.103.102"
#define kPort 10012

@implementation HomeViewModel

-(void)initialize{
    @weakify(self)
    [self.getHomeCollectionCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray*  _Nullable array) {
        @strongify(self)
        if (array.count>0) {
            if (self.pageNum ==1) {
                [self.newsDataArray removeAllObjects];
            }
            for (NSDictionary *data in array) {
                HomeNewsModel*model = [HomeNewsModel mj_objectWithKeyValues:data];
                [self.newsDataArray addObject:model];
            }
        }
        [self.refreshUISubject sendNext:@(RefreshError)];

    }];
    [self.getawesomeScrollCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (x) {
            for (NSDictionary *data in x) {
                HomeScrollModel*model = [HomeScrollModel mj_objectWithKeyValues:data];
                [self.awesomeScrollArray addObject:model];
            }
        }
        [self.refreshScrollUISubject sendNext:nil];
    }];
    [self.getContractListCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        if (x) {
            if (self.modelDictionary.count) {
                [self.modelDictionary removeAllObjects];
                [self.contractNameArray removeAllObjects];
            }
            for (NSDictionary *data in x) {
                ContractModel *model = [ContractModel mj_objectWithKeyValues:data];
                [self.contractNameArray addObject:model.ContractID];
                [self.modelDictionary setObject:model forKey:model.ContractID];
            }
        }
        [self.refreshContractSubject sendNext:nil];
    }];
}

-(RACCommand *)getContractListCommand {
    if (!_getContractListCommand) {
        _getContractListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   NSError *error ;
                   QHRequestModel *model = [QHRequest getDataWithApi:@"/futures/recommend"
                                                           withParam:nil
                                                               error:&error];
                   dispatch_async(dispatch_get_main_queue(), ^{
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
    return _getContractListCommand;
}

-(RACCommand *)getHomeCollectionCommand {
    if (!_getHomeCollectionCommand) {
        _getHomeCollectionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                self.pageNum = input == nil ? self.pageNum : 0;
                self.pageNum++;
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                NSString *page = [NSString stringWithFormat:@"%d",self.pageNum];
                [param setObject:page forKey:@"page"];
                [param setObject:@"10" forKey:@"pageSize"];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/news"
                                                            withParam:param
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error==nil) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.message)
                            self.pageNum--;
                            [self.refreshUISubject sendNext:@(RefreshError)];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getHomeCollectionCommand;
}

-(RACCommand *)getawesomeScrollCommand{
    if (!_getawesomeScrollCommand) {
        _getawesomeScrollCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error ;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/advertisements"
                                                            withParam:nil
                                                                error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
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
    return _getawesomeScrollCommand;
}
-(RACSubject *)awesomeScrollClickSubject {
    if (!_awesomeScrollClickSubject) {
        _awesomeScrollClickSubject = [RACSubject subject];
    }
    return _awesomeScrollClickSubject;
}

-(RACSubject *)tableCellClickSubject {
    if (!_tableCellClickSubject) {
        _tableCellClickSubject = [RACSubject subject];
    }
    return _tableCellClickSubject;
}

-(RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

-(NSMutableArray *)awesomeScrollArray {
    if (!_awesomeScrollArray) {
        _awesomeScrollArray = [[NSMutableArray alloc] init];
    }
    return _awesomeScrollArray;
}

-(NSMutableArray *)newsDataArray {
    if (!_newsDataArray) {
        _newsDataArray = [[NSMutableArray alloc] init];
    }
    return _newsDataArray;
}

-(RACSubject *)refreshScrollUISubject{
    if (!_refreshScrollUISubject) {
        _refreshScrollUISubject = [RACSubject subject];
    }
    return _refreshScrollUISubject;
}

-(RACSubject *)quotationRefreshSubject {
    if (!_quotationRefreshSubject) {
        _quotationRefreshSubject = [RACSubject subject];
    }
    return _quotationRefreshSubject;
}

-(RACSubject *)refreshContractSubject {
    if (!_refreshContractSubject) {
        _refreshContractSubject = [RACSubject subject];
    }
    return _refreshContractSubject;
}
-(NSMutableDictionary *)modelDictionary {
    if (!_modelDictionary) {
        _modelDictionary = [[NSMutableDictionary alloc] init];
    }
    return _modelDictionary;
}
-(NSMutableArray *)contractNameArray {
    if (!_contractNameArray) {
        _contractNameArray = [[NSMutableArray alloc] init];
    }
    return _contractNameArray;
}
-(int)pageNum {
    if (!_pageNum) {
        _pageNum = 0;
    }
    return _pageNum;
}





#pragma mark updDelegate
-(void)getUDPData{
    NSString *host = kHostAddress;//此处如果写成固定的IP就是对特定的server监测；我这种写法是为了多方监测
    uint16_t port = kPort;//通过端口监测
    NSString *s = @"\"cmd\":\"10001\",\"data\":{}";
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    [self.udpSocket sendData:data toHost:host port:port withTimeout:-1 tag:0];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"发送消息成功");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"发送消息失败");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    id dataDic;
    if ([data isKindOfClass:[NSData class]]) {
        dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }else{
        dataDic = data;
    }
    [self.quotationRefreshSubject sendNext:dataDic];
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError  * _Nullable)error {
    NSLog(@"---------------------cuocuocuocuocuo");
    NSLog(@"%@",error);
    NSLog(@"---------------------cuocuocuocuocuo");
}

-(GCDAsyncUdpSocket *)udpSocket {
    if (!_udpSocket) {
        _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        NSError * error = nil;
        [_udpSocket bindToPort:8081 error:&error];
        if (error) {//监听错误打印错误信息
            NSString *errorString = [NSString stringWithFormat:@"%@",error];
            showMassage(errorString);
        }else {//监听成功则开始接收信息
            [_udpSocket beginReceiving:&error];
        }
        
    }
    return _udpSocket;
}
@end
