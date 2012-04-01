//
//  DVTSwizzleSourceTextView.m
//  VIXcode
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DVTSwizzleSourceTextView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DVTSwizzleSourceTextView

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {

    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    NSLog(@"keyDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);
        
    BOOL done = NO;

    if( [[self window] firstResponder] != self){
    
        return NO;
        
    }
    return [self origin_performKeyEquivalent:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {
    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    NSLog(@"keyUp : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);

          [self origin_keyUp:theEvent];
}

- (void)keyDown:(NSEvent *)theEvent {
    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    NSLog(@"keyDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);

    [self origin_keyDown:theEvent];
}

-  (void)mouseUp:(NSEvent *)theEvent {
//    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];

    NIF_TRACE(@"%@",theEvent);
    
    [self origin_mouseUp:theEvent];
}

-  (void)mouseDown:(NSEvent *)theEvent {
//    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
//    NSLog(@"mouseDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
//          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);
    NSLog(@"%@",theEvent);

    NSApplication *sharedApplication = [NSApplication sharedApplication];
    NSWindow *keyWindow = [sharedApplication keyWindow];
    id contentView = [keyWindow contentView];
    NIF_TRACE(@"contentView : %@",[contentView subviews]);

//    NSView *testView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    
//    CALayer *viewLayer = [CALayer layer];
//    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
//    [testView setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
//    [testView setLayer:viewLayer];
//    
//    [contentView addSubview:testView];
//    [testView release];
    
    NIF_TRACE(@"%@",sharedApplication);
    NIF_TRACE(@"[sharedApplication keyWindow] = %@", keyWindow);
    NIF_TRACE(@"contentView = %@",contentView);

    
    [self origin_mouseDown:theEvent];
}

- (void)setSelectedRange:(NSRange)charRange {

    
    
    
    
    
    
    
    [self origin_setSelectedRange:charRange];
    NSLog(@"----------- %s range : %@",__PRETTY_FUNCTION__,[NSValue valueWithRange:charRange]);
    
}

- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)flag{    
    [self origin_setSelectedRange:charRange affinity:affinity stillSelecting:flag];

}

- (id)initWithCoder:(NSCoder *)aDecoder {

    
    
    [self origin_initWithCoder:aDecoder];
    
    NSLog(@"----------- %@",NSStringFromSelector(_cmd));    
    return self;
}

@end
