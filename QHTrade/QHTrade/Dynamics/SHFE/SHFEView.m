//
//  SHFEView.m
//  QHTrade
//
//  Created by user on 2017/6/7.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SHFEView.h"
#import "SHFEViewModel.h"
#import "SHFEHeadView.h"

@interface SHFEView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)SHFEHeadView *dynamicsSectionView;
@property(nonatomic,strong)SHFEViewModel *buttonClickViewModel;

@end

@implementation SHFEView

-(void)setupViews{
    [self addSubview:self.table];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.buttonClickViewModel = (SHFEViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)updateConstraints{
    [super updateConstraints];
    @weakify(self)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self);
    }];
    [self.dynamicsSectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.headView);
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
        _table.tableHeaderView = self.headView;
        [_table setBackgroundColor:DEFAULT_BG_COLOR];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([UITableViewCell class])]];
    }
    return _table;
}
-(UIView *)headView{
    if (!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        [_headView addSubview:self.dynamicsSectionView];
    }
    return _headView;
}
-(SHFEViewModel *)buttonClickViewModel{
    if (!_buttonClickViewModel) {
        _buttonClickViewModel = [[SHFEViewModel alloc] init];
    }
    return _buttonClickViewModel;
}
-(SHFEHeadView *)dynamicsSectionView{
    if (!_dynamicsSectionView) {
        _dynamicsSectionView = [[SHFEHeadView alloc] initWithViewModel:self.buttonClickViewModel];
    }
    return _dynamicsSectionView;
}



@end
