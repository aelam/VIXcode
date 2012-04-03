//
//  NSView+Subviews.m
//  VIXcode
//
//  Created by Ryan Wang on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSView+Subviews.h"


@implementation NSView (Subviews)


- (void)printAllSubviews {
    [self _printAllSubviewsWithLevel:0];
}

- (void)_printAllSubviewsWithLevel:(NSUInteger)level {
    NSString *identString = [@"" stringByPaddingToLength:level withString:@"-" startingAtIndex:0];
    NSArray *subviews = [self subviews];
    for (NSView *subview in subviews) {
        fprintf(stderr,"%s%s",[identString UTF8String],[[subview description] UTF8String]);
        [subview _printAllSubviewsWithLevel:level+1];
    }
}


@end
