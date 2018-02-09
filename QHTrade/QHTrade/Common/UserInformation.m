//
//  UserInformation.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation
+(UserInformation*)getInformation{
    static UserInformation *userInfor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfor = [[UserInformation alloc] init];
        
    });
    
    return userInfor;
}

-(BOOL)getLoginState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefaults objectForKey:@"userId"];
    NSString *token = [userDefaults objectForKey:@"token"];
    if (user_id.length<1||token.length<1) {
        return NO;
    }
    return YES;
}
-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userid forKey:@"userId"];
    [defaults setObject:token forKey:@"token"];
    [defaults setObject:phoneNumber forKey:@"phoneNumber"];
    [defaults synchronize];
}
-(NSMutableDictionary *)getUserInformationData {
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [infoDictionary setObject:[defaults objectForKey:@"userId"] forKey:@"userId"];
    [infoDictionary setObject:[defaults objectForKey:@"token"] forKey:@"token"];
    return infoDictionary;
}
-(void)setQiniuToken:(NSString *)qiniuToken andLink:(NSString*)link {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:qiniuToken forKey:@"qiniuToken"];
    [defaults setObject:link forKey:@"link"];
    [defaults synchronize];
}
-(NSMutableDictionary *)getQiniuTokenData {
    NSMutableDictionary *infoDictionary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [infoDictionary setObject:[NSString stringWithFormat:@"%@",[defaults objectForKey:@"qiniuToken"]] forKey:@"qiniuToken"];
    [infoDictionary setObject:[NSString stringWithFormat:@"%@",[defaults objectForKey:@"link"]] forKey:@"link"];
    return infoDictionary;
}
- (NSString *)arc4randomForKey {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
-(void)cleanUserInfo{
    
//    NSString * bundle = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:bundle];
//
    self.userModel = nil;
    NSString * str  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString * str1  = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString * str2  = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    
    if (str.length > 0 && str1.length >0 && str2.length > 0) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
}
//获取七牛token
+(void)requestQiniuToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel * model = [QHRequest getDataWithApi:@"/qiNiu/token" withParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                if ([model.status intValue] == 200) {
                    NSDictionary * dic = model.content;
                    [[UserInformation getInformation] setQiniuToken:dic[@"token"] andLink:dic[@"link"]];
                }
            }
        });
    });
}
//转bsae64方法
+ (NSString *)transBase64WithImage:(UIImage *)image{
    
    NSData* imgData = UIImageJPEGRepresentation(image, 0.1f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *string = [NSString stringWithFormat:@"data:image/png;base64,%@",encodedImageStr];
    
    return string;
}
//格式化时间
+(NSString *)formatTimeStampString:(NSString *)timeStampString {
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate:date];
}
//手机号正则表达式
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    if (mobileNum.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark ============ 获取非安全区域高度 ============
-(CGFloat )noSafeBarHeight {
    if (!_noSafeBarHeight) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (@available(iOS 11.0, *)) {
                CGFloat height = [UIApplication sharedApplication].keyWindow.safeAreaLayoutGuide.layoutFrame.size.height;
                if (SCREEN_HEIGHT>height) {
                    _noSafeBarHeight = 34;
                } else {
                    _noSafeBarHeight = 0;
                }
            } else {
                _noSafeBarHeight = 0;
            }
        });
    }
    return _noSafeBarHeight;
}
@end
