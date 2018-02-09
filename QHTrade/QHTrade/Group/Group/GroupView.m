//
//  GroupView.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "GroupView.h"
#import "GroupViewModel.h"
#import "GroupTableViewCell.h"

@interface GroupView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) GroupViewModel *viewModel;
@property(nonatomic,assign) int oldIndex;

@end

@implementation GroupView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupViewModel *)viewModel;
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
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.viewModel.dataArray.count>0) {
            [self hiddenLoadingFailed];
        }else{
            [self loadingFailed];
        }
        [self.table.mj_header endRefreshing];
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];

    }];
    
    [self.viewModel.refreshPriseStateSubject subscribeNext:^(GroupModel*  _Nullable model) {
        @strongify(self)
        self.viewModel.dataArray[self.oldIndex] = model;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.oldIndex inSection:0];
        [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125.5+[self.viewModel.cellHeightArray[indexPath.row] intValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    cell.cellHeight = [self.viewModel.cellHeightArray[indexPath.row] floatValue];
    cell.tag = indexPath.row;
    @weakify(self)
    cell.praiseBlock = ^(int tag, NSMutableDictionary *param) {
        @strongify(self)
        if (![[UserInformation getInformation] getLoginState]) {
            [self.viewModel.gotoLoginSubject sendNext:nil];
            return ;
        }
        [self.viewModel.groupPriseCommand execute:param];
        self.oldIndex = tag;
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.oldIndex = (int)indexPath.row;
    [self.viewModel.groupCellClickSubject sendNext:self.viewModel.dataArray[indexPath.row]];
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
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        [_table registerClass:[GroupTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupTableViewCell class])]];
        _table.sectionHeaderHeight = 0.5f;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.requestGroupDataCommand execute:@"1"];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.requestGroupDataCommand execute:nil];
        }];
    }
    return _table;
}

@end
