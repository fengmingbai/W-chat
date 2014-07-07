//
//  FFXPManager.h
//  W-Chat
//
//  Created by 冯明白 on 14-7-3.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"
@class FFMessageOBJ;

@protocol FFPresenceDelegate <NSObject>

- (void)newBodyOnLine:(NSString *)bodyName;
- (void)bodyWentOffLine:(NSString *)bodyName;
- (void)didDisconnect;
@end

typedef void(^completion)(BOOL success,id obj,NSError *error);
@interface FFXPManager : NSObject<XMPPStreamDelegate>

@property (nonatomic, weak)id<FFPresenceDelegate> presenceDelegate;
@property (nonatomic, strong)XMPPStream *xmppStream;

+ (FFXPManager*)defaultManager;

- (void)setupStream;                                  //设置xmppStream
- (void)goOffline;                                    //上线
- (void)goOnline;                                     //下线
- (BOOL)connectWithBlock:(completion)completion;        //是否连接
- (void)disConnect;                                     //断开连接
- (void)registerNewUserWithBlock:(completion)completion; //注册

@end
