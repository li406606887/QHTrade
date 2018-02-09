//
//  TradingSignalsView.m
//  QHTrade
//
//  Created by user on 2017/7/5.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradingSignalsView.h"
#import "TradingSignalsCell.h"
#import "AwesomeDetailsViewModel.h"

@interface TradingSignalsView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UIButton *historyBtn;
@end

@implementation TradingSignalsView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeDetailsViewModel*)viewModel;
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
    @weakify(self)
    [self.viewModel.tradeSignalsCommand execute:nil];
    [self.viewModel.tradeSignalsRefreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
        [self.table.mj_header endRefreshing];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10.0f;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.tradingSignalsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradingSignalsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])]];
    cell.myModel = self.viewModel.tradingSignalsArray[indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[self.table class]]) {
        
    }
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
        _table  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.sectionFooterHeight = 10.0f;
        _table.sectionHeaderHeight = 10.0f;
        _table.rowHeight = 44;
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [headView addSubview:self.historyBtn];
        [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(headView);
            make.size.mas_offset(CGSizeMake(150, 25));
        }];
        _table.tableHeaderView = headView;
        [_table registerClass:[TradingSignalsCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TradingSignalsCell class])]];

    }
    return _table;
}

-(UIButton *)historyBtn {
    if (!_historyBtn) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyBtn setTitle:@"查看历史成交记录" forState:UIControlStateNormal];
        [_historyBtn setTitleColor:RGB(255, 98, 1) forState:UIControlStateNormal];
        _historyBtn.layer.borderColor = RGB(255, 98, 1).CGColor;
        _historyBtn.layer.borderWidth = 0.5;
        _historyBtn.layer.masksToBounds = YES;
        _historyBtn.layer.cornerRadius = 5;
        [_historyBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        @weakify(self)
        [[_historyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.lookAllHistorySignalSubject sendNext:nil];
        }];
    }
    return _historyBtn;
}
@end
