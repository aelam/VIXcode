//
//  VITextView.m
//  VIXcode
//
//  Created by Ryan Wang on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define EXTERN

#import "VITextView.h"
#import <VIKit/VIKit.h>
#include "vim.h"
#import "NSTextView+Positions.h"
#import "RuntimeReporter.h"

@implementation VITextView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setInsertionPointColor:[NSColor redColor]];
        
        NSString *path = @"/Users/ryan/Documents/VIXcode/VIKit/code/VITextView.m";
        NSError *error = nil;
        NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            [self setString:@"[self setInsertionPointColor:[NSColor redColor]];"];            
        } else {
            [self setString:contents];
        }
        
    [self setRulerVisible:YES];
    }
    return self;
}

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
    
    if (State == INSERT) {
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
    
    if (State == INSERT) {
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


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];

    NSLayoutManager *layoutManager = [self layoutManager];
    NSUInteger textLength = [[self textStorage] length];
    NSRange textCharRange = NSMakeRange(0, textLength);
    // Remove any existing coloring.
    [layoutManager removeTemporaryAttribute:NSBackgroundColorAttributeName forCharacterRange:textCharRange];

    // Color the characters using temporary attributes
    [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor cyanColor], NSBackgroundColorAttributeName, nil] forCharacterRange:[self currentLineRange]];
            [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor yellowColor], NSBackgroundColorAttributeName, nil] forCharacterRange:[self currentWordRange]];
        [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor magentaColor], NSBackgroundColorAttributeName, nil] forCharacterRange:NSMakeRange(self.currentCharIndex, 1)];
/*
    
    /// 
    NSUInteger lineCount = [self lineCount];
    NIF_INFO(@"[[self textStorage] lineCount] = %lu",lineCount);
//    for (int i = 0; i < lineCount; i++) {
//        NIF_INFO(@"[rangeOfLine:%i]=%@",i,NSStringFromRange([self rangeOfLine:i]));
//    }

    NSPosition position = [self positionOfLocation:[self insertionPoint]];
    NIF_INFO(@"Insert Position : %@",NSStringFromPosition(position));
      
    NIF_INFO(@"visibleRange : %@ ",NSStringFromRange([self visibleRange]));

    NIF_INFO(@"locationInWindow : %@", NSStringFromPoint([theEvent locationInWindow]));
//    NIF_INFO(@"locationInWindow : %@", NSStringFromPoint([self convertPoint:[theEvent locationInWindow] fromView:self.window.contentView]));
   NIF_INFO(@"self glyphRect = %@",NSStringFromRect([self glyphRect]));

    NIF_INFO(@"self.visibleRect = %@",NSStringFromRect(self.visibleRect));
    
    
//    newLocation = [self.layoutManager 
//                   _charIndexForInsertionPointMovingFromY: startingY
//                   bestX: originalInsertionPoint
//                   up: NO
//                   textContainer: _textContainer];

    
//    [self scrollRangeToVisible:self.selectedRange];
    
//    NSRect rect = [self firstRectForCharacterRange:[self selectedRange]];
//    NIF_INFO(@"range : %@",NSStringFromRect(rect));
//    ;
//    [self scrollRectToVisible: [self convertRect:rect fromView:self.window.contentView]];
    //
    // color current line
    //
    //    if ([VIEventProcessor sharedProcessor].currentLineColor) {
    //        [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[VIEventProcessor sharedProcessor].currentLineColor, NSBackgroundColorAttributeName, nil] forCharacterRange:lineCharRange];
    //    }

//    [self test];
    [self testlineRectForRange];
}

- (void)test {
    NSRange characterRange = self.selectedRange;
    NSRange glyphRange = [[self layoutManager] glyphRangeForCharacterRange:characterRange actualCharacterRange:NULL];

    [[self layoutManager] ensureLayoutForGlyphRange:NSMakeRange(0, glyphRange.location + glyphRange.length)];
    
    NSTextContainer *container = [self textContainer];
    NSScrollView *scrollView = [self enclosingScrollView];
    NSRect glyphRect = [[self layoutManager] boundingRectForGlyphRange:glyphRange inTextContainer:container];
   
    NSUInteger rectCount = 0;
    NIF_INFO(@"currentLineRange = %@",NSStringFromRange(self.currentLineRange));
//    NIF_INFO(@"[self lineRectForRange:glyphRange] = %@",[self lineRectForRange:glyphRange]);
    NSRect *rects =  [[self layoutManager] rectArrayForCharacterRange:self.currentLineRange withinSelectedCharacterRange:NSMakeRange(NSNotFound, 0) inTextContainer:container rectCount:&rectCount];
    NIF_INFO(@"rectCount : %lu",rectCount);
    for (int i = 0; i < rectCount; i++) {
        NIF_INFO(@"rect %@",NSStringFromRect(rects[i]));        
    }
    
    
    
    NSRange range = [[[self selectedRanges] objectAtIndex:0] rangeValue];
    NSRect rect = [self firstRectForCharacterRange:range];
    NIF_INFO(@"firstRectForCharacterRange = %@",NSStringFromRect(rect));
    
    CGFloat glyphLeft = NSMidX(glyphRect) - NSWidth(glyphRect) / 2.0f;
    CGFloat glyphRight = NSMidX(glyphRect) + NSWidth(glyphRect) / 2.0f;
    NIF_INFO(@"glyphLeft = %f glyphRight = %f ",glyphLeft,glyphRight);
    
    NSRect contentRect = [[scrollView contentView] bounds];
    CGFloat viewLeft = contentRect.origin.x;
    CGFloat viewRight = contentRect.origin.x + NSWidth(contentRect);
    NIF_INFO(@"glyphLeft = %f glyphRight = %f ",viewLeft,viewRight);

    NIF_INFO(@"scroll Bound : %@",NSStringFromRect(scrollView.bounds));
    NIF_INFO(@"scroll frame : %@",NSStringFromRect(scrollView.frame));
    NIF_INFO(@"self Bound : %@",NSStringFromRect(self.bounds));    
    NIF_INFO(@"self frame : %@",NSStringFromRect(self.frame));    
    NIF_INFO(@"contentView : %@",NSStringFromRect(contentRect));    

    NIF_INFO(@"visibleRect: %@",NSStringFromRect(self.visibleRect));
    NIF_INFO(@"glyphRect %@",NSStringFromRect(glyphRect));
    
    NSRect testRect = NSIntersectionRect(self.visibleRect, NSMakeRect(54, 56, 13, 14));

    
    NIF_INFO(@"glyphRect & self.visibleRect = %@",NSStringFromRect(testRect));

    */
}

