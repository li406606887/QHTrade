//
//  TradeRecordView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradeRecordView.h"
#import "TradingSignalsCell.h"
#import "TradeRecordModel.h"
#import "MyPositionsViewModel.h"

@interface TradeRecordView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) MyPositionsViewModel *viewModel;

@end

@implementation TradeRecordView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (MyPositionsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
}
-(void)bindViewModel {
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        [self.table reloadData];
    }];
    
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        
        [self.table reloadData];
        NSLog(@"shuaxin=%@",x);
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.table.mj_header endRefreshing];
                
                if (!self.table.mj_footer) {
                    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        
                        [self.viewModel.tradeRecordCommand execute:nil];
                        
                    }];
                }
                
                break;
                
                
            case HeaderRefresh_HasNoMoreData:
                [self.table.mj_header endRefreshing];
                self.table.mj_footer = nil;
                
                break;
                
            case FooterRefresh_HasMoreData:
                [self.table.mj_header endRefreshing];
                [self.table.mj_footer resetNoMoreData];
                [self.table.mj_footer endRefreshing];
                
                break;
                
            case FooterRefresh_HasNoMoreData:
                [self.table.mj_header endRefreshing];
                [self.table.mj_footer endRefreshingWithNoMoreData];
                
                
                break;
            case RefreshError:
                [self.table.mj_footer endRefreshing];
                [self.table.mj_header endRefreshing];
                break;
                
            default:
                break;
        }
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.viewModel.tradeRecordDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradingSignalsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])]];
    
    if (self.viewModel.tradeRecordDataArr.count > indexPath.row){
        TradeRecordModel * model = [TradeRecordModel mj_objectWithKeyValues:self.viewModel.tradeRecordDataArr[indexPath.row]];
        cell.myModel = model;
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[self.table class]]) {
        
    }
}

-(UITableView *)table {
    if (!_table) {
        _table  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[TradingSignalsCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.tradeRecordCommand execute:nil];
        }];
    }
    return _table;
}



@end
