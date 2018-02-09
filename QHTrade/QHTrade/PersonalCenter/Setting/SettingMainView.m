//
//  SettingMainView.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/26.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SettingMainView.h"
#import "SettingViewModel.h"
#import "SettingHeadImgCell.h"
#import "SettingPhoneCell.h"
#import "SettingDefaultCell.h"
#import "SettingSwitchCell.h"
#import "PromptView.h"

@interface SettingMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)SettingViewModel * viewModel;
@end

@implementation SettingMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (SettingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews{
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"login_minilogo",@"无",@"无"];
    }
    return _dataArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)section] forKey:@"section"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)row] forKey:@"row"];
    [self.viewModel.cellClick sendNext:dic];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingHeadImgCell * headCell = [tableView dequeueReusableCellWithIdentifier:kSettingHeadImgCell];
    SettingPhoneCell * phoneCell = [tableView dequeueReusableCellWithIdentifier:kSettingPhoneCell];
    SettingDefaultCell * defaultCell = [tableView dequeueReusableCellWithIdentifier:kSettingDefaultCell];
    SettingSwitchCell * switchCell = [tableView dequeueReusableCellWithIdentifier:kSettingSwitchCell];
//    WS(weakSelf)
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                [headCell.headImgView sd_setImageWithURL:self.dataArray[indexPath.row] placeholderImage:[UIImage imageNamed:@"touxiang_icon"]];
                return headCell;
            }
                break;
            case 1: {
                //无更换按钮
                defaultCell.leftLabel.text = @"手机号";
                defaultCell.rightLabel.text = self.dataArray[indexPath.row];
                defaultCell.arrImg.hidden = YES;
                //更换手机号
////                [phoneCell addPhoneNumStr:@"15160718888"];//中间四位****
//                phoneCell.phoneNumLabel.text = self.dataArray[indexPath.row];
//                phoneCell.arrowImg.hidden = YES;
//                phoneCell.changeBtn.hidden = YES;//隐藏
//                phoneCell.changeBlock = ^(){
//                    NSLog(@"更换");
//                    [weakSelf.viewModel.changePhoneClick sendNext:nil];
//                };
//                phoneCell.leftLabel.text = @"手机号";
//                 [phoneCell.changeBtn setTitle:@"更换" forState:UIControlStateNormal];
                return defaultCell;
            }
                break;
            case 2: {
                __weak typeof(phoneCell) weakCell = phoneCell;
                if (self.isHaveAccount) {
                    phoneCell.leftLabel.text = @"交易账户";
                    phoneCell.phoneNumLabel.text = self.dataArray[indexPath.row];
                    [phoneCell.changeBtn setTitle:@"删除" forState:UIControlStateNormal];
                    phoneCell.arrowImg.hidden = YES;
                }else {
                    phoneCell.arrowImg.hidden = NO;
                    phoneCell.phoneNumLabel.text = @"未绑定";
                    phoneCell.leftLabel.text = @"绑定交易账户";
                    phoneCell.changeBtn.hidden = YES;
                }
                phoneCell.changeBlock = ^() {
                    //循环引用
                    __strong typeof(phoneCell) strongCell = weakCell;
                    if ([strongCell.changeBtn.titleLabel.text isEqualToString:@"删除"]) {
                        NSLog(@"删除->弹框");
                        PromptView * Pview = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"删除交易账户后，您的持仓需自行处理，且此交易账户的跟单将视为您主动取消，由此造成的损失需由您本人承担。确定要解除吗？" LeftBtnTitle:@"不解除" RightBtnTitle:@"解除"];
                        [Pview show];
                        Pview.closeBlock = ^(){//不解除
                            
                        };
                        Pview.goonBlock = ^(){//解除
                            [self.viewModel.unbindCommand execute:nil];
//                            self.isHaveAccount = NO;
//                            strongCell.arrowImg.hidden = NO;
//                            strongCell.phoneNumLabel.text = @"未绑定";
//                            strongCell.leftLabel.text = @"绑定交易账户";
//                            strongCell.changeBtn.hidden = YES;
                            
                        };
                        
                    }
                
                };
                
                return phoneCell;
            }
                break;
            case 3: {
                __weak typeof(switchCell) weakCell = switchCell;
                if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) {
                    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
                    if (UIUserNotificationTypeNone == setting.types) {
                        NSLog(@"推送关闭");
                        [switchCell.rightSwitch setOn:NO];
                    }else{
                        NSLog(@"推送打开");
                        [switchCell.rightSwitch setOn:YES];
                    }
                }
                switchCell.leftLabel.text = @"接收通知";
                switchCell.switchBlock = ^(NSString * str){
                    NSLog(@"…%@",str);
                    if ([str isEqualToString:@"isOff"]) {//switch关闭时弹出
                        
                        PromptView * Pview = [[PromptView alloc]initWithTitle:@"提示" SubTitle:@"接收通知建议开启，关闭通知消息将会错过重要的跟单信息。你确定不接收通知吗？" LeftBtnTitle:@"不接收通知" RightBtnTitle:@"接收通知"];
                        [Pview show];
                        
                        Pview.closeBlock = ^(){
                            //坚持不接受通知
                            NSLog(@"不接受");
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        };
                        
                        Pview.goonBlock = ^(){
                            //弹出框上选择 接收通知
                            NSLog(@"接受通知");
                            __strong typeof(switchCell) strongCell = weakCell;
                            [strongCell.rightSwitch setOn:YES];
                            
                        };
                    }else {//switch打开
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        NSLog(@"接收通知");
                    }
                };
                return switchCell;
            }
                break;
           
                    
            default:
                break;
        }
    }else {
        if (indexPath.row == 0) {
            defaultCell.leftLabel.text = @"分享给朋友";
            defaultCell.rightLabel.text = @"";
            return defaultCell;
        }else {
            defaultCell.leftLabel.text = @"关于我们";
            defaultCell.rightLabel.text = @"";
            return defaultCell;
        }
        
      
    }
    return defaultCell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
        {
            return 4;
        }
            break;
        case 1:
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }else return 50;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:kSettingHeadImgCell bundle:nil] forCellReuseIdentifier:kSettingHeadImgCell];
        [_tableView registerNib:[UINib nibWithNibName:kSettingPhoneCell bundle:nil] forCellReuseIdentifier:kSettingPhoneCell];
        [_tableView registerNib:[UINib nibWithNibName:kSettingDefaultCell bundle:nil] forCellReuseIdentifier:kSettingDefaultCell];
        [_tableView registerNib:[UINib nibWithNibName:kSettingSwitchCell bundle:nil]    forCellReuseIdentifier:kSettingSwitchCell];
    }
    return _tableView;
}

@end
