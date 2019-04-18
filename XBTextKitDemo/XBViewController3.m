//
//  XBViewController3.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/19.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBViewController3.h"

@interface XBViewController3 ()

@end

@implementation XBViewController3

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     Text Storage : Layout Manager = 1 : N ，相同文本用多种布局展示，
     在某个 Text View 上做的编辑会马上反映到其他Text View 上。
     */
    NSTextStorage *sharedTextStorage = [NSTextStorage new];

    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [sharedTextStorage addLayoutManager: layoutManager];

    NSTextContainer *textContainer = [NSTextContainer new];
    [layoutManager addTextContainer: textContainer];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 100, 300, 200) textContainer:textContainer];
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.view addSubview:textView];

    /**
     Layout Manager : Text Container = 1 : N，
     这样可以将一个文本分布到多个视图展现出来
     */
    NSLayoutManager *layoutManager2 = [NSLayoutManager new];
    [sharedTextStorage addLayoutManager: layoutManager2];

    NSTextContainer *textContainer2 = [NSTextContainer new];
    [layoutManager2 addTextContainer: textContainer2];

    UITextView *textView2 = [[UITextView alloc] initWithFrame:CGRectMake(20, 350, 150, 200) textContainer:textContainer2];
    textView2.textAlignment = NSTextAlignmentCenter;
    textView2.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    textView2.scrollEnabled = NO;
    [self.view addSubview:textView2];

    NSTextContainer *textContainer3 = [NSTextContainer new];
    [layoutManager2 addTextContainer: textContainer3];

    UITextView *textView3 = [[UITextView alloc] initWithFrame:CGRectMake(180, 350, 150, 200) textContainer:textContainer3];
    textView3.textAlignment = NSTextAlignmentCenter;
    textView3.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    [self.view addSubview:textView3];

}


@end
