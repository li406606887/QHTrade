//
//  PersonalMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "PersonalMainView.h"
#import "PersonalViewModel.h"
#import "PersonalFirstCell.h"
#import "PersonalSecondCell.h"
#import "UserModel.h"

@interface PersonalMainView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isFirstSegClick;//是否第一个seg点击
}

@property (nonatomic,strong)PersonalViewModel * viewModel;
@property (nonatomic,strong)UISegmentedControl * segment;

@end

@implementation PersonalMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{

    self.viewModel = (PersonalViewModel *)viewModel;
    return [super initWithViewModel:viewModel];

}
-(void)bindViewModel {
    WS(weakSelf)
    [self.viewModel.userInfoCommand execute:nil];
    [self.viewModel.refreshUI subscribeNext:^(UserModel * model) {
        
        NSLog(@"view的model=%@",model);
        weakSelf.headView.nickNameLabel.text = model.userName;
        weakSelf.headView.IDLabel.text = [NSString stringWithFormat:@"ID:%@",model.ID];
    }];
    
    
}

-(void)setupViews {
    [self addSubview:self.tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{

    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark -segment点击
-(void)segmentClick:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    int xVlaue = (short)index;
    if (xVlaue == 0) {
        isFirstSegClick = YES;
        [_tableView beginUpdates];
        [_tableView endUpdates];
    }else {
        isFirstSegClick = NO;
        [_tableView beginUpdates];
        [_tableView endUpdates];
        
    }
    NSString * str = [NSString stringWithFormat:@"%d",xVlaue];
    NSDictionary * dic = @{@"value":str};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"personalBottomCellNotification" object:dic];
}
#pragma mark - tableView代理
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        UIImageView * bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        bgImgView.image = [UIImage imageNamed:@"navigation_image"];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, 6, 150, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.text = @"我的交易";
        [bgImgView addSubview:label];
        UIView * gView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        [gView addSubview:bgImgView];
        return gView;
    }else if (section == 1){
        UIView * gView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        NSArray * arr = [[NSArray alloc]initWithObjects:@"交易记录",@"历史收益率",@"盈亏品种",@"盈亏手数", nil];
        _segment = [[UISegmentedControl alloc]initWithItems:arr];
        _segment.selectedSegmentIndex = 0;
        [_segment setWidth:(SCREEN_WIDTH-30)/4 forSegmentAtIndex:0];
        [_segment setWidth:(SCREEN_WIDTH-30)/4 forSegmentAtIndex:1];
        [_segment setWidth:(SCREEN_WIDTH-30)/4 forSegmentAtIndex:2];
        [_segment setWidth:(SCREEN_WIDTH-30)/4 forSegmentAtIndex:3];
        _segment.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 30);
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
       
        // 设置UISegmentedControl选中的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"segment_select"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        // 正常的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"segment_unselect"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]} forState:UIControlStateNormal];
        [_segment setDividerImage:[UIImage imageNamed:@"white_bar"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [gView addSubview:_segment];
        return gView;
    }else return nil;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ) {
        
        PersonalFirstCell * cell1 = [tableView dequeueReusableCellWithIdentifier:kPersonalFirstCell];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    }else {
        PersonalSecondCell * cell2 = [tableView dequeueReusableCellWithIdentifier:kPersonalSecondCell];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }

        
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   
    if (section == 0) {
        return 2;
    }else return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 90;
    }else{
        return 210;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:kPersonalFirstCell bundle:nil] forCellReuseIdentifier:kPersonalFirstCell];
        [_tableView registerNib:[UINib nibWithNibName:kPersonalSecondCell bundle:nil] forCellReuseIdentifier:kPersonalSecondCell];

        [_tableView setTableHeaderView:self.headView];
        [_tableView.tableHeaderView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
        isFirstSegClick = YES;
    }
    return _tableView;
}
-(PersonalHeadView *)headView{

    if (!_headView) {
        _headView = [[PersonalHeadView alloc]initWithViewModel:self.viewModel];
    }
    return _headView;
}

@end
