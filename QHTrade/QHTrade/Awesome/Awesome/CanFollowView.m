//
//  CanFollowView.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "CanFollowView.h"
#import "AwesomeViewModel.h"
#import "AwesomeTableViewCell.h"

@interface CanFollowView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) AwesomeViewModel *viewModel;
@property(nonatomic,strong) UITableView *table;
@end

@implementation CanFollowView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeViewModel*)viewModel;
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
    [self.viewModel.canRefreshDataSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
        if (self.viewModel.canFollowDataArray.count>0) {
            [self hiddenLoadingFailed];
        }else{
            [self loadingFailed];
        }
        [self.table.mj_footer endRefreshing];
        [self.table.mj_header endRefreshing];
    }];
    [self.table.mj_header beginRefreshing];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.canFollowDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AwesomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AwesomeTableViewCell class])]];
    cell.tag = indexPath.row+9000;
    cell.FollowAwesomeBlock = ^(AwesomeModel *model) {
        [self.viewModel.awesomeFollowActionClick sendNext:model];
    };
    cell.model = self.viewModel.canFollowDataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.awesomeCellClick sendNext:self.viewModel.canFollowDataArray[indexPath.row]];
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
        _table.dataSource = self;
        _table.delegate = self;
        _table.rowHeight = 203;
        _table.sectionHeaderHeight = 10;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.separatorStyle = UITableViewCellSelectionStyleNone;
         [_table registerClass:[AwesomeTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AwesomeTableViewCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.canDataCommand execute:@"1"];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.canDataCommand execute:nil];
        }];
    }
    return _table;
}
@end
