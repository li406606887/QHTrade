//
//  PersonalMasterView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/30.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalMasterView.h"
#import "PersonalViewModel.h"
#import "PersonalSecondCell.h"
#import "PersonalButtonCell.h"
#import "PersonalTableHeadView.h"

@interface PersonalMasterView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,assign) CGFloat topHeight;//topView高度
@property (nonatomic,strong) PersonalTableHeadView *headView;
@end


@implementation PersonalMasterView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    self.dataArray = @[@"--",@"--",@"--",@"--",@"--",@"--",@"--"];
    [self addSubview:self.tableView];    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}
//
-(void)bindViewModel {
    //根据交易账户是否登录信号来更新UI
    [[self.viewModel.tradeAccountIsLogin takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {
//        if ([x isEqualToString:@"1"]) {
//            [self tradeAccountBtnClickWithLogin:YES animated:YES];
//        } else [self tradeAccountBtnClickWithLogin:NO animated:YES];
    }];
}
//登录账户
//-(void)tradeAccountBtnClickWithLogin:(BOOL)isLogin animated:(BOOL)animated {
//    self.isLogin = isLogin;
//    if (self.isLogin) {
//        self.topLogButton.hidden = YES;
//        self.topViewLabel.hidden = YES;
//        self.topViewLabel1.hidden = YES;
//    }else {
//        self.topLogButton.hidden = NO;
//        self.topViewLabel.hidden = NO;
//        self.topViewLabel1.hidden = NO;
//    }
//    //隐藏topView
//    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self);
//        self.topHeight = self.isLogin ? 0 :50;
//        make.height.mas_equalTo(self.topHeight).priorityLow();
//    }];
//
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topView.mas_bottom);
//        make.bottom.left.right.equalTo(self);
//    }];
//
//    if (animated) {
//        [self setNeedsUpdateConstraints];
//        [self updateConstraintsIfNeeded];
//        [UIView animateWithDuration:0.5 animations:^{
//            [self layoutIfNeeded];
//        }];
//    }
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.viewModel.positionsClick sendNext:nil];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalSecondCell *colectCell = [tableView dequeueReusableCellWithIdentifier:kPersonalSecondCell];
    colectCell.selectionStyle = UITableViewCellSelectionStyleNone;
    PersonalButtonCell * btnCell = [tableView dequeueReusableCellWithIdentifier:kPersonalButtonCell];
    btnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0: {
            //点击cell里的collect
            colectCell.tapBlock = ^{
                [self.viewModel.positionsClick sendNext:nil];
            };
            [colectCell setDataArray:self.dataArray];
            return colectCell;
        }
            break;
        case 1: {
            btnCell.manageBlock = ^{
                [self.viewModel.middleCellClick sendNext:@"1"];
            };
            btnCell.signalBlock = ^{
                [self.viewModel.middleCellClick sendNext:@"2"];
            };
            btnCell.statisticBlock = ^{
                [self.viewModel.middleCellClick sendNext:@"3"];
            };
            btnCell.reportBlock = ^{
                [self.viewModel.middleCellClick sendNext:@"4"];
            };
            return btnCell;
        }
            break;
        default:
            break;
    }
    return colectCell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 233)];
    [sectionView addSubview:self.tableSectionView];
    [self.tableSectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 15, 10, 15));
    }];
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 233.0f;
}
#pragma mark -- 交易账户登录按钮
//-(UIButton *)topLogButton{
//    if (!_topLogButton) {
//        _topLogButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_topLogButton setBackgroundColor:RGB(255,98,1)];
//        _topLogButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        [_topLogButton setTitle:@"登录并跟单" forState:UIControlStateNormal];
//        [[_topLogButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            [self tradeAccountBtnClickWithLogin:!self.isLogin animated:YES];
//            [self.viewModel.tradeAccountLoginBtnClick sendNext:nil];
//        }];
//
//        _topLogButton.layer.cornerRadius = 12.5;
//        _topLogButton.layer.masksToBounds = YES;
//    }
//    return _topLogButton;
//}
//-(UILabel *)topViewLabel {
//    if (!_topViewLabel) {
//        _topViewLabel = [[UILabel alloc]init];
//        _topViewLabel.text = @"交易账户未登录";
//        _topViewLabel.font = [UIFont systemFontOfSize:14.0f];
//        _topViewLabel.textColor = RGB(68, 68, 68);
//    }
//    return _topViewLabel;
//}
//-(UILabel *)topViewLabel1 {
//    if (!_topViewLabel1) {
//        _topViewLabel1 = [[UILabel alloc]init];
//        _topViewLabel1.text = @"交易账户登录后开始自动跟单";
//        _topViewLabel1.font = [UIFont systemFontOfSize:12.0f];
//        _topViewLabel1.textColor = RGB(68, 68, 68);
//    }
//    return _topViewLabel1;
//}
//-(UIView *)lineView {
//    if (!_lineView) {
//        _lineView = [[UIView alloc]init];
//        _lineView.backgroundColor = RGB(243, 244, 245);
//    }
//    return _lineView;
//}
//-(UIView *)topView {
//    if (!_topView) {
//        _topView = [[UIView alloc]init];
//        _topView.backgroundColor = [UIColor whiteColor];
//        [_topView addSubview:self.topViewLabel];
//        [_topView addSubview:self.topViewLabel1];
//        [_topView addSubview:self.topLogButton];
//        [_topView addSubview:self.lineView];
//        UIView * line = [[UIView alloc]init];
//        line.backgroundColor = RGB(243, 244, 245);
//        [_topView addSubview:line];
//
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_topView);
//            make.left.right.equalTo(_topView);
//            make.height.mas_equalTo(1);
//        }];
//
//        [self.topLogButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(_topView).with.offset(-2.5);
//            make.right.equalTo(_topView).with.offset(-15);
//            make.size.mas_equalTo(CGSizeMake(90, 25));
//        }];
//
//        [self.topViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_topView).with.offset(5);
//            make.left.equalTo(_topView).with.offset(15);
//            make.size.mas_equalTo(CGSizeMake(180, 16));
//        }];
//
//        [self.topViewLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.topViewLabel.mas_bottom).with.offset(0);
//            make.left.equalTo(_topView).with.offset(15);
//            make.size.mas_equalTo(CGSizeMake(180, 16));
//        }];
//
//        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.left.right.equalTo(_topView);
//            make.height.mas_equalTo(5);
//        }];
//    }
//    return _topView;
//}

