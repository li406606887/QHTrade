//
//  ChangeNickNameViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/29.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "ChangeNickNameViewController.h"


@interface ChangeNickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextfield;

@end

@implementation ChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更换用户名";
    self.nickNameTextfield.placeholder = [NSString stringWithFormat:@"请输入昵称"];
    
    self.nickNameTextfield.text = [NSString stringWithFormat:@"%@",self.oldNickName];
    @weakify(self)
    [self.nickNameTextfield.rac_textSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        static NSInteger const maxLength = 6;
        if (x.length >6) {
            self.nickNameTextfield.text = [self.nickNameTextfield.text substringToIndex:maxLength];
        }

    }];
}
-(void)saveBtnClick:(id)sender {
    if (self.nickNameTextfield.text.length ==0) {
        showMassage(@"请输入昵称");
        return;
    }
    loading(@"请稍后")
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setObject:self.nickNameTextfield.text forKey:@"userName"];
        QHRequestModel * model = [QHRequest postDataWithApi:@"/users/info" withParam:param error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                if ([model.status intValue] == 200) {
                    NSLog(@"fix头像返回%@",model.content);
                    self.model =[UserModel mj_objectWithKeyValues:model.content];
                    self.backblock(self.model);
                    [self.navigationController popViewControllerAnimated:YES];
                }
                showMassage(model.message)
            }else{
                [MBProgressHUD showError:@"网络正在开小差"];
            }
        });
    });

}
-(UIBarButtonItem *)rightButton{

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 23)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setBackgroundColor:RGB(255,98,1)];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    
    [btn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (IBAction)commitBtnClick:(id)sender {
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
