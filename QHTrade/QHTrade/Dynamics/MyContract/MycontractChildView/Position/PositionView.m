//
//  PositionView.m
//  QHTrade
//
//  Created by user on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PositionView.h"
#import "MyContractViewModel.h"
#import "PositionTableViewCell.h"
#import "PositionModel.h"
#import "MyContractViewModel.h"

@interface PositionView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scroll;//
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)PositionModel *model;
@property(nonatomic,strong)MyContractViewModel *viewModel;
@end

@implementation PositionView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MyContractViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews{
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.table];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self);
    }];
    NSLog(@"%f",self.scroll.frame.size.height);
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(414, SCREEN_HEIGHT-419));
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([PositionTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[self.table class]]) {
        NSLog(@"hahah");
    }else{
        NSLog(@"xxxxxx");
    }
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
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[PositionTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([PositionTableViewCell class])]];
    }
    return _table;
}
-(UIView *)headView{
    if (!_headView) {
        NSArray *arrayX = @[@0,@85,@124,@179,@234,@324];
        NSArray *arrayWidth = @[@85,@39,@55,@55,@90,@90];
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        [_headView setBackgroundColor:[UIColor whiteColor]];
        for (int i =0; i <6; i ++) {
            CGFloat x = [arrayX[i] floatValue];
            CGFloat width = [arrayWidth[i] floatValue];
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width, 30)];
            [title setText:self.titleArray[i]];
            title.textAlignment = NSTextAlignmentCenter;
            title.textColor = RGB(164, 164, 165);
            title.font = [UIFont systemFontOfSize:14];
            [_headView addSubview:title];
        }
        
    }
    return _headView;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"合约名称",@"多空",@"手数",@"可用",@"开仓均价",@"逐笔浮盈", nil];
    }
    return _titleArray;
}
-(UIScrollView *)scroll{
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

-(PositionModel *)model{
    if (!_model) {
        _model = [[PositionModel alloc] init];
        _model.contractName = @"我的合约啊";
        _model.moreEmpty = YES;
        _model.numberHand = @"1000";
        _model.canUsed = @"1000";
        _model.averageOpen = @"11231.312";
        _model.chasesGains = @"11231.231";
    }
    return _model;
}
@end
