//
//  ChooseCompanyMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChooseCompanyMainView.h"
#import "ChineseString.h"
#import "CompanyChooseCell.h"
#import "ChooseCompanyModel.h"

@interface ChooseCompanyMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * companyArray;//数据源
@property (nonatomic,strong) NSMutableArray * indexArray;//
@property (nonatomic,strong) NSMutableArray * letterResultArr;
@property (nonatomic,strong) NSMutableArray * allLetterArr;//
@property (nonatomic,strong) UIView * headView;
@end

@implementation ChooseCompanyMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (ChooseCompanyViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
}
-(void)bindViewModel {
    [self.viewModel.requestCommand execute:nil];
    
    [self.viewModel.refreshUI subscribeNext:^(NSMutableArray * x) {
        
        self.companyArray = x;
        self.indexArray = [ChineseString IndexArray:self.companyArray];
        self.letterResultArr = [ChineseString LetterSortArray:self.companyArray];
        self.allLetterArr = [ChineseString allLerrt];//所有字母
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

//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * key = [self.indexArray objectAtIndex:section];
    return key;
}
//点击索引
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}
//显示每组标题索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.indexArray;//数据源内包含的首字母
    return self.allLetterArr;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lab = [UILabel new];
    lab.backgroundColor = RGB(236, 236, 236);
    lab.text = [NSString stringWithFormat:@"    %@",[self.indexArray objectAtIndex:section]];
    lab.textColor = RGB(102, 102, 102);
    return lab;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyChooseCell class])]];
    NSString * str = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.companyLabel.text = [str componentsSeparatedByString:@"i"][0];//截取i之前
//    if (self.viewModel.dataArray.count > indexPath.row){
//        ChooseCompanyModel * model = [ChooseCompanyModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
//        cell.model = model;
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * string = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [self.viewModel.cellClickSubject sendNext:string];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"section=%lu",(unsigned long)[[self.letterResultArr objectAtIndex:section] count]);
    return [[self.letterResultArr objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArray.count;
//    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionIndexColor = RGB(102, 102, 102);
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        [_tableView setTableHeaderView:self.headView];
        [_tableView.tableHeaderView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        [_tableView registerClass:[CompanyChooseCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CompanyChooseCell class])]];
        //数据源
        self.companyArray = [NSMutableArray array];

//        self.indexArray = [ChineseString IndexArray:self.companyArray];
//        self.letterResultArr = [ChineseString LetterSortArray:self.companyArray];
//        self.allLetterArr = [ChineseString allLerrt];
    }
    return _tableView;
}
-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [UIColor whiteColor];
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = RGB(236, 236, 236);
        UILabel * label = [[UILabel alloc]init];
        label.text = @"瑞达期货经纪有限公司";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        UIImageView * leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_left"]];
        UIImageView * rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"star_right"]];
        
        _headView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            [self.viewModel.cellClickSubject sendNext:@"瑞达期货经纪有限公司id=1z"];
        }];
        [_headView addGestureRecognizer:tap];
        
        [_headView addSubview:topView];
        [_headView addSubview:label];
        [topView addSubview:leftView];
        [topView addSubview:rightView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_headView);
            make.height.mas_offset(20);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom);
            make.bottom.equalTo(_headView);
            make.left.equalTo(_headView).with.offset(35);
            make.width.mas_equalTo(250);
        }];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.left.equalTo(topView).with.offset(16);
            make.size.mas_offset(CGSizeMake(13, 12));
        }];
        
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(topView);
            make.right.equalTo(topView).with.offset(-16);
            make.size.mas_offset(CGSizeMake(11, 10));
        }];
    }
    return _headView;
}


@end
