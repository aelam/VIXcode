//
//  NSTextView+Actions.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+Actions.h"
#import "NSTextView+Positions.h"

@implementation NSTextView (Actions)

- (void)changeCaseOfLetter:(id)sender {
    NIF_INFO();
}

- (void)cursorUp:(NSUInteger)count {
    NSPosition currentPosition = [self positionOfLocation:[self insertionPoint]];
    
    // stop cursor Up while cursor row is 0
    if (currentPosition.row == 0) {
        return;
    }
    
    NSUInteger descRow = MAX(0, currentPosition.row - count);
    
    NSRange descLineRange = [self rangeOfLine:descRow];
    
    NSUInteger descColumn = MIN(currentPosition.column,descLineRange.length);
    
    NSRange descRange = NSMakeRange(descLineRange.location + descColumn, 0);
    
    [self setSelectedRange:descRange];

    NIF_INFO(@"%@",NSStringFromRange(self.visibleRange));
}


- (void)cursorDown:(NSUInteger)count {
    NSPosition currentPosition = [self positionOfLocation:[self insertionPoint]];
    
    NSUInteger lineCount = [self lineCount];
    
    // stop cursor Up while cursor row is 0
    if (currentPosition.row == lineCount) {
        return;
    }
    
    NSUInteger descRow = MIN(lineCount, currentPosition.row + count);

    NSRange descLineRange = [self rangeOfLine:descRow];

    NSUInteger descColumn = MIN(currentPosition.column,descLineRange.length);
    
    NSRange descRange = NSMakeRange(descLineRange.location + descColumn, 0);
    
    [self setSelectedRange:descRange];
//    [self scrollLineDown:self];
    NIF_INFO(@"%@",NSStringFromRange(self.visibleRange));

}

- (void)moveCursorToPosition:(NSPosition)newPosition selected:(BOOL)selected{
    
//    [self setSelectedRange:NSMakeRange(<#NSUInteger loc#>, <#NSUInteger len#>)]
}

- (void)moveBackwardCharactersCount:(NSUInteger)count {
    
    NSUInteger wantedLoc = self.insertionPoint - count;

    NSUInteger newLoc = ((NSInteger)wantedLoc)>=0?wantedLoc:0;
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}

- (void)moveForwardCharactersCount:(NSUInteger)count {
    
    NSUInteger wantedLoc = self.insertionPoint + count;
    
    NSUInteger newLoc = (NSUInteger)wantedLoc <=[[self string]length]?wantedLoc:[[self string]length];
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}

- (void)moveToBeginning {
    NSRange zeroRange = { 0, 0 };
    [self setSelectedRange: zeroRange];   
}

- (void)moveToEnd {
    NSRange range = { [[self string] length], 0 };
    [self setSelectedRange: range];
}

- (void)moveAndScrollToBeginning {
    NSRange range = { 0, 0 };
    [self setSelectedRange: range];
    [self scrollRangeToVisible: range];
}

- (void)moveAndScrollToEnd {
    NSRange range = { [[self string] length], 0 };
    [self setSelectedRange: range];
    [self scrollRangeToVisible: range];
}

- (void)scrollToCursor {    
    NSRect lineRect = [self lineRectForRange:[self selectedRange]];
    NSRect visibleRect = self.visibleRect;
    
    if (NSMaxY(lineRect) > NSMaxY(visibleRect)) {
        visibleRect.origin.y = NSMinY(visibleRect) + (NSMaxY(lineRect) - NSMaxY(visibleRect));
    } else if (NSMinY(lineRect) < NSMinY(visibleRect)) {
        visibleRect.origin.y = NSMinY(lineRect);
    } else {
        // Do nothing
    }
    [self scrollRectToVisible:visibleRect];    
}

@end
