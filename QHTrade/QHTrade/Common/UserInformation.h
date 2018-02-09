//
//  UserInformation.h
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserInformation : NSObject
@property(nonatomic,strong) UserModel *userModel;
@property(nonatomic,assign) CGFloat noSafeBarHeight;
+(UserInformation*)getInformation;
//转bsae64方法
+ (NSString *)transBase64WithImage:(UIImage *)image;

-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber;
-(NSMutableDictionary *)getUserInformationData;
-(void)cleanUserInfo;
/**
 获取七牛token
 */
+(void)requestQiniuToken;
/**
 存七牛token
 */
-(void)setQiniuToken:(NSString *)qiniuToken andLink:(NSString*)link;
/**
 取七牛token
 */
-(NSMutableDictionary *)getQiniuTokenData;
/**
 登录状态
 */
-(BOOL)getLoginState;
/**
 图片上传随机key
 */
- (NSString *)arc4randomForKey;
/**
 格式化时间
 */
+(NSString *)formatTimeStampString:(NSString *)timeStampString;
/**
 检查手机号码格式
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
