//
//  SettingViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/8.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingMainView.h"
#import "SettingViewModel.h"
#import "AboutUSViewController.h"
#import "ChangePhoneViewController.h"
#import "AccountSetViewController.h"
#import "TradeAccountViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ShareCustomView.h"

@interface SettingViewController ()
@property (nonatomic,strong)SettingMainView * mainView;
@property (nonatomic,strong)SettingViewModel * viewModel;
@property (nonatomic,assign)int shareType;
@end

@implementation SettingViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.userInfoCommand execute:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    self.title = @"设置";
    [self loadData];
}
-(void)loadData {
    //更新
    NSString * url = [NSString stringWithFormat:@"%@%@",imageLink,self.model.userImg];
    NSArray * data  = @[url,[NSString stringWithFormat:@"%@",self.model.mobile],[NSString stringWithFormat:@"%@",self.model.ctpAccount]];
    self.mainView.dataArray = data;
    self.mainView.isHaveAccount = (self.model.ctpAccount.length >= 6);
    [self.mainView.tableView reloadData];
}
-(void)updateViewConstraints {
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

-(void)bindViewModel{
    WS(weakSelf)
    //解除绑定
    [[[self.viewModel.unbindCommand executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"解除绑定=->%@",x);
        if ([x isEqualToString:@"成功"]) {
            self.mainView.isHaveAccount = NO;
            [self.mainView.tableView reloadData];
        }
    }];
    
    //刷新
    [[self.viewModel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(UserModel  *model) {
        NSLog(@"user=%@",model);
        //更新UI
        weakSelf.model = model;
        [weakSelf loadData];
    }];
   
    //更换手机号
    [[self.viewModel.changePhoneClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        ChangePhoneViewController * CVC = [[ChangePhoneViewController alloc]init];
        [weakSelf.navigationController pushViewController:CVC animated:YES];
        }];
    
    //tableViewCell 点击
    [[self.viewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSMutableDictionary * x) {
       
        NSString * section = [x objectForKey:@"section"];
        NSString * row = [x objectForKey:@"row"];
        
        if ([section intValue] == 0) {
            NSLog(@"0-%@",row);
            
            switch ([row intValue]) {
                case 0://个人资料
                {
                    AccountSetViewController * AVC = [[AccountSetViewController alloc]init];
                    AVC.model = self.model;
                    [self.navigationController pushViewController:AVC animated:YES];
                }
                    break;
                case 1://手机号
                {
                }
                    break;
                case 2://交易账户
                {
                    if (!self.mainView.isHaveAccount) {
                        NSLog(@"去绑定账户");
                        TradeAccountViewController  * TVC = [[TradeAccountViewController alloc]init];
                        [self.navigationController pushViewController:TVC animated:YES];
                    }
                }
                    break;
                case 3://接收通知
                {
                    
                }
                    break;
                
                default:
                    break;
            }
            
        }else{
            if ([row intValue] == 1) {
                AboutUSViewController * AVC = [[AboutUSViewController alloc]init];
                [self.navigationController pushViewController:AVC animated:YES];
            }else {
                NSLog(@"分享");
                ShareCustomView * shareView = [[ShareCustomView alloc]initWithTitle:@"分享到：" BtnImgArray:@[@"share_wechat",@"share_wechatFirend",@"share_QQ"]];
                [shareView show];
                __weak typeof (self) weakSelf = self;
                shareView.itemBlock = ^(NSInteger tag) {
                    switch (tag) {
                        case 0:
                            weakSelf.shareType = SSDKPlatformSubTypeWechatSession;
                            break;
                        case 1:
                            weakSelf.shareType = SSDKPlatformSubTypeWechatTimeline;
                            break;
                        case 2:
                            weakSelf.shareType = SSDKPlatformSubTypeQQFriend;
                            break;
                            
                        default:
                            break;
                    }
                    [weakSelf goShare];
                };
                shareView.closeBlock = ^{
                    
                };
            }//
        }
    }];

}
#pragma mark ----share
- (void)goShare {
    //1、创建分享参数 图片
    NSArray* imageArray = @[[UIImage imageNamed:@"AppIcon"]];

    if (imageArray) {

        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

        [shareParams SSDKSetupShareParamsByText:@"告别麻烦与复杂，收获盈利的乐趣"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.xiamenqihuo.com/"]
                                          title:@"“奇获跟单版” 发现交易的乐趣"
                                           type:SSDKContentTypeAuto];

        [ShareSDK share:self.shareType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
        
    }
}
-(SettingViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[SettingViewModel alloc]init];
    }
    return _viewModel;
}
-(SettingMainView *)mainView{
    if (!_mainView) {
        _mainView = [[SettingMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
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
