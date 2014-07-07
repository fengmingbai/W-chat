//
//  FFFactory.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-3.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFFactory.h"

@implementation FFFactory
+ (void)showAlertViewWithMessage:(NSString*)message
{
    UIAlertView *a =[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [a show];
}


@end
