//
//  DiamondRecordMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DiamondRecordMainView.h"
#import "DiamondRecordCell.h"
#import "DiamondRecordModel.h"

@interface DiamondRecordMainView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DiamondRecordMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (DiamondRecordViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
    }
    return self;
}
-(void)bindViewModel {
    [self.viewModel.requestCommand execute:nil];
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        [self.tableView reloadData];
    }];
    
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        
        [self.tableView reloadData];
        NSLog(@"shuaxin=%@",x);
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        
                        
                        [self.viewModel.requestCommand execute:nil];
                        
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DiamondRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:kDiamondRecordCell];
    if (self.viewModel.dataArray.count > indexPath.row){
        DiamondRecordModel * model = [DiamondRecordModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        cell.model = model;
    }
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(void)addChildView{

    [self addSubview:self.tableView];
    
    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:kDiamondRecordCell bundle:nil] forCellReuseIdentifier:kDiamondRecordCell];
        
        _tableView.backgroundColor = RGB(244, 244, 244);
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        view.backgroundColor = RGB(244, 244, 244);
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 4, SCREEN_WIDTH, 1)];
        view1.backgroundColor = RGB(180, 180, 180);
        [view addSubview:view1];
        [_tableView setTableHeaderView:view];
        _tableView.tableHeaderView.height = 5;
        
    }
    return _tableView;
}

-(DiamondRecordViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[DiamondRecordViewModel alloc]init];
    }
    return _viewModel;
}

@end
