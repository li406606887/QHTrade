//
//  QHRequest.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//


#import "QHRequest.h"


@implementation QHRequest
static AFHTTPSessionManager *operationManager ;

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(QHRequest * request, id response))success
    failure:(void (^)(QHRequest * request, NSError *error))failure {
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *userId = [ [NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version_no = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    if ([self isValidateString:userId]==YES&&[self isValidateString:token]==YES) {
        [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",userId,token]  forHTTPHeaderField:@"userId_token"];
    }
    [self.operationManager.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    [self.operationManager.requestSerializer setValue:@"2" forHTTPHeaderField:@"platform"];
    [self.operationManager.requestSerializer setValue:version_no forHTTPHeaderField:@"version_no"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"version"];


    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager GET:URLString
                    parameters:parameters
                      progress:^(NSProgress * _Nonnull downloadProgress) {
                          
                      }
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           success(self,object);
                       
                           dispatch_semaphore_signal(semaphore);
                           
                       }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                       

                           dispatch_semaphore_signal(semaphore);
                       }
     ];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(QHRequest *request, id response))success
     failure:(void (^)(QHRequest *request, NSError *error))failure{
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *userId = [ [NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version_no = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    if ([self isValidateString:userId]==YES&&[self isValidateString:token]==YES) {
        [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",userId,token]  forHTTPHeaderField:@"userId_token"];
    }
    [self.operationManager.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    [self.operationManager.requestSerializer setValue:@"2" forHTTPHeaderField:@"platform"];
    [self.operationManager.requestSerializer setValue:version_no forHTTPHeaderField:@"version_no"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"version"];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager POST:URLString
                     parameters:parameters
                       progress:^(NSProgress * _Nonnull uploadProgress) {
                           
                       }
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            id object;
                            if ([responseObject isKindOfClass:[NSData class]]) {
                                object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                            }else{
                                object =responseObject;
                            }
                            success(self,object);
                            if ([object[@"Code"] intValue]==405) {
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                            dispatch_semaphore_signal(semaphore);
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            failure(self,error);
                            dispatch_semaphore_signal(semaphore);
                        }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)DELETE:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(QHRequest *request, id response))success
     failure:(void (^)(QHRequest *request, NSError *error))failure {
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *userId = [ [NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version_no = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    if ([self isValidateString:userId]==YES&&[self isValidateString:token]==YES) {
        [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",userId,token]  forHTTPHeaderField:@"userId_token"];
    }
    
    [self.operationManager.requestSerializer setValue:uuid forHTTPHeaderField:@"uuid"];
    [self.operationManager.requestSerializer setValue:@"2" forHTTPHeaderField:@"platform"];
    [self.operationManager.requestSerializer setValue:version_no forHTTPHeaderField:@"version_no"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"version"];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self.operationManager DELETE:URLString
                       parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object;
                           if ([responseObject isKindOfClass:[NSData class]]) {
                               object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           }else{
                               object =responseObject;
                           }
                           
                           success(self,object);
                           if ([object[@"Code"] intValue]==405) {
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
                               [[NSUserDefaults standardUserDefaults] synchronize];
                           }
                       
                           dispatch_semaphore_signal(semaphore);

                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                       
                           dispatch_semaphore_signal(semaphore);

                       }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
}

- (BOOL)isValidateString:(NSString*)str
{
    if (str == nil)
    {
        return NO;
    }
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    
    if ([str isEqualToString:@""])
    {
        return NO;
    }
    
    if ([str length] == 0)
    {
        return NO;
    }
    
    return YES;
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(QHRequest *request, id  response) {
           if ([self.delegate respondsToSelector:@selector(QHRequest:finished:)]) {
               [self.delegate QHRequest:request finished:response];
               
           }
       }
       failure:^(QHRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(QHRequest:Error:)]) {
               [self.delegate QHRequest:request Error:error.description];
           }
       }];
}

- (void)getWithURL:(NSString *)URLString {
    
    [self GET:URLString parameters:nil success:^(QHRequest *request, id response) {
        if ([self.delegate respondsToSelector:@selector(QHRequest:finished:)]) {
            [self.delegate QHRequest:request finished:response];
        }
    } failure:^(QHRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(QHRequest:Error:)]) {
            [self.delegate QHRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

-(AFHTTPSessionManager *)operationManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationManager = [AFHTTPSessionManager manager];
        operationManager.requestSerializer.timeoutInterval = 15;
        
    });
    
    return operationManager;
}
@end
