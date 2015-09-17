//
//  ZixunCommentView.m
//  ASK
//
//  Created by zhuanghaishao on 15/4/21.
//  Copyright (c) 2015年 yiyaowang. All rights reserved.
//

#import "ZixunCommentView.h"

@interface ZixunCommentView ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *inputSendButton;
@property (weak, nonatomic) IBOutlet UIView *accessorView;

@end

@implementation ZixunCommentView

- (void)awakeFromNib
{
    CGColorRef borderColor = [UIColor lightGrayColor].CGColor;
    CGFloat borderWidth = 0.5;
    CGFloat cornerRadius = 3;
    
    _textField.layer.borderColor = borderColor;
    _textField.layer.borderWidth = borderWidth;
    _textField.layer.cornerRadius = cornerRadius;
    _sendButton.layer.borderColor = borderColor;
    _sendButton.layer.borderWidth = borderWidth;
    _sendButton.layer.cornerRadius = cornerRadius;
    _textView.layer.borderColor = borderColor;
    _textView.layer.borderWidth = borderWidth;
    _textView.layer.cornerRadius = cornerRadius;
    _inputSendButton.layer.borderColor = borderColor;
    _inputSendButton.layer.borderWidth = borderWidth;
    _inputSendButton.layer.cornerRadius = cornerRadius;
    
    _textField.placeholder = @"我来说两句";
    _textField.font = [UIFont systemFontOfSize:17];
    _textField.inputAccessoryView = _accessorView;
    _textField.delegate = self;
    _textView.delegate = self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [self resign];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyBoardDidShow
{
    [_textView becomeFirstResponder];
}

- (void)keyboardWillHide
{
    [self resign];
}

- (IBAction)send:(id)sender {
    [self resign];
    if (_sendAction) {
        _sendAction(_textView.text);
    }
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    _sendButton.enabled = enable;
    _inputSendButton.enabled = enable;
}

- (void)reset
{
    self.enable = YES;
    _textField.text = nil;
    _textView.text = nil;
}

- (void)resign
{
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }

    if ([_textField isFirstResponder]) {
        [_textField resignFirstResponder];
    }
}

#pragma mark - textfield

- (void)setSendAction:(SendAction)sendAction
{
    _sendAction = sendAction;
}

#pragma mark - textview
- (void)textViewDidChange:(UITextView *)textView
{
    _textField.text = _textView.text;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self resign];
    return YES;
}
@end
