//
//  EvaluationView.m
//  QHTrade
//
//  Created by user on 2017/11/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "EvaluationView.h"
#import "EvaluationViewCell.h"
#import "EvaluationModel.h"
#import "AwesomeDetailsViewModel.h"

@interface EvaluationView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) AwesomeDetailsViewModel *viewModel;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,assign) int page;
@end

@implementation EvaluationView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (AwesomeDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshEvaluationSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
    }];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.evaluationArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EvaluationModel* model = self.viewModel.evaluationArray[indexPath.row];
    return model.height+50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EvaluationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([EvaluationViewCell class])] forIndexPath:indexPath];
    EvaluationModel* model = self.viewModel.evaluationArray[indexPath.row];
    cell.model = model;
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
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.sectionHeaderHeight = 10;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[EvaluationViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([EvaluationViewCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            self.page = 1;
            [self.viewModel.EvaluationCommand execute:[NSString stringWithFormat:@"%d",self.page]];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.page++;
            [self.viewModel.EvaluationCommand execute:[NSString stringWithFormat:@"%d",self.page]];
        }];
        [_table.mj_header beginRefreshing];
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
