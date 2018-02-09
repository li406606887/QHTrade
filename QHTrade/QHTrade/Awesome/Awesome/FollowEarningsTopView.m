//
//  FollowEarningsTopView.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningsTopView.h"
#import "FollowEarningsTopTableCell.h"
#import "FollowEarningsTopThreeCell.h"
#import "AwesomeViewModel.h"


@interface FollowEarningsTopView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) AwesomeViewModel *viewModel;
@property(nonatomic,strong) UITableView *table;
@end

@implementation FollowEarningsTopView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self.table.mj_header beginRefreshing];
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
    [self.viewModel.followEarningsRefreshDataSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
        if (self.viewModel.followEarningsDataArray.count>0) {
            [self hiddenLoadingFailed];
        }else{
            [self loadingFailed];
        }
        
        [self.table.mj_footer endRefreshing];
        [self.table.mj_header endRefreshing];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.followEarningsDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row>2 ? 70:85;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<3) {
        FollowEarningsTopThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningsTopThreeCell class])]];
        cell.model = self.viewModel.followEarningsDataArray[indexPath.row];
        cell.tag = indexPath.row;
        return cell;
    }else {
        FollowEarningsTopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningsTopTableCell class])]];
        cell.model = self.viewModel.followEarningsDataArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.followEarningsCellClick sendNext:self.viewModel.followEarningsDataArray[indexPath.row]];
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
        _table.rowHeight = 85;
        _table.sectionHeaderHeight = 10;
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        [_table registerClass:[FollowEarningsTopTableCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningsTopTableCell class])]];
        [_table registerClass:[FollowEarningsTopThreeCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningsTopThreeCell class])]];
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.followEarningsDataCommand execute:@"1"];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.followEarningsDataCommand execute:nil];
        }];
    }
    return _table;
}
@end
