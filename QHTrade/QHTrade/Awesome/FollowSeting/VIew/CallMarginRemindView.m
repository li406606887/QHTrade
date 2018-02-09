//
//  CallMarginRemindView.m
//  PolicyAide
//
//  Created by 吴桂钊 on 2017/12/29.
//  Copyright © 2017年 QHTeam. All rights reserved.
// 补仓提醒

#import "CallMarginRemindView.h"
#import "CallMarginRemindCell.h"
#import "FollowSetingViewModel.h"

@interface CallMarginRemindView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) FollowSetingViewModel *viewModel;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) UILabel *title;//
@property(nonatomic,strong) UIImageView *redImgView;
@property(nonatomic,strong) UILabel *positionLabel;//牛人持仓
@property(nonatomic,strong) UILabel *remindLabel;//补仓提醒
@property(nonatomic,strong) UIButton *iKnowBtn;//补仓提醒
@end

@implementation CallMarginRemindView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FollowSetingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.title];
    [self.bgView addSubview:self.redImgView];
    [self.bgView addSubview:self.positionLabel];
    [self.bgView addSubview:self.table];
    [self.bgView addSubview:self.remindLabel];
    [self.bgView addSubview:self.iKnowBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 420));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(15);
        make.size.mas_offset(CGSizeMake(300, 20));
    }];
    [self.redImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.top.equalTo(self.title.mas_bottom).offset(20);
        make.size.mas_offset(CGSizeMake(5, 15));
    }];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.redImgView);
        make.left.equalTo(self.redImgView.mas_right).offset(5);
        make.size.mas_offset(CGSizeMake(90, 20));
    }];
    [self.iKnowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-15);
        make.size.mas_offset(CGSizeMake(150, 30));
    }];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iKnowBtn.mas_top).offset(-15);
        make.left.equalTo(self.bgView).offset(5);
        make.right.equalTo(self.bgView).offset(-5);
        make.height.mas_offset(120);
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.positionLabel.mas_bottom).offset(10);
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.bottom.equalTo(self.remindLabel.mas_top).offset(10);
    }];
    
    [super updateConstraints];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.getAwesomePositionCommand execute:nil];
    [self.viewModel.refreshPositionUISubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
    }];
}

-(void)setPromptString:(NSString *)promptString {
    self.remindLabel.text = promptString;
}

#pragma mark - table 代理事件
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallMarginRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CallMarginRemindCell class])] forIndexPath:indexPath];
    if (indexPath.row != 0) {
        cell.model = self.viewModel.dataArray[indexPath.row-1];
    }
    
    return cell;
}

#pragma mark  懒加载
-(UIButton *)iKnowBtn {
    if (!_iKnowBtn) {
        _iKnowBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iKnowBtn setTitle:@"我已知晓" forState:UIControlStateNormal];
        [_iKnowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_iKnowBtn setBackgroundColor:RGB(255,98,1)];
        _iKnowBtn.layer.cornerRadius =4.0f;
        _iKnowBtn.layer.masksToBounds = YES;
        WS(weakSelf)
        [[_iKnowBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self removeFromSuperview];
            [weakSelf.viewModel.popViewControllerSubject sendNext:nil];
        }];
    }
    return _iKnowBtn;
}

-(UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc]init];
        _remindLabel.numberOfLines = 0;
        _remindLabel.textColor = RGB(68, 68, 68);
        _remindLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _remindLabel;
}

-(UILabel *)positionLabel {
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc]init];
        _positionLabel.text = @"牛人持仓";
        _positionLabel.font = [UIFont systemFontOfSize:15];
        _positionLabel.textColor = RGB(51, 51, 51);
    }
    return _positionLabel;
}

-(UIImageView *)redImgView {
    if (!_redImgView) {
        _redImgView =[[UIImageView alloc]init];
        _redImgView.backgroundColor = RGB(255, 98, 1);
    }
    return _redImgView;
}
-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"补仓提醒";
        _title.font = [UIFont systemFontOfSize:18.0f];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}
//白色背景
-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4.0f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}


-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[CallMarginRemindCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CallMarginRemindCell class])]];
    }
    return _table;
}

@end
