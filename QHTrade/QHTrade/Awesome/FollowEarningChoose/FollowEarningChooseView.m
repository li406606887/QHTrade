//
//  FollowEarningChooseView.m
//  QHTrade
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "FollowEarningChooseView.h"
#import "FollowEarningChooseViewModel.h"
#import "FollowEarningChooseCell.h"
#import "FollowEarningChooseHeadView.h"

@interface FollowEarningChooseView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) FollowEarningChooseViewModel *viewModel;
@property(nonatomic,strong) FollowEarningChooseHeadView *headView;
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) NSMutableArray *textArray;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) NSMutableArray *priceArray;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) UIButton *surePay;
@property(nonatomic,assign) int selectedIndex;
@end

@implementation FollowEarningChooseView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowEarningChooseViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.scroll];
    [self.scroll addSubview:self.headView];
    [self.scroll addSubview:self.table];
    [self.scroll addSubview:self.surePay];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 210));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 285));
    }];
    
    [self.surePay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.table.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.scroll);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 40));
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.tableReloadSubject subscribeNext:^(FollowSetingModel * _Nullable model) {
        @strongify(self)
        [self.viewModel.setingModelDic setObject:model forKey:[NSString stringWithFormat:@"%d",self.selectedIndex]];
        [self.table reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, SCREEN_WIDTH, 30)];
    [title setText:@"跟单类型:"];
    [title setFont:[UIFont systemFontOfSize:14]];
    [sectionView addSubview:title];
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 65: 95;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowEarningChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningChooseCell class])]];
    cell.textBody = self.textArray[indexPath.row];
    cell.price = self.priceArray[indexPath.row];
    cell.title = self.titleArray[indexPath.row];
    FollowSetingModel *setingModel = [self.viewModel.setingModelDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    cell.setingModel = setingModel;
    cell.type = indexPath.row == 0 ? 1: 0;
    if(indexPath.row==self.selectedIndex) [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = (int)indexPath.row;
    if (indexPath.row == 0) return;
    [self.viewModel.cellClickSubject sendNext:[NSString stringWithFormat:@"%ld",indexPath.row]];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.dataSource = self;
        _table.delegate = self;
        _table.bounces = NO;
        _table.layer.masksToBounds = YES;
        _table.layer.cornerRadius = 5;
        _table.layer.borderWidth = 0.5f;
        _table.layer.borderColor =RGB(220, 220, 220).CGColor;
        [_table registerClass:[FollowEarningChooseCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FollowEarningChooseCell class])]];
    }
    return _table;
}

-(FollowEarningChooseHeadView *)headView {
    if (!_headView) {
        _headView = [[FollowEarningChooseHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _headView;
}

-(NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [[NSMutableArray alloc] initWithObjects:@"仅订阅牛人成交信号,不自动跟单",@"订阅牛人成交信号，每日白盘或夜盘期间需手动登录交易账户后才会自动跟单",@"订阅牛人成交信号并自动跟单,无需手动开启", nil];
    }
    return _textArray;
}

-(NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"订阅信号",@"半自动跟单",@"自动跟单", nil];
    }
    return _titleArray;
}

-(NSMutableArray *)priceArray {
    if (!_priceArray) {
        _priceArray = [[NSMutableArray alloc] initWithObjects:@"30钻石/月",@"300钻石/月",@"300钻石/月", nil];
    }
    return _priceArray;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] init];
        _scroll.contentSize = CGSizeMake(0.5f, 565);
    }
    return _scroll;
}

-(UIButton *)surePay {
    if (!_surePay) {
        _surePay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_surePay setTitle:@"确认跟单并支付" forState:UIControlStateNormal];
        [_surePay setBackgroundColor:RGB(251, 108, 39)];
        _surePay.layer.masksToBounds = YES;
        _surePay.layer.cornerRadius = 3;
        [_surePay setFrame:CGRectMake(16, 5, SCREEN_WIDTH-32, 40)];
        @weakify(self)
        [[_surePay rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![[UserInformation getInformation] getLoginState]) {
                [self.viewModel.gotoLoginSubject sendNext:nil];
                return ;
            }
            if ([[UserInformation getInformation].userModel.fierce intValue]==1) {
                showMassage(@"牛人不可以跟单");
                return;
            }
            if ([UserInformation getInformation].userModel.ctpAccount.length<1) {
                PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle:@"请先绑定资金账户后才能订阅并跟单" LeftBtnTitle:@"暂不绑定" RightBtnTitle:@"去绑定"];
                promptView.goonBlock = ^(){
                    [self.viewModel.gotoBindCTPAcountSubject sendNext:nil];
                };
                [promptView show];
                return ;
            }
            NSIndexPath *indexPath = self.table.indexPathForSelectedRow;
            int index = (int)(indexPath.row +1);
            if ([self promptTitle:index]!=YES) {
                PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle:@"钻石数量不足,请先购买" LeftBtnTitle:@"暂不跟单" RightBtnTitle:@"去购买"];
                promptView.goonBlock = ^(){
                    [self.viewModel.gotoBuyDiamondSubject sendNext:nil];
                };
                [promptView show];
                return ;
            }
            NSString * money;
            if (index == 1) {
                money = @"30";
            }else money = @"300";
            PromptView *promptView = [[PromptView alloc] initWithTitle:@"提示" SubTitle: [NSString stringWithFormat:@"本次跟单需支付%@钻石，确定跟单吗？",money] LeftBtnTitle:@"暂不跟单" RightBtnTitle:@"马上跟单"];
            promptView.goonBlock = ^(){
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:[NSString stringWithFormat:@"%d",index] forKey:@"type"];
                [param setObject:self.viewModel.model.userId forKey:@"userId"];
                [self.viewModel.followEarningSumbitCommand execute:param];
            };
            [promptView show];
        }];
    }
    return _surePay;
}



-(int)selectedIndex {
    if (!_selectedIndex) {
        _selectedIndex = 0;
    }
    return _selectedIndex;
}
-(BOOL)promptTitle:(int)index{
    if (index==1) {
        return [[UserInformation getInformation].userModel.diamond intValue]>30 ? YES:NO ;
    }else{
        return [[UserInformation getInformation].userModel.diamond intValue]>300 ? YES:NO ;
    }
    return YES;
}
@end

