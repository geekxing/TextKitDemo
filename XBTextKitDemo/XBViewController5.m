
//
//  XBViewController5.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/19.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBViewController5.h"
#import "XBCircularTextContainer.h"

@interface XBViewController5 ()

@property (nonatomic, strong) UITextView *circularTextView;

@end

@implementation XBViewController5

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.circularTextView];

}

#pragma mark - TextKit

- (UITextView *)circularTextView {
    if (!_circularTextView) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;

        NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self p_backingStoreString]];

        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];

        NSTextContainer *textContainer = [[XBCircularTextContainer alloc] initWithSize:screenBounds.size];
        textContainer.widthTracksTextView = YES;
        [textContainer setExclusionPaths:
         @[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 60, 30, 30)],
           [UIBezierPath bezierPathWithOvalInRect:CGRectMake(190, 60, 30, 30)],
           [UIBezierPath bezierPathWithRect:CGRectMake(65, 180, 150, 30)]]];

        [layoutManager addTextContainer:textContainer];
        [textStorage addLayoutManager:layoutManager];

        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(screenBounds) - 20, 400) textContainer:textContainer];
        textView.editable = NO;
        textView.allowsEditingTextAttributes = NO;
        textView.scrollEnabled = NO;

        _circularTextView = textView;
    }
    return _circularTextView;
}

#pragma mark - Text Source

static NSString * const XBTextKitDemoText = @"在iOS7中，苹果引入了Text Kit——Text Kit是一个快速而又现代化的文字排版和渲染引擎。Text Kit在UIKit framework中的定义了一些类和相关协议，它最主要的作用就是为程序提供文字排版和渲染的功能。在程序中，通过Text Kit可以对文字进行存储(store)、布局(lay out)，以及用最精细的排版方式(例如文字间距、换行和对齐等)来显示文本内容。苹果引入Text Kit的目的并非要取代已有的Core Text，Core Text的主要作用也是用于文字的排版和渲染中，它是一种先进而又处于底层技术，如果我们需要将文本内容直接渲染到图形上下文(Graphics context)时，从性能和易用性来考虑，最佳方案就是使用Core Text。而如果我们直接利用苹果提供的一些控件(例如UITextView、UILabel和UITextField等)对文字进行排版，无疑就是借助于UIkit framework中Text Kit提供的API。距、换行和对齐等)来显示文本内容。苹果引入Text Kit的目的并非要取代已有的Core Text，Core Text的主要作用也是用于文字的排版和渲染中，它是一种先进而又处于底层技术，如果我们需要将文本内容直接渲染到图形上下文(Graphics context)时，从性能和易用性来考虑，最佳方案就是使用Core Text。而如果我们直接利用苹果提供的一些控件(例如UITextView、UILabel和UITextField等)对文字进行排版，无疑就是借助于UIkit framework中Text Kit提供的API。";

- (NSAttributedString *)p_backingStoreString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:XBTextKitDemoText];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attributes[NSForegroundColorAttributeName] = [UIColor redColor];
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByCharWrapping;
    attributes[NSParagraphStyleAttributeName] = paragraph;
    [attributedString setAttributes:attributes range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

@end
