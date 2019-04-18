//
//  XBViewController2.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/17.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBViewController2.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface XBViewController2 ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat keyboardH;
@end

@implementation XBViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextView *textView = [UITextView new];
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    textView.delegate = self;
    self.textView = textView;
    [self.view addSubview:self.textView];

    [self p_updateTextViewFrame];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardFrameChanged:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];

}

- (void)p_updateTextViewFrame {

    CGSize textSize = [_textView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 20, CGFLOAT_MAX)];
    if (textSize.width < 0.01) {
        textSize.width = 20;
    }
//    NSLog(@"%@", NSStringFromCGSize(textSize));
    CGFloat bottomMargin = self.keyboardH + 20;
    CGFloat textViewCenterY = CGRectGetHeight(self.view.bounds) * 0.5;
    textSize.height = self.keyboardH > 0 ? MIN(textSize.height, bottomMargin - 44) : textSize.height;
    CGFloat delta = (CGRectGetHeight(self.view.bounds) + textSize.height) * 0.5 - (SCREEN_HEIGHT - bottomMargin);
    if (delta > 0) {
        textViewCenterY -= delta;
    } else {
    }
    self.textView.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    self.textView.center = CGPointMake(CGRectGetWidth(self.view.bounds) * 0.5, textViewCenterY);
}

#pragma mark - Notification
- (void)onKeyboardFrameChanged:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardH = CGRectGetHeight(keyboardFrame);
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    CGRect caretRect = [textView caretRectForPosition:textView.selectedTextRange.end];
    NSLog(@"caret origin is %@", NSStringFromCGPoint(caretRect.origin));
    NSLog(@"scroll offset is %@", NSStringFromCGPoint(textView.contentOffset));
    [self p_updateTextViewFrame];
}

@end
