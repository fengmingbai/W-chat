//
//  FFSendMessageView.h
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFSendMessageViewDelegate <NSObject>

- (void)sendMessage:(NSString *)textMessage;

@end

@interface FFSendMessageView : UIView

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *sendButton;
@property (nonatomic, weak)id<FFSendMessageViewDelegate> delegate;
@end
