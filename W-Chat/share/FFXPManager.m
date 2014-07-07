//
//  FFXPManager.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-3.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFXPManager.h"
#import "PCNotificationCenter.h"
#import "FFMessageOBJ.h"

@implementation FFXPManager
{
    NSString *_password;
    BOOL isRegitering;
    completion xpCompletion;
}


+ (FFXPManager *)defaultManager
{
    static FFXPManager *f =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        f = [[FFXPManager alloc] init];
    });
    return f;
}

- (id)init
{
    if (self = [super init]) {
        [self setupStream];
    }
    return self;
}



#pragma mark ------xmpp-------

- (void)registerNewUserWithBlock:(completion)completion
{
    isRegitering = YES;
    [self connectWithBlock:completion];
}
- (void)setupStream
{
    _xmppStream = [[XMPPStream alloc] init];
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
}

- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

- (BOOL)connectWithBlock:(completion)completion
{
    [self setupStream];
    xpCompletion = completion;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:USER_NAME];
    _password = [userDefaults objectForKey:USER_PASSWORD];
    
    if (![_xmppStream isDisconnected]) return YES;
    if (!username || !_password)       return NO;

    [_xmppStream setMyJID:[XMPPJID jidWithString:XMPPDomainBy(username)]];
    [_xmppStream setHostName:XMPPDomain];
    NSError *error = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]){
        [FFFactory showAlertViewWithMessage:@"xmpp连接错误"];
        return NO;
    }
    return YES;
}

- (void)disConnect
{
    [self goOffline];
    [_xmppStream disconnect];
}

#pragma mark -------XMPPDelegate---------
//连接服务器失败
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLogInfo(@"连接服务器失败");
    xpCompletion(NO,@"连接服务器失败",nil);
}
//连接成功
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    NSLogInfo(@"已连接服务器");
}
//已经连接服务器
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSError *error = nil;
    if (isRegitering) {
        isRegitering = NO;
        if (![_xmppStream registerWithPassword:_password error:&error]) {
            [PCNotificationCenter showMessage:@"注册失败"];
        }
        
    }else
    {
        if (![_xmppStream authenticateWithPassword:_password error:&error]) {
            [PCNotificationCenter showMessage:@"登录失败"];
        }
    }
}
//验证结果
#pragma mark ------- 注册／登录验证结果-----------

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    [self goOnline];
    [PCNotificationCenter showMessage:@"登录成功"];
    xpCompletion(YES,@"登录成功",nil);
    
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    xpCompletion(NO,@"密码错误",nil);
    [PCNotificationCenter showMessage:@"密码错误"];
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    xpCompletion(YES,@"注册成功",nil);
//    [PCNotificationCenter showMessage:@"注册成功"];
}
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    xpCompletion(NO,@"注册失败",nil);
    [PCNotificationCenter showMessage:@"注册失败"];
}
//收到消息
- (void)xmppStream:(XMPPStream*)sender didReceiveMessage:(XMPPMessage *)message
{
    FFMessageOBJ *msgObj = [[FFMessageOBJ alloc] init];
    msgObj.messageBody = [[message elementForName:@"body"] stringValue];
    msgObj.fromP       = [message attributeForName:@"from"].stringValue;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMessage_chat object:msgObj];
}

//收到好友状态
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSString *preType = [presence type];
    
    NSString *userId = [[sender myJID] user];
    
    NSString *preuser = [[presence from] user];
    
    if (![preuser isEqualToString:userId]) {
        if ([preType isEqualToString:@"available"]) {
            if (self.presenceDelegate) {
                [self.presenceDelegate newBodyOnLine:preuser];
            }
            
        }else if([preType isEqualToString:@"unavailable"])
        {
            if (self.presenceDelegate) {
                [self.presenceDelegate bodyWentOffLine:preuser];
            }
        }
    }
}

//
@end
