//
//  NSTextView+Actions.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+Actions.h"

@implementation NSTextView (Actions)

- (void)changeCaseOfLetter:(id)sender {
    NIF_INFO();
}

- (void)moveBackwardCharactersCount:(NSUInteger)count {
    NSRange range = [[[self selectedRanges] objectAtIndex:0] rangeValue];
    
    NSUInteger wantedLoc = range.location - count;

    NSUInteger newLoc = ((NSInteger)wantedLoc)>=0?wantedLoc:0;
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}

- (void)moveForwardCharactersCount:(NSUInteger)count {
    NSRange range = [[[self selectedRanges] objectAtIndex:0]rangeValue];
    
    NSUInteger wantedLoc = range.location + count;
    
    NSUInteger newLoc = (NSUInteger)wantedLoc <=[[self string]length]?wantedLoc:[[self string]length];
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}



@end
