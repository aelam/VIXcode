//
//  DVTSwizzleSourceTextView.m
//  VIXcode
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DVTSwizzleSourceTextView.h"
#import <QuartzCore/QuartzCore.h>
#import "VIMotionManager.h"
#import <objc/runtime.h>
#import "RuntimeReporter.h"

static char const * const VIMotionManagerAssociatedKey = "VIMotionManagerAssociatedKey";


@implementation DVTSwizzleSourceTextView

@synthesize viMotionManager = _viMotionManager;

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {

    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
    NSLog(@"keyDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);
    
    if( [[self window] firstResponder] != self){
    
        return NO;
        
    }
    return [self origin_performKeyEquivalent:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {
    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
//    NSLog(@"keyUp : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
//          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);

          [self origin_keyUp:theEvent];
}

- (void)keyDown:(NSEvent *)theEvent {
    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
//    NSLog(@"keyDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
//          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);

    [self origin_keyDown:theEvent];
}

-  (void)mouseUp:(NSEvent *)theEvent {
//    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];

//    NIF_TRACE(@"%@",theEvent);
    
    [self origin_mouseUp:theEvent];
}

-  (void)mouseDown:(NSEvent *)theEvent {
//    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
//    NSLog(@"mouseDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
//          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);
//    NSLog(@"%@",theEvent);


    
//    NSApplication *sharedApplication = [NSApplication sharedApplication];
//    NSWindow *keyWindow = [sharedApplication keyWindow];
//    id contentView = [keyWindow contentView];
//    NIF_TRACE(@"contentView : %@",[contentView subviews]);

//    NSView *testView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    
//    CALayer *viewLayer = [CALayer layer];
//    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
//    [testView setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
//    [testView setLayer:viewLayer];
//    
//    [contentView addSubview:testView];
//    [testView release];
    
//    NIF_TRACE(@"%@",sharedApplication);
//    NIF_TRACE(@"[sharedApplication keyWindow] = %@", keyWindow);
//    NIF_TRACE(@"contentView = %@",contentView);

    
    
    [self origin_mouseDown:theEvent];
}

- (void)setSelectedRange:(NSRange)charRange {

    [self origin_setSelectedRange:charRange];
//    NSLog(@"----------- %s range : %@",__PRETTY_FUNCTION__,[NSValue valueWithRange:charRange]);
    
}

- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)flag{    
    [self origin_setSelectedRange:charRange affinity:affinity stillSelecting:flag];
    
}

/**
 *
 * If VIM_STATE is VISUAL return NO
 *
 **/
- (BOOL)shouldDrawInsertionPoint{
    
    return YES;
}


/**
 * The two methods set cursor for different VI mode
 * 1. Blick 
 * 2. Blink Block cursor
 */
- (void)_drawInsertionPointInRect:(NSRect)aRect color:(NSColor*)aColor{

//    [self origin__drawInsertionPointInRect:aRect color:aColor];
    [self drawInsertionPointInRect:aRect color:aColor turnedOn:YES];
}

- (void)drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color turnedOn:(BOOL)flag {
       
    if (NO) {
        [self origin_drawInsertionPointInRect:rect color:color turnedOn:flag];        
    }
    
    if(flag){
        color = [color colorWithAlphaComponent:0.5];
        NSPoint aPoint=NSMakePoint( rect.origin.x,rect.origin.y+rect.size.height/2);
        int glyphIndex = [[self layoutManager] glyphIndexForPoint:aPoint inTextContainer:[self textContainer]];
        NSRect glyphRect = [[self layoutManager] boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1)  inTextContainer:[self textContainer]];

        [color set];
        rect.size.width =rect.size.height/2 + 3;
        if(glyphRect.size.width > 0 && glyphRect.size.width < rect.size.width) 
            rect.size.width=glyphRect.size.width;
        NSRectFillUsingOperation( rect, NSCompositeSourceOver);
    } else {
        [self setNeedsDisplayInRect:[self visibleRect] avoidAdditionalLayout:NO];
    }
}


/////////////////////////////////////

- (void)insertText:(id)insertString {
//   if(VIMState == INSERT_STATE) {
//          [self origin_insertText:insertString];
//} else {
//    NSString *plainString = [insertString isKindOfClass:[NSString class]]?insertString:[insertString string];
//    if ([plainString isEqualToString:@"p"]) {
//        [self moveWordBackward:self];
//    } else{i
    NIF_INFO(@"NSApp %@",NSApp);
    NIF_INFO(@"Nkeywindow %@",[NSApplication sharedApplication].keyWindow);
    NIF_INFO(@"self %@",self);
        
    
    
    NIF_INFO(@"%@",[self viMotionManager]);
    
      
    [self origin_insertText:insertString];

}

- (void)doCommandBySelector:(SEL)aSelector{
    NIF_INFO(@"%@",NSStringFromSelector(aSelector));
    [self origin_doCommandBySelector:aSelector];
}



- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [self origin_initWithCoder:aDecoder];

    if (self.viMotionManager == nil) {
        VIMotionManager *manager = [VIMotionManager managerWithSourceTextView:self];
        [self setViMotionManager:manager];    
    }

    NIF_INFO(@"%@",self);
    [self setInsertionPointColor:[NSColor redColor]];
    
    return self;
}

- (void)pre_dealloc {
    NIF_INFO();
    //
    // remove manager
    //
    objc_removeAssociatedObjects(self);
    
    // do origin stuff
    [self origin_dealloc];
}

//
// Should be Inject into DVTSourceTextView
//
- (void)setViMotionManager:(VIMotionManager *)manager {
    objc_setAssociatedObject(self,VIMotionManagerAssociatedKey,manager,OBJC_ASSOCIATION_ASSIGN);
}

- (VIMotionManager *)viMotionManager {
    return objc_getAssociatedObject(self,VIMotionManagerAssociatedKey);
}

@end
