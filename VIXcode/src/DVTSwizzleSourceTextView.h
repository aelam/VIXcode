//
//  DVTSwizzleSourceTextView.h
//  VIXcode
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DVTSwizzleProtocol <NSObject>

@optional
- (id)origin_initWithCoder:(NSCoder *)aDecoder;
- (void)origin_setSelectedRange:(NSRange)charRange;
- (void)origin_setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)flag;  

- (BOOL)origin_performKeyEquivalent:(NSEvent *)theEvent;

- (void)origin_keyUp:(NSEvent *)theEvent;
- (void)origin_keyDown:(NSEvent *)theEvent;
- (void)origin_mouseUp:(NSEvent *)theEvent;
- (void)origin_mouseDown:(NSEvent *)theEvent;

@end

@interface DVTSwizzleSourceTextView:NSTextView<DVTSwizzleProtocol>

    
@end

