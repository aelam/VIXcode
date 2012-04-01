//
//  VICommandField.m
//  VIXcode
//
//  Created by Ryan Wang on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VICommandField.h"

#define VICommandFieldHeight 15

@implementation VICommandField

+ (VICommandField *)sharedInstance {
    static dispatch_once_t pred;
    static VICommandField *_viCommandField = nil;

    dispatch_once(&pred, ^{
        _viCommandField = [[VICommandField alloc] init];
        _viCommandField.tag = VICommandFieldTag;
    });
    return _viCommandField;
}

- (id)init {
    if (self = [super init]) {
        self.autoresizingMask = NSViewMaxXMargin | NSViewMinXMargin | NSViewMaxYMargin;
        CALayer *viewLayer = [CALayer layer];
        [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
        [self setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
        [self setLayer:viewLayer];

    }
    return self;
}

- (void)vi_sizeToFit {
    NSView *superView = [self superview];
    if (superView) {
        self.frame = NSMakeRect(0, NSMaxY(superView.frame) - VICommandFieldHeight, NSWidth(superView.frame), VICommandFieldHeight);
    }
}

@end
