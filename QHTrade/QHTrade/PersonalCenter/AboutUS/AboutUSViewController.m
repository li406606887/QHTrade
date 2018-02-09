//
//  AboutUSViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AboutUSViewController.h"
#import "SettingDefaultCell.h"
#import "QHPDFViewViewController.h"

@interface AboutUSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;//版本
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self loadTableView];
}

-(void)loadTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:kSettingDefaultCell bundle:nil] forCellReuseIdentifier:kSettingDefaultCell];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        QHPDFViewViewController * PVC = [[QHPDFViewViewController alloc]init];
        [self.navigationController pushViewController:PVC animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingDefaultCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingDefaultCell];
    cell.rightLabel.text = @"";
    if (indexPath.row == 0) {
        cell.leftLabel.text = @"用户协议及免责声明";
    }else{
//        cell.leftLabel.text = @"免责声明";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
