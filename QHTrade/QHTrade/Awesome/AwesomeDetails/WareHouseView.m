//
//  WareHouseView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "WareHouseView.h"
#import "WarehouseModel.h"
#import "MyPositionsViewModel.h"
#import "MyWarehouseCell.h"

@interface WareHouseView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIScrollView *scroll;//
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) UIView *headView;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) WarehouseModel *model;
@property(nonatomic,strong) MyPositionsViewModel *viewModel;


@end

@implementation WareHouseView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (MyPositionsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    @weakify(self)
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.equalTo(self.scroll);
        make.width.mas_offset(414);
        make.bottom.equalTo(self);
    }];
}
-(void)bindViewModel {
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        [self.table reloadData];
    }];
    
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        
        [self.table reloadData];
        NSLog(@"shuaxin=%@",x);
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.table.mj_header endRefreshing];
                
                if (!self.table.mj_footer) {
                    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        
                        [self.viewModel.warehouseCommand execute:nil];
                        
                    }];
                }
                
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.warehouseDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyWarehouseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyWarehouseCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.warehouseDataArr.count > indexPath.row){
        WarehouseModel * model = [WarehouseModel mj_objectWithKeyValues:self.viewModel.warehouseDataArr[indexPath.row]];
        cell.myModel = model;
    }
    return cell;
}



-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_table registerClass:[MyWarehouseCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyWarehouseCell class])]];
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.warehouseCommand execute:nil];
        }];
    }
    return _table;
}

-(UIView *)headView {
    if (!_headView) {
        NSArray *arrayX = @[@0,@85,@124,@179,@234,@324];
        NSArray *arrayWidth = @[@85,@39,@55,@55,@90,@90];
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 33)];
        UIView *toplineView = [[UIView alloc] initWithFrame:CGRectMake(0, 4.5, 414, 0.5)];
        toplineView.backgroundColor = RGB(205, 206, 207);
        [_headView addSubview:toplineView];
        [_headView setBackgroundColor:[UIColor whiteColor]];
        for (int i =0; i <6; i ++) {
            CGFloat x = [arrayX[i] floatValue];
            CGFloat width = [arrayWidth[i] floatValue];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, 5, width, 28)];
            [title setText:self.titleArray[i]];
            title.textAlignment = NSTextAlignmentCenter;
            title.textColor = RGB(50, 51, 52);
            title.font = [UIFont systemFontOfSize:15];
            [_headView addSubview:title];
        }
        UIView *bottomlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 32.5, 414, 0.5)];
        bottomlineView.backgroundColor = RGB(205, 206, 207);
        [_headView addSubview:bottomlineView];
    }
    return _headView;
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"合约名称",@"多空",@"手数",@"可用",@"开仓均价",@"持仓盈亏", nil];
    }
    return _titleArray;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.delegate = self;
        _scroll.contentSize = CGSizeMake(414, 0.5f);
        _scroll.bounces = NO;
        _scroll.userInteractionEnabled = YES;
        _scroll.tag = 1000;
    }
    return _scroll;
}

-(WarehouseModel *)model {
    if (!_model) {
        _model = [[WarehouseModel alloc] init];
        _model.instrumentId = @"土豆192";
        _model.posiDirection = @"123";
        _model.position = @"100";
//        _model.canUsed = @"1000";
        _model.openAmount = @"1123";
        _model.positionProfit = @"11231.231";
    }
    return _model;
}

@end
