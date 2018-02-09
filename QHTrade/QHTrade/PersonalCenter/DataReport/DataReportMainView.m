//
//  DataReportMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/10.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "DataReportMainView.h"
#import "SettingPhoneCell.h"
@interface DataReportMainView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DataReportMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DataReportViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews {
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.left.bottom.equalTo(self);
    }];
    [super updateConstraints];
}

-(void)bindViewModel {
    [self.viewModel.totalIncomeCommand execute:@1];//加载 日 总收益视图
    [self.viewModel.totalProfitCommand execute:@1];//加载 日 总收益率
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingPhoneCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingPhoneCell];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(EarningsOfSumView *)earningsOfSumView {
    if (!_earningsOfSumView) {
        _earningsOfSumView = [[EarningsOfSumView alloc]initWithViewModel:self.viewModel];
        _earningsOfSumView.array = [NSMutableArray arrayWithObjects:@"", nil];
    }
    return _earningsOfSumView;
}
-(RateOfEarningsView *)rateOfEaringsView {
    if (!_rateOfEaringsView) {
        _rateOfEaringsView = [[RateOfEarningsView alloc]initWithViewModel:self.viewModel];
        _rateOfEaringsView.array = [NSMutableArray arrayWithObjects:@"", nil];
    }
    return _rateOfEaringsView;
}


-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:kSettingPhoneCell bundle:nil] forCellReuseIdentifier:kSettingPhoneCell];
        self.earningsOfSumView = [[EarningsOfSumView alloc]initWithViewModel:self.viewModel];
        self.earningsOfSumView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-320);
        self.rateOfEaringsView = [[RateOfEarningsView alloc]initWithViewModel:self.viewModel];
        self.rateOfEaringsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-310);
        [_tableView setTableHeaderView:self.earningsOfSumView];
        [_tableView setTableFooterView:self.rateOfEaringsView];
        
    }
    return _tableView;
}


-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = RGB(102, 102, 102);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.text = @"更新时间：2000/00/00";
    }
    return _timeLabel;
}

@end
