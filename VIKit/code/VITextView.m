//
//  VITextView.m
//  VIXcode
//
//  Created by Ryan Wang on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VITextView.h"
#import <VIKit/VIKit.h>

@implementation VITextView

- (void)keyDown:(NSEvent *)theEvent {
    
    VIEventProcessor *eventProcesser = [VIEventProcessor sharedProcessor];
    
    if ([eventProcesser handleKeyEvent:theEvent]) {
        
    } else {
        [super keyDown:theEvent];
    }
}


#pragma mark -
#pragma mark set CURSOR SHAPE
- (void)_drawInsertionPointInRect:(NSRect)aRect color:(NSColor*)aColor{
    
    NSUInteger state = [VIEventProcessor sharedProcessor].state;
    if (state == INSERT) {
        if ([self respondsToSelector:@selector(origin__drawInsertionPointInRect:color:)]) {
            [self origin__drawInsertionPointInRect:aRect color:aColor];
        } else {
            goto origin_point;
        }
    } else {
        goto origin_point;
    }
    
origin_point:
    [super _drawInsertionPointInRect:aRect color:aColor];
    [self setNeedsDisplayInRect:[self visibleRect] avoidAdditionalLayout:NO];
}

- (void)drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color turnedOn:(BOOL)flag {
    
    NSUInteger state = [VIEventProcessor sharedProcessor].state;
    if (state == INSERT) {
        if ([self respondsToSelector:@selector(origin_drawInsertionPointInRect:color:turnedOn:)]) {
            [self origin_drawInsertionPointInRect:rect color:color turnedOn:flag];                    
        } else {
            [super drawInsertionPointInRect:rect color:color turnedOn:flag];
        }
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




@end