-(PersonalTableFootView *)tableFootView {
    if (!_tableFootView) {
        _tableFootView = [[PersonalTableFootView alloc]initWithViewModel:self.viewModel];
        _tableFootView.backgroundColor = [UIColor whiteColor];
    }
    return _tableFootView;
}

-(PersonalTabeSectionView *)tableSectionView {
    if (!_tableSectionView) {
        _tableSectionView = [[PersonalTabeSectionView alloc]initWithViewModel:self.viewModel];
    }
    return _tableSectionView;
}

-(PersonalTableHeadView *)headView {
    if (!_headView) {
        _headView = [[PersonalTableHeadView alloc] initWithViewModel:self.viewModel];
        
    }
    return _headView;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView * foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        [foot addSubview:self.tableFootView];
        [self.tableFootView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(foot);
        }];
        [_tableView setTableFooterView:foot];
        UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [head addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(10, 15, 10, 15));
        }];
        [_tableView setTableHeaderView:head];
        [_tableView registerNib:[UINib nibWithNibName:kPersonalSecondCell bundle:nil] forCellReuseIdentifier:kPersonalSecondCell];
        [_tableView registerNib:[UINib nibWithNibName:kPersonalButtonCell bundle:nil] forCellReuseIdentifier:kPersonalButtonCell];
    }
    return _tableView;
}

@end
