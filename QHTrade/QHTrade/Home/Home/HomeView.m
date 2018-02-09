//
//  HomeView.m
//  QHTrade
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"
#import "HomeHeadView.h"
#import "HomeSectionView.h"

@interface HomeView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) HomeViewModel *viewModel;
@property(nonatomic,strong) UIView *headContainerView;
@property(nonatomic,strong) HomeHeadView *headView;
@end

@implementation HomeView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HomeViewModel *)viewModel;
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
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headContainerView);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getawesomeScrollCommand execute:nil];
    [self.viewModel.refreshUISubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.table reloadData];
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.table.mj_header endRefreshing];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.newsDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeTableViewCell class])]];
    cell.model = self.viewModel.newsDataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsModel *model = self.viewModel.newsDataArray[indexPath.row];
    [self.viewModel.tableCellClickSubject sendNext:model];
}


-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableHeaderView = self.headContainerView;
        _table.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
        [_table registerClass:[HomeTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeTableViewCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getHomeCollectionCommand execute:@"0"];
            [self.viewModel.getContractListCommand execute:@"0"];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getHomeCollectionCommand execute:nil];
        }];
    }
    return _table;
}

-(HomeHeadView *)headView {
    if (!_headView) {
        _headView = [[HomeHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _headView;
}

-(UIView *)headContainerView {
    if (!_headContainerView) {
        _headContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.44+(SCREEN_WIDTH-32)/3+80)];
        [_headContainerView addSubview:self.headView];
    }
    return _headContainerView;
}


@end