/*
- (void) drawViewBackgroundInRect:(NSRect)rect
{
    [super drawViewBackgroundInRect:rect];
    NSRange sel = [self selectedRange];
    NSString *str = [self string];
    if (sel.location <= [str length]) {
        NSRange lineRange = [str lineRangeForRange:NSMakeRange(sel.location,0)];
        NSRect lineRect = [self highlightRectForRange:lineRange];
        NSColor *highlightColor = [NSColor grayColor];
        [highlightColor set];
        [NSBezierPath fillRect:lineRect];
    }
}

// Returns a rectangle suitable for highlighting a background rectangle for the given text range.
- (NSRect) highlightRectForRange:(NSRange)aRange
{
    NSRange r = aRange;
    NSRange startLineRange = [[self string] lineRangeForRange:NSMakeRange(r.location, 0)];
    NSInteger er = NSMaxRange(r)-1;
    NSString *text = [self string];
    
    if (er >= [text length]) {
        return NSZeroRect;
    }
    if (er < r.location) {
        er = r.location;
    }
    
    NSRange endLineRange = [[self string] lineRangeForRange:NSMakeRange(er, 0)];
    
    NSRange gr = [[self layoutManager] glyphRangeForCharacterRange:NSMakeRange(startLineRange.location, NSMaxRange(endLineRange)-startLineRange.location-1)
                                              actualCharacterRange:NULL];
    NSRect br = [[self layoutManager] boundingRectForGlyphRange:gr inTextContainer:[self textContainer]];  
    NSRect b = [self bounds];
    CGFloat h = br.size.height;
    CGFloat w = b.size.width;
    CGFloat y = br.origin.y;  
    NSPoint containerOrigin = [self textContainerOrigin];  
    NSRect aRect = NSMakeRect(0, y, w, h);
    // Convert from view coordinates to container coordinates
    aRect = NSOffsetRect(aRect, containerOrigin.x, containerOrigin.y);
    return aRect;
}*/

- (void)scrollLineUp:(id)sender
{
    NSRect scrollRect;
    
    scrollRect= [self visibleRect];
    scrollRect.origin.y-=12;[[self enclosingScrollView] verticalLineScroll];
    NIF_INFO(@"[[self enclosingScrollView] verticalLineScroll] = %f",[[self enclosingScrollView] verticalLineScroll]);
    NIF_INFO(@"[[self enclosingScrollView] verticalLineScroll] = %f",[[self enclosingScrollView] lineScroll]);
    NIF_INFO(@"self.textStorage.font = %@",self.textStorage.font);
    NIF_INFO(@"self.textStorage.xHeight = %f",self.textStorage.font.xHeight);
    NIF_INFO(@"self.textStorage.pointSize = %f",self.textStorage.font.pointSize);
    NIF_INFO(@"self.textStorage.capHeight = %f",self.textStorage.font.capHeight);


    NIF_INFO(@"@self.defaultParagraphStyle.lineSpacing = %f",self.defaultParagraphStyle.lineSpacing);
    
    
    if (scrollRect.origin.y<0) scrollRect.origin.y=0;
    [self scrollRectToVisible: scrollRect];
}

- (void)scrollLineDown:(id)sender
{
    NSRange range = [self.string lineRangeForRange:NSMakeRange(5, 17)];
    NIF_INFO(@"%@",NSStringFromRange(range));
    NSRect scrollRect;
    
    scrollRect= [self visibleRect];
    scrollRect.origin.y+=12;[[self enclosingScrollView] verticalLineScroll];
    [self scrollRectToVisible: scrollRect];
    
}


@end
