//
//  HistoryTradeView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HistoryTradeView.h"
#import "TradeManageCell.h"
#import "TradeManageViewModel.h"
#import "EvaluateView.h"

@interface HistoryTradeView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) TradeManageViewModel * viewModel;
@end

@implementation HistoryTradeView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (TradeManageViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    WS(weakSelf)
    [self.viewModel.refreshHistoryUISubject subscribeNext:^(NSString* x) {
        if (weakSelf.viewModel.historyDataArr.count == 0) {
            [weakSelf loadingFailed];
        }else {
            [weakSelf hiddenLoadingFailed];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)updateConstraints {
    [super updateConstraints];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)setupViews {
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradeManageCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TradeManageCell class])]];
    cell.cancleButton.hidden = YES;
        cell.model = self.viewModel.historyDataArr[indexPath.row];
        //评价
        cell.evaluatBlock = ^(TradeManageModel * model){//评论弹框
            EvaluateView * evaluateView =  [[EvaluateView alloc]initWithTitle:@"评价" LeftBtnTitle:@"取消" RightBtnTitle:@"确定"];
            [evaluateView show];
            evaluateView.goonBlock = ^(NSString *text) {
                NSMutableDictionary * input = [NSMutableDictionary dictionary];
                [input setObject:model.userId forKey:@"okamiId"];
                [input setObject:text forKey:@"evaluate"];
                [self.viewModel.evaluateCommand execute:input];
            };
        };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.historyDataArr.count;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionHeaderHeight = 0.5f;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[TradeManageCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TradeManageCell class])]];
    }
    return _tableView;
}

@end
