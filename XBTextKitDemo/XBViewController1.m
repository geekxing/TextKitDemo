//
//  ViewController.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/17.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBViewController1.h"

@interface XBViewController1 ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation XBViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.imageView addGestureRecognizer:panGes];

    self.textView.scrollEnabled = NO;
    self.textView.editable = NO;
    self.textView.textContainer.exclusionPaths = @[[self imageBezierPath]];
}

- (UIBezierPath *)imageBezierPath {
    CGRect rect = [self.textView convertRect:self.imageView.frame fromView:self.view];
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [pan translationInView:self.view];
            CGPoint center = self.imageView.center;
            center.x += translation.x;
            center.y += translation.y;
            self.imageView.center = center;
            self.textView.textContainer.exclusionPaths = @[[self imageBezierPath]];
            [pan setTranslation:CGPointZero inView:self.view];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [pan setTranslation:CGPointZero inView:self.view];
            break;
        default:
            break;
    }
}

@end
