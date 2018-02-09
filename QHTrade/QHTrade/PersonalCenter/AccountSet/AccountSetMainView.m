//
//  AccountSetMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AccountSetMainView.h"
#import "AccountSetViewModel.h"
#import "SettingHeadImgCell.h"
#import "SettingDefaultCell.h"

@interface AccountSetMainView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)AccountSetViewModel *viewModel;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UIView * footView;
@end

@implementation AccountSetMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (AccountSetViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraints];
}
-(void)updateConstraints{

    WS(weakSelf)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}
-(UIImage *)headImage{
    if (!_headImage) {
        _headImage = [UIImage imageNamed:@"touxiang_icon"];
    }
    return _headImage;
}

-(void)logoutBtnClick:(id)sender{

    [self.viewModel.logoutCommand execute:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)section] forKey:@"section"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)row] forKey:@"row"];
    
    [self.viewModel.cellClick sendNext:dic];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingHeadImgCell * headCell = [tableView dequeueReusableCellWithIdentifier:kSettingHeadImgCell];

    SettingDefaultCell * defaultCell = [tableView dequeueReusableCellWithIdentifier:kSettingDefaultCell];

    
    
        switch (indexPath.row) {
            case 0:
            {
                [headCell.headImgView sd_setImageWithURL:self.dataArray[indexPath.row] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
//                headCell.headImgView.image = self.headImage;
                headCell.leftLabel.text = self.titleArray[indexPath.row];
                return headCell;
            }
                break;
            case 1:
            {
                defaultCell.rightLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
                defaultCell.leftLabel.text = self.titleArray[indexPath.row];
                return defaultCell;
            }
                break;
            case 2:
            {
                defaultCell.rightLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
                defaultCell.leftLabel.text = self.titleArray[indexPath.row];
                defaultCell.arrImg.hidden = YES;
                return defaultCell;
            }
                break;
            case 3:
            {
                if ([self.dataArray[indexPath.row] isEqualToString:@"1"]) {
                    defaultCell.rightLabel.text = @"男";
                }else defaultCell.rightLabel.text = @"女";
                defaultCell.leftLabel.text = self.titleArray[indexPath.row];
                return defaultCell;
            }
                break;

                
            default:
                break;
        }
    
    return defaultCell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    switch (section) {
//        case 0:
//        {
//            return 5;
//        }
//            break;
//        case 1:
//        {
//            return 0;
//        }
//            break;
//            
//        default:
//            break;
//    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0;
    }else return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }else return 50;
}
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"login_minilogo",@"",@"",@""];
    }
    return _dataArray;
}
-(NSArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"头像",@"用户名",@"奇获ID",@"性别",@"生日",@"公司",@"职位",@"常住地", nil];
    }
    return _titleArray;
}

-(UIView *)footView{
    
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        
        UIButton * logout = [UIButton buttonWithType:UIButtonTypeCustom];
        logout.frame = CGRectMake(0, 5, SCREEN_WIDTH, 40);
        [logout setTitle:@"退出当前账户" forState:UIControlStateNormal];
        [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        logout.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//        [logout setBackgroundImage:[UIImage imageNamed:@"btn_ablebg_image"] forState:UIControlStateNormal];
        [logout setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logout addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:logout];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:kSettingHeadImgCell bundle:nil] forCellReuseIdentifier:kSettingHeadImgCell];
        [_tableView registerNib:[UINib nibWithNibName:kSettingDefaultCell bundle:nil] forCellReuseIdentifier:kSettingDefaultCell];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView setTableFooterView:self.footView];
        
        _tableView.tableFooterView = self.footView;
        
    }
    return _tableView;
}
@end
