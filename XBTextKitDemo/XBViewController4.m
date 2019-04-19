
//
//  XBViewController4.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/19.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBViewController4.h"
@import CoreText;

static NSString * const XBTextKitDemoText = @"在iOS7中，苹果引入了Text Kit——Text Kit是一个快速而又现代化的文字排版和渲染引擎。Text Kit在UIKit framework中的定义了一些类和相关协议，它最主要的作用就是为程序提供文字排版和渲染的功能。在程序中，通过Text Kit可以对文字进行存储(store)、布局(lay out)，以及用最精细的排版方式(例如文字间距、换行和对齐等)来显示文本内容。苹果引入Text Kit的目的并非要取代已有的Core Text，Core Text的主要作用也是用于文字的排版和渲染中，它是一种先进而又处于底层技术，如果我们需要将文本内容直接渲染到图形上下文(Graphics context)时，从性能和易用性来考虑，最佳方案就是使用Core Text。而如果我们直接利用苹果提供的一些控件(例如UITextView、UILabel和UITextField等)对文字进行排版，无疑就是借助于UIkit framework中Text Kit提供的API。";

@interface XBDrawView : UIView

@end

@implementation XBDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // Initialize a string.
        const char * cStr = [XBTextKitDemoText UTF8String];
        CFStringRef string = CFStringCreateWithCString(kCFAllocatorDefault, cStr, kCFStringEncodingUTF8);

        // Create a mutable attributed string with a max length of 0.
        // The max length is a hint as to how much internal storage to reserve.
        // 0 means no hint.
        CFMutableAttributedStringRef attrString =
        CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);

        // Copy the textString into the newly created attrString
        CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), string);
        CFRelease(string);

        // Create a font.
        CTFontRef font = (__bridge CTFontRef)[UIFont systemFontOfSize:20];

        // Create a fontColor.
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        CGFloat components[] = { 1, 0, 0, 1 };
        CGColorRef color = CGColorCreate(rgbColorSpace, components);
        CGColorSpaceRelease(rgbColorSpace);

        // Create a text attributes
        CFStringRef keys[] = { kCTFontNameAttribute, kCTForegroundColorAttributeName};
        CFTypeRef values[] = { font, color };

        CFDictionaryRef attributes =
        CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys,
                           (const void**)&values, sizeof(keys) / sizeof(keys[0]),
                           &kCFTypeDictionaryKeyCallBacks,
                           &kCFTypeDictionaryValueCallBacks);

        CFAttributedStringSetAttributes(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), attributes, false);
        CFRelease(attributes);
        
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:XBTextKitDemoText];
//        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//        attributes[NSForegroundColorAttributeName] = [UIColor redColor];
//        [attributedString setAttributes:attributes range:NSMakeRange(0, attributedString.length)];
//        CFAttributedStringRef attrString = (__bridge_retained CFAttributedStringRef)attributedString;

        // get current bitmap context
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // fill backgroundColor
        [[UIColor whiteColor] set];
        UIRectFill(rect);
        
        // Flip the context coordinates
        CGContextTranslateCTM(context, 0, CGRectGetHeight(rect));
        CGContextScaleCTM(context, 1.0, -1.0);
        // Set the text matrix.
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectInset(rect, 0, 100));
        
//        [attributedString drawInRect: ]
        // ***************************   Core Text Draw Begin ************************//
        // Create the framesetter with the attributed string.
        CTFramesetterRef framesetter =
        CTFramesetterCreateWithAttributedString(attrString);
        CFRelease(attrString);
        
        // Create a frame.
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                    CFRangeMake(0, 0), path, NULL);
        
        // Draw the specified frame in the given context.
        CTFrameDraw(frame, context);
        // ***************************   Core Text Draw End   ************************//
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Release the objects we used.
        CFRelease(frame);
        CFRelease(path);
        CFRelease(framesetter);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // set image to layer in main thread
            self.layer.contents = (id)image.CGImage;
        });
    });

}

@end

@interface XBViewController4 ()

@end

@implementation XBViewController4

- (void)loadView {
    XBDrawView *view = [[XBDrawView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
