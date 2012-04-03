//
//  DVTSwizzleSourceTextView.h
//  VIXcode
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class VIMotionManager;

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

- (void)origin_drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color turnedOn:(BOOL)flag;
- (void)origin__drawInsertionPointInRect:(NSRect)aRect color:(NSColor*)aColor;

- (void)origin_resetCursorRects;

- (void)origin_insertText:(id)insertString;
- (void)origin_doCommandBySelector:(SEL)aSelector;

- (void)pre_dealloc;
- (void)origin_dealloc;

@end

@interface DVTSwizzleSourceTextView:NSTextView<DVTSwizzleProtocol> {

}

@property (nonatomic,assign) VIMotionManager *viMotionManager;

- (void)setViMotionManager:(VIMotionManager *)manager;
- (VIMotionManager *)viMotionManager;

@end

