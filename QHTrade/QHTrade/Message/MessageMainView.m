//
//  MessageMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/7/11.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MessageMainView.h"
#import "MessageViewModel.h"
#import "MessageMainCell.h"

@interface MessageMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) MessageViewModel * viewModel;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MessageMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (MessageViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadingFailed];//空数据
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    @strongify(self)
        make.edges.equalTo(self);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageMainCell class])]];
    cell.model = self.model;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

-(MessageModel *)model {
    if (!_model) {
        _model = [[MessageModel alloc]init];
        _model.timeString = @"10-00 10:00";
        _model.titleString = @"1000100010001000100010100010100010100010100010";
        _model.contentString = @"1000100010001000100010001000100010001000100010001000100010100010100010100010100010100010";
    }
    return _model;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageMainCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MessageMainCell class])]];
    }
    return _tableView;
}

@end
