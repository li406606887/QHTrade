//
//  AwesomeSignalMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/13.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AwesomeSignalMainView.h"
#import "AwesomeSignalCell.h"
#import "AwesomeSignalModel.h"
@interface AwesomeSignalMainView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AwesomeSignalMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (AwesomeSiganlViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    [self addSubview:self.tableView];
    
    [super setNeedsUpdateConstraints];
    [super updateConstraintsIfNeeded];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
}

//tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AwesomeSignalCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AwesomeSignalCell class])]];
    
    if (self.viewModel.dataArray.count>indexPath.row){
        AwesomeSignalModel * model = [AwesomeSignalModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        cell.model = model;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;//233
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(243, 244, 245);//背景色
        [_tableView registerClass:[AwesomeSignalCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AwesomeSignalCell class])]];
        @weakify(self)
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.refreshDataCommand execute:nil];
        }];
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            @strongify(self)
//            [self.viewModel.refreshDataCommand execute:nil];
//        }];
    }
    return _tableView;
}
-(void)bindViewModel {
    
//    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self)
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];
        if (self.viewModel.dataArray.count>0) {
            [self hiddenLoadingFailed];
        }else{
            [self loadingFailed];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        [self.tableView reloadData];
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        
                        [self.viewModel.refreshDataCommand execute:nil];
                        
                    }];
                }
                break;
                
            case HeaderRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                self.tableView.mj_footer = nil;
                
                break;
                
            case FooterRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                
                break;
                
            case FooterRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                break;
            case RefreshError:
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                break;
                
            default:
                break;
        }
    }];
    
}
@end
