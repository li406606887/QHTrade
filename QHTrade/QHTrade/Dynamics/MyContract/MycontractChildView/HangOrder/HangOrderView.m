//
//  HangOrderView.m
//  QHTrade
//
//  Created by user on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "HangOrderView.h"
#import "MyContractViewModel.h"
#import "HangOrderTableViewCell.h"


@interface HangOrderView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scrollView;//滑动view
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray *titleArray;
@end

@implementation HangOrderView


-(void)setupViews{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.table];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [super updateConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HangOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HangOrderTableViewCell class])]];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
    }
    return _scrollView;
}
-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.headView;
        [_table registerClass:[HangOrderTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HangOrderTableViewCell class])]];
    }
    return _table;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        for (int i =0; i <self.titleArray.count; i ++) {
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*i, 0, SCREEN_WIDTH/5, 30)];
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
        _titleArray = [NSArray arrayWithObjects:@"合约名称",@"开平",@"委托价",@"委托量",@"挂单量", nil];
    }
    return _titleArray;
}
@end
