//
//  FFSendMessageView.m
//  W-Chat
//
//  Created by 冯明白 on 14-7-4.
//  Copyright (c) 2014年 HL. All rights reserved.
//

#import "FFSendMessageView.h"

@implementation FFSendMessageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 2, 240, 40)];
    _textField.placeholder = @"请输入文字";
    _textField.layer.cornerRadius = 8.0f;
    _textField.layer.masksToBounds = YES;
    [self addSubview:_textField];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.layer.cornerRadius = 8.0f;
    _sendButton.layer.masksToBounds = YES;
    [_sendButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    self.frame = CGRectMake(CGRectGetMaxX(_textField.frame)+5, 2, 60, 40);
    [self addSubview:_sendButton];
}

- (void)sendMessage
{
    if (!_textField.text || _textField.text.length==0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
        [self.delegate sendMessage:_textField.text];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
