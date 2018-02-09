//
//  HomeViewModel.h
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "BaseViewModel.h"
#import "GCDAsyncSocket.h" // for TCP
#import "GCDAsyncUdpSocket.h" // for UDP

@interface HomeViewModel : BaseViewModel<GCDAsyncUdpSocketDelegate>
@property(nonatomic,strong) NSMutableArray *awesomeScrollArray;
@property(nonatomic,strong) NSMutableArray *newsDataArray;
@property(nonatomic,strong) NSMutableDictionary *modelDictionary;
@property(nonatomic,strong) NSMutableArray *contractNameArray;
@property(nonatomic,strong) RACSubject *awesomeScrollClickSubject;
@property(nonatomic,strong) RACSubject *tableCellClickSubject;
@property(nonatomic,strong) RACCommand *getHomeCollectionCommand;
@property(nonatomic,strong) RACCommand *getawesomeScrollCommand;
@property(nonatomic,strong) RACSubject *refreshUISubject;
@property(nonatomic,strong) RACSubject *refreshScrollUISubject;
@property(nonatomic,strong) RACSubject *quotationRefreshSubject;
@property(nonatomic,strong) RACCommand *getContractListCommand;
@property(nonatomic,strong) RACSubject *refreshContractSubject;
@property(nonatomic,strong) GCDAsyncUdpSocket * udpSocket;

@property(nonatomic,assign) int pageNum;

-(void)getUDPData;
@end
