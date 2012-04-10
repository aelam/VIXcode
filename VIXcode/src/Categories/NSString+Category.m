//
//  NSString+Category.m
//  VIXcode
//
//  Created by Ryan Wang on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (BOOL)isStartWithNumeric {
    if (self.length > 0) {
        return [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[self characterAtIndex:0]];
    }
    return NO;
}


@end
