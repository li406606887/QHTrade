//
//  TradingView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "TradingView.h"
#import "TradeManageCell.h"
#import "TradeManageViewModel.h"
#import "PromptView.h"
#import "EvaluateView.h"
@interface TradingView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) TradeManageViewModel * viewModel;
@end

@implementation TradingView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (TradeManageViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshDataCommand execute:nil];
    [self.viewModel.refreshFollowUISubject subscribeNext:^(id x) {
        @strongify(self)
        if (self.viewModel.dataArray.count == 0) {
            [self loadingFailed];
        }else {
            [self hiddenLoadingFailed];
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
    if (self.viewModel.dataArray.count > indexPath.row){
        cell.model = self.viewModel.dataArray[indexPath.row];
        cell.cancleBlock = ^(TradeManageModel *model){
            PromptView * Pview = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"您的本次跟单还未结束，此时取消将无法继续跟单，且费用不退还。如您还有仓位，也需您自行处理。确定要取消跟单吗？" LeftBtnTitle:@"取消" RightBtnTitle:@"确定"];
            [Pview show];
            
            Pview.closeBlock = ^(){
                NSLog(@"坚持");
            };
            
            Pview.goonBlock = ^(){
                NSLog(@"取消");
                [self.viewModel.cancelCommand execute:model.userId];
            };
        };
        //评价
        cell.evaluatBlock = ^(TradeManageModel *model){//评论弹框
            EvaluateView * evaluateView =  [[EvaluateView alloc]initWithTitle:@"评价" LeftBtnTitle:@"取消" RightBtnTitle:@"确定"];
            [evaluateView show];
            evaluateView.goonBlock = ^(NSString *text) {
                NSMutableDictionary * input = [NSMutableDictionary dictionary];
                [input setObject:model.userId forKey:@"okamiId"];
                [input setObject:text forKey:@"evaluate"];
                [self.viewModel.evaluateCommand execute:input];
            };
            evaluateView.closeBlock = ^{
                
            };
        };
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
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
