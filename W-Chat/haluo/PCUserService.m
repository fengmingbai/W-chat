//
//  PCUserService.m
//  PinChe
//
//  Created by 郭亚伦 on 10/27/13.
//  Copyright (c) 2013 Jidong Liu. All rights reserved.
//
#import "PCUserService.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "PCHTTPClient.h"

@implementation PCUserService


+ (void)loginWithUserName:(NSString *)userName passwd:(NSString *)passwd isAutoLogin:(BOOL)isAutoLogin completion:(completion) completion
{
    // 简写@{@"username": userName,@"password":passwd} 但是userName或passwd一旦为nil 将会crash
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:2];
    [parameters setObject:userName forKey:@"username"];
    [parameters setObject:passwd   forKey:@"password"];
	[parameters setObject:[NSNumber numberWithBool:isAutoLogin] forKey:@"remember"];

	[[PCHTTPClient sharedClient] postPath:@"/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLogInfo(@"responseObject is %@",responseObject);
        completion(YES,responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLogError(@"error is %@",error);
        if (operation.response.statusCode == 403) {
            completion(NO,MSG_30001_USER_PASSWD_ERROR,error);
        }else if(error.code==NSURLErrorTimedOut){
			completion(NO,MSG_1001_NETWORK_ERROR,error);
		} else {
            completion(NO,MSG_10001_NETWORK_ERROR,error);
        }
    }];
}

+ (void)registerWithUserName:(NSString *)userName verifyCode:(NSString *)verifyCode nickName:(NSString *)nickName passwd:(NSString *)passwd completion:(completion) completion
{
    // 如果简写为@{@"username": userName,@"password":passwd} 当userName或passwd一旦为nil 将会crash
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    [parameters setObject:userName forKey:@"registerName"];
    [parameters setObject:verifyCode   forKey:@"identifyingCode"];
    [parameters setObject:passwd forKey:@"registerPassword"];
    [parameters setObject:nickName forKey:@"nickname"];

    [[PCHTTPClient sharedClient] postPath:@"/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLogInfo(@"responseObject is %@",responseObject);
        completion(YES,responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLogError(@"error is %@",error);
        switch (operation.response.statusCode) {
            case 400:
                completion(NO,MSG_30002_IDENTIFY_CODE_ERROR,error);
                break;
            case 409:
                completion(NO,MSG_30003_USER_NAME_DUPLICATE,error);
                break;
            case 406:
                completion(NO,MSG_30003_USER_NOT_ACCEPTABLE,error);
                break;
            default:
                NSLog(@"%@",error);
                completion(NO,MSG_10001_NETWORK_ERROR,error);
                break;
        }
		if(error.code==NSURLErrorTimedOut){
			completion(NO,MSG_1001_NETWORK_ERROR,error);
		}
    }];

}
+ (void)requestRegularCodeByRegister:(NSString *)userName completion:(completion) completion
{
	NSString * path = [NSString stringWithFormat:@"/verify_code/%@/sign_up",userName];
    
	[[PCHTTPClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLogInfo(@"responseObject is %@",responseObject);
		completion(YES,responseObject,nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLogError(@"error is %@",error);
		switch (operation.response.statusCode) {
			case 418:
				completion(NO,MSG_30004_GET_VERIFYCODE_MORE_THAN_3_TIMES,error);
				break;
			case 419:
				completion(NO,MSG_30004_GET_VERIFYCODE_ERROR,error);
				break;
			case 409:
				completion(NO,MSG_30003_PHONE_NUME_DUPLICATE,error);
				break;
			default:
				completion(NO,MSG_10001_NETWORK_ERROR,error);
				break;
		}
		if(error.code==NSURLErrorTimedOut){
			completion(NO,MSG_1001_NETWORK_ERROR,error);
		}
	}
     ];
}



@end
