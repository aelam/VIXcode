//
//  DVTSwizzleSourceTextView.m
//  VIXcode
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DVTSwizzleSourceTextView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "RuntimeReporter.h"
#import "VISettingsManager.h"
#import "VIEventProcessor.h"
//#import "VIMotionManager.h"
//#import "VICommandView.h"


//static char const * const VIMotionManagerAssociatedKey = "VIMotionManagerAssociatedKey";
static char const * const VICommandViewAssociatedKey = "VICommandViewAssociatedKey";


@implementation DVTSwizzleSourceTextView

//@synthesize viMotionManager = _viMotionManager;
@synthesize commandView = _commandView;

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {
    NIF_INFO(@"%@",theEvent);
    
//    unichar charcode = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
//    NSLog(@"keyDown : keyCode:%d characters:%@ charsIgnoreMod:%@ ASCII:%d", [theEvent keyCode], 
//          [theEvent characters], [theEvent charactersIgnoringModifiers], charcode);
//    
//    if( [[self window] firstResponder] !{= {self){
//    
//        return NO;
//        
//    }
    return [self origin_performKeyEquivalent:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent {

          [self origin_keyUp:theEvent];
}

- (void)keyDown:(NSEvent *)theEvent {

//    NIF_INFO(@"%@",theEvent);
    if ([[VISettingsManager sharedSettingsManager] isVIMEnabled]) {
//        if ([self.commandView handleKeyEvent:theEvent]) {
//            return;
//        }        
    }
    
    [self origin_keyDown:theEvent];
}

-  (void)mouseUp:(NSEvent *)theEvent {
    
    [self origin_mouseUp:theEvent];
}

-  (void)mouseDown:(NSEvent *)theEvent {
    
    [self origin_mouseDown:theEvent];
}

- (BOOL)becomeFirstResponder {
    self.commandView.active = YES;
    
    return [self origin_becomeFirstResponder];
}

- (BOOL)resignFirstResponder {

    self.commandView.active = NO;
    return [self origin_resignFirstResponder];
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

    if (YES) {
//    if (self.commandView.eventProcessor.state == VIMStateInsert || ![[VISettingsManager sharedSettingsManager] isVIMEnabled]) {
        [self origin__drawInsertionPointInRect:aRect color:aColor];
    } else {
        [self drawInsertionPointInRect:aRect color:aColor turnedOn:YES];
    }
}

- (void)drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color turnedOn:(BOOL)flag {
    if (YES) {        
//    if (self.commandView.eventProcessor.state == VIMStateInsert || ![[VISettingsManager sharedSettingsManager] isVIMEnabled]) {
        [self origin_drawInsertionPointInRect:rect color:color turnedOn:flag];        
    } else {
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
    
}


/////////////////////////////////////

- (void)insertText:(id)insertString {
//   if(VIMState == INSERT_STATE) {
//          [self origin_insertText:insertString];
//} {else {
//    NSString *plainString = [insertString isKindOfClass:[NSString class]]?insertString:[insertString string];
//    if ([plainString isEqualToString:@"p"]) {
//        [self {moveWordBackward:{self];
//    } else{i
//    NIF_INFO(@"%@",insertString);
//    if ([plainString isEqualToString:@"{"]) {
//        [self moveWordBackward:self];
//    }
    
    [self origin_insertText:insertString];

}

- (void)doCommandBySelector:(SEL)aSelector{
    NIF_INFO(@"%@",NSStringFromSelector(aSelector));
    [self origin_doCommandBySelector:aSelector];    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NIF_INFO();
    self = [self origin_initWithCoder:aDecoder];

    if (self.commandView == nil) {
        [self setCommandView:[VICommandView commandViewWithSourceTextView:self]];
    }
        
    [self setInsertionPointColor:[NSColor redColor]];
    
    NIF_INFO(@"window: %@",self.window);
//contentView
    NIF_INFO(@"%@",self.window.contentView);

    return self;
}


- (void)viewWillMoveToSuperview:(NSView *)newSuperview {

}

- (void)viewDidMoveToSuperview {
//    NIF_INFO(@"--------------------");
//    NIF_INFO(@"%@",[self enclosingScrollView]);
    
//    [self.viMotionManager setupUIStaff];
    [self.commandView addMe];

}


- (void)pre_dealloc {
    NIF_INFO();
    //
    // remove commandView
    //
//    objc_removeAssociatedObjects(self);
    
    // do origin stuff
    [self origin_dealloc];
}


//- (void)setCommandView:(VICommandView *)commandView {
//    objc_setAssociatedObject(self,VICommandViewAssociatedKey,commandView,OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (VICommandView *)commandView {
//    return objc_getAssociatedObject(self,VICommandViewAssociatedKey);
//}





@end
