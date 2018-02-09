//
//  MyContractView.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "MyContractView.h"
#import "MyContractViewModel.h"
#import "MyContractHeadView.h"
#import "MyContractCollectionCellView.h"
#import "PositionView.h"


@interface MyContractView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)MyContractHeadView *myContractHeadView;
@property(nonatomic,strong)PositionView *positionView;
@property(nonatomic,strong)MyContractViewModel *viewModel;
@end

@implementation MyContractView

-(void)setupViews{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.headView];
    [self addSubview:self.positionView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"MyContract");
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MyContractViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)bindViewModel{
    [self.viewModel.segmentControlClickSubject subscribeNext:^(id  _Nullable x) {
        
    }];
}

-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 280));
    }];
    [self.myContractHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.headView);
    }];
    [self.positionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-419));
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([UITableViewCell class])]];
    
    return cell;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table setBackgroundColor:DEFAULT_BG_COLOR];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([UITableViewCell class])]];
    }
    return _table;
}
-(UIView *)headView{
    if (!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,280)];
        [_headView setBackgroundColor:[UIColor whiteColor]];
        [_headView addSubview:self.myContractHeadView];
    }
    return _headView;
}

-(MyContractHeadView *)myContractHeadView{
    if (!_myContractHeadView) {
        _myContractHeadView = [[MyContractHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _myContractHeadView;
}
-(PositionView *)positionView{
    if (!_positionView) {
        _positionView = [[PositionView alloc] init];
    }
    return _positionView;
}
@end
