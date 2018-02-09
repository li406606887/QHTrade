//
//  HistorySignalView.m
//  QHTrade
//
//  Created by user on 2017/11/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HistorySignalView.h"
#import "HistorySignalViewModel.h"
#import "TradingSignalsCell.h"
#import "HistorySignalSectionView.h"

@interface HistorySignalView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) HistorySignalViewModel *viewModel;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,assign) int page;
@end

@implementation HistorySignalView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HistorySignalViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getMonthSignalsCommand execute:nil];
    [self.viewModel.tradeSignalsRefreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.tradingSignalsArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HistorySignalSectionView *sectionView = [[HistorySignalSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 27)];
    sectionView.title.text = self.viewModel.month;
    return sectionView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradingSignalsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])] forIndexPath:indexPath];
    cell.myModel = self.viewModel.tradingSignalsArray[indexPath.row];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor whiteColor];
        _table.rowHeight = 50;
        _table.sectionHeaderHeight = 27;
        _table.estimatedSectionFooterHeight = 0;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[TradingSignalsCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.page = 1;
            [self.viewModel.tradeSignalsCommand execute:@"1"];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.page ++;
            [self.viewModel.tradeSignalsCommand execute:[NSString stringWithFormat:@"%d",self.page]];
        }];
    }
    return _table;
}

-(int)page {
    if (!_page) {
        _page = 1;
    }
    return _page;
}
@end
