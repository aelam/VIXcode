//
//  NSTextView+Positions.m
//  VIXcode
//
//  Created by Ryan Wang on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+Positions.h"
#import "NSString+LineRange.h"

@implementation NSTextView (CurrentLine)

- (NSUInteger)currentLineNumber {
    return [self positionOfLocation:self.insertionPoint].row;
}


- (NSRange)currentLineRange {
    return [self rangeOfLine:[self currentLineNumber]];
}

- (NSRange)currentWordRange {
    
    NSRange lineGlyphRange = [self currentLineRange];
    
    NSRange lineCharRange = [[self layoutManager] characterRangeForGlyphRange:lineGlyphRange actualGlyphRange:NULL];
    NSUInteger charIndex = [[self layoutManager] characterIndexForGlyphAtIndex:[self insertionPoint]];
    
    NSRange wordCharRange = NSIntersectionRange(lineCharRange, [self selectionRangeForProposedRange:NSMakeRange(charIndex, 0) granularity:NSSelectByWord]);
    NIF_INFO(@"%@",NSStringFromRange(wordCharRange));
    return wordCharRange;
}

- (NSUInteger)currentCharIndex {
    return [self.layoutManager characterIndexForGlyphAtIndex:[self insertionPoint]];
}

@end

@implementation NSTextView (Position)

- (NSUInteger)insertionPoint {
    return [[[self selectedRanges] objectAtIndex:0] rangeValue].location;
}

- (BOOL)isEndOfLine {

    return YES;    
}

- (BOOL)isBeginningOfLine {
    return YES;
}


- (NSRect)glyphRect {
    NSLayoutManager *layoutManager = [self layoutManager];
    NSTextContainer *textContainer = [self textContainer];

    return [layoutManager boundingRectForGlyphRange:NSMakeRange(self.insertionPoint, 1) inTextContainer:textContainer];
    
}

- (NSUInteger)lineCount {
    return [self.string lineCount];
}

- (NSRange)rangeOfLine:(NSUInteger)line {
    return [self.string rangeOfLine:line];
}

- (NSRange)rangeOfLines:(NSRange)lines_ {
    return [self.string rangeOfLines:lines_];
}

- (NSPosition)positionOfLocation:(NSUInteger)aLocation {
    return [self.string positionOfLocation:aLocation];
}


- (NSRange)visibleRange {
    NSRect visibleRect = [self visibleRect];
    NSLayoutManager *lm = [self layoutManager];
    NSTextContainer *tc = [self textContainer];
    
    NSRange glyphVisibleRange = [lm glyphRangeForBoundingRect:visibleRect inTextContainer:tc];;
    NSRange charVisibleRange = [lm characterRangeForGlyphRange:glyphVisibleRange  actualGlyphRange:nil];
    return charVisibleRange;
}


/* How about the efficience 
- (NSUInteger)numberOfLines {
    NSString *string = self.string;
    unsigned numberOfLines, index, stringLength = [string length];
    for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++)
        index = NSMaxRange([string lineRangeForRange:NSMakeRange(index, 0)]);

    return numberOfLines;
}
*/


@end

