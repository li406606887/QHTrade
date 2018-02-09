//
//  AccountSetViewController.m
//  QHTrade
//
//  Created by 吴桂钊 on 2017/6/27.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "AccountSetViewController.h"
#import "AccountSetViewModel.h"
#import "AccountSetMainView.h"
#import "ChooseSexView.h"
#import "ChangeNickNameViewController.h"

@interface AccountSetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)AccountSetMainView * mainView;
@property (nonatomic,strong)AccountSetViewModel * viewModel;
@property (nonatomic,strong)NSString * link;
@end

@implementation AccountSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    self.title = @"账户设置";
    
    [self loadData];
    
}
-(void)loadData {
    //更新
    NSString * url = [NSString stringWithFormat:@"%@%@",imageLink,self.model.userImg];
    NSArray * data  = @[url,[NSString stringWithFormat:@"%@",self.model.userName],[NSString stringWithFormat:@"%@",self.model.ID],[NSString stringWithFormat:@"%@",self.model.gender]];
    self.mainView.dataArray = data;
    [self.mainView.tableView reloadData];
}

#pragma mark - 上传七牛
-(void)uploadHeadImgViewWithImage:(UIImage *)image andQiniuToken:(NSString *)token {
    //上传7niu
    loading(@"正在上传")
    QNUploadManager *upManager = [[QNUploadManager alloc]init];
    NSData * jpgData = UIImageJPEGRepresentation(image, 0.3f);
    NSString * key = [[UserInformation getInformation] arc4randomForKey];
    
    [upManager putData:jpgData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        hiddenHUD;
        if (info.statusCode == 200) {
            showMassage(@"头像上传成功")
            [self fixUserInfoWithUserImgKey:key gender:@""];
        }else showMassage(@"头像上传失败")
    } option:nil];
   
}
#pragma mark - 上传后台
-(void)fixUserInfoWithUserImgKey:(NSString *)key gender:(NSString *)gender{
    loading(@"请稍后")
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        NSMutableDictionary * param = [NSMutableDictionary dictionary];
        [param setObject:key forKey:@"userImg"];
        [param setObject:gender forKey:@"gender"];
        QHRequestModel * model = [QHRequest postDataWithApi:@"/users/info" withParam:param error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error == nil) {
                if ([model.status intValue] == 200) {
                    NSLog(@"fix头像返回%@",model.content);
                    self.model =[UserModel mj_objectWithKeyValues:model.content];
                    [self loadData];//更新
                }
//                showMassage(model.message)
            }else{
                [MBProgressHUD showError:@"网络正在开小差"];
            }
        });
    });
}
-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
#pragma mark - 相机代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //  获取
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mainView.headImage  = image;
        [self.mainView.tableView reloadData];
    });
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    //更新

    NSDictionary * dic = [[UserInformation getInformation] getQiniuTokenData];
    self.link = dic[@"link"];
    [self uploadHeadImgViewWithImage:image andQiniuToken:dic[@"qiniuToken"]];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)bindViewModel {
    WS(weakSelf)
    
    [[self.viewModel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * x) {
        if ([x intValue] == 200) {//退出登录成功
            [self.navigationController popToRootViewControllerAnimated:NO];
           
        }
    }];
    
    [[self.viewModel.cellClick takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSMutableDictionary* x) {
        NSString * section = [x objectForKey:@"section"];
        NSString * row = [x objectForKey:@"row"];
        
        if ([section intValue] == 0) {
            NSLog(@"account 0-%@",row);
            
            switch ([row intValue]) {
                case 0:
                {//头像点击
                    [weakSelf chooseHeadImage];
                }
                    break;
                case 1:
                {//用户名
                    __weak typeof(self) weakSelf = self;
                    ChangeNickNameViewController * CVC = [[ChangeNickNameViewController alloc]init];
                    CVC.oldNickName = self.model.userName;
                    CVC.backblock = ^(UserModel *model) {
                        weakSelf.model = model;
                        [weakSelf loadData];
                    };
                    [weakSelf.navigationController pushViewController:CVC animated:YES];
                    
                }
                    break;
                case 2:
                {//期货ID
                    
                }
                    break;
                case 3:
                {//性别
                    ChooseSexView * sexView = [[ChooseSexView alloc]initWithDataArray:@[@"男",@"女"]];
                    NSArray * sex;
                    if ([self.model.gender isEqualToString:@"1"]) {
                        sex = @[@"1",@"0"];//男
                    }else sex = @[@"0",@"1"];
                    sexView.sexArray = sex;
                    [sexView show];
                    __weak typeof(self) weakSelf = self;
                    sexView.callBackBlock = ^(NSString * str){
                        NSLog(@"%@",str);
                        if ([str isEqualToString:@"男"]) {
                            [weakSelf fixUserInfoWithUserImgKey:@"" gender:@"1"];
                        }else [weakSelf fixUserInfoWithUserImgKey:@"" gender:@"2"];
                    };
                }
                    break;
                case 4:
                {//生日
                    
                }
                    break;
                    
                default:
                    break;
            }
        }else{
            NSLog(@"1-%@",row);
            
            switch ([row intValue]) {
                case 0:
                {//公司
                
                }
                    break;
                case 1:
                {//职位
                    
                }
                    break;
                case 2:
                {//常住地
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    }];

}
-(AccountSetViewModel *)viewModel{

    if (!_viewModel) {
        _viewModel = [[AccountSetViewModel alloc]init];
    }
    return _viewModel;
}
-(AccountSetMainView *)mainView{

    if (!_mainView) {
        _mainView = [[AccountSetMainView alloc]initWithViewModel:self.viewModel];
    }
    return _mainView;
}
#pragma mark - 选择头像
-(void)chooseHeadImage {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancle setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
   
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    [camera setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    UIAlertAction * picture = [UIAlertAction actionWithTitle:@"相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * pickerImage = [[UIImagePickerController alloc]init];
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [picture setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    [alert addAction:cancle];
    [alert addAction:picture];
    [alert addAction:camera];
    
    [self presentViewController:alert animated:YES completion:nil];
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
