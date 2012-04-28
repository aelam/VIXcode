//
//  NSTextView+Actions.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSPosition.h"


@interface NSTextView (Actions)

- (void)cursorUp:(NSUInteger)count;
- (void)cursorDown:(NSUInteger)count;

- (void)moveCursorToPosition:(NSPosition)newPosition;

- (void)changeCaseOfLetter:(id)sender;

- (void)moveBackwardCharactersCount:(NSUInteger)count;
- (void)moveForwardCharactersCount:(NSUInteger)count;

- (void)moveToBeginning;
- (void)moveToEnd;

@end
