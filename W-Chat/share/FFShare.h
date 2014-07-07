//
//  FFShare.h
//  W-Chat
//
//  Created by 冯明白 on 14-7-3.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define DEBUG_MODE (1)
#define TEST_MODE  (1)
#define kVersionCode @"14"

#define XMPPDomain @"192.168.1.23"
#define XMPPDomainBy(_str_) ([_str_ stringByAppendingFormat:@"@%@",@"192.168.1.23"])
#pragma mark ------USERINFO-----
#define USER_NAME @"user_name"
#define USER_PASSWORD @"user_password"
#define USER_AUTOLOGIN @"user_autologin"

#define APP_DELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)

#pragma mark ----------MessageType--------
#define kMessage_chat @"kMessage_chat"


#define MSG_10001_NETWORK_ERROR (@"网络无法连接")
#define MSG_1001_NETWORK_ERROR (@"当前网络不给力，请稍后重试")

#pragma mark ------Service errors-------

#pragma mark - Application errors
#define MSG_30001_USER_PASSWD_ERROR (@"用户名和密码验证失败")
#define MSG_30002_IDENTIFY_CODE_ERROR @"用户验证码输入错误"
#define MSG_30003_USER_NAME_DUPLICATE @"用户名已经存在，请使用其它用户名注册"
#define MSG_30003_PHONE_NUME_DUPLICATE @"手机号已经被注册过了"
#define MSG_30003_USER_NOT_ACCEPTABLE @"字段填写不完整"
#define MSG_30004_GET_VERIFYCODE_MORE_THAN_3_TIMES @"一天最多可获取3次"
#define MSG_30004_GET_VERIFYCODE_ERROR @"短信验证码发送失败，请重试"
#define MSG_30005_USER_NOT_EXISTS @"用户不存在"
#define MSG_401_USER_LOGIN_OTHER_PLACE @"该账号已在使用其他设备登录"


#if TEST_MODE
#define HTTP_BASE_URL   @"http://211.151.0.150/"
#define HTTP_HOST       @"211.151.0.150"
#else
#define HTTP_BASE_URL   @"http://api.hollo.cn/"
#define HTTP_HOST       @"api.hollo.cn"
#endif

#if DEBUG_MODE
#define NSLogInfo(s, ...) NSLog(@"Info: <%@:(%d)> %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define NSLogDebug(s, ...) NSLog(@"Debug: <%@:(%d)> %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define NSLogWarn(s, ...) NSLog(@"Warn: <%@:(%d)> %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define NSLogError(s, ...) NSLog(@"Error: <%@:(%d)> %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define NSLogInfo(s, ...)
#define NSLogDebug(s, ...)
#define NSLogWarn(s, ...)
#define NSLogError(s, ...)
#endif