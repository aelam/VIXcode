//
//  VICommandView.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VICommandView.h"
//#import "VIInsertEventProcessor.h"
#import "DVTSwizzleSourceTextView.h"
#import "VISettingsManager.h"

#define COMMAND_VIEW_HEIGHT     20
#define COMMAND_VIEW_OFFSET     10

@implementation VICommandView

@synthesize sourceView = _sourceView;
@synthesize eventProcessor = _eventProcessor;
@synthesize active;

+ (id)commandViewWithSourceTextView:(id)sourceView {
    return [[[self alloc] initWithSourceTextView:sourceView] autorelease];
}

- (id)initWithSourceTextView:(id)sourceView  {
    self = [self initWithFrame:NSMakeRect(0,0,0,COMMAND_VIEW_HEIGHT)];
    
    // weak
    _sourceView = sourceView;
    
    // UI
    NSColor *clearColor = [NSColor colorWithSRGBRed:0 green:0.0 blue:0.0 alpha:0.0];
    NSColor *fontColor = [NSColor whiteColor];
    
    _cmdField = [[NSTextField alloc] initWithFrame:NSMakeRect(0,0,0,COMMAND_VIEW_HEIGHT)];
    [_cmdField setBackgroundColor:clearColor];
    [_cmdField setTextColor:fontColor];
    [_cmdField setAutoresizingMask:NSViewMinXMargin|NSViewWidthSizable|NSViewMinYMargin];
    [self addSubview:_cmdField];
    
    _appendField = [[NSTextField alloc] initWithFrame:NSMakeRect(0,0,0,COMMAND_VIEW_HEIGHT)];
    [_appendField setBackgroundColor:clearColor];
    [_appendField setTextColor:fontColor];
    [_appendField setAutoresizingMask:NSViewMaxXMargin|NSViewWidthSizable|NSViewMinYMargin];
    [self addSubview:_appendField];
    
    // Notification
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(vimFunctionSwitched:) name:VISettingsManagerEnableNotification object:nil];
    
    return self;
}

- (void)addMe {
    NSScrollView* scrollView = [_sourceView enclosingScrollView]; // DVTSourceTextScrollView
    
    NSRect scrollViewFrame = scrollView.frame;
    
    self.frame = NSMakeRect(40, NSMaxY(scrollViewFrame) - 30,NSWidth(_sourceView.frame),20);
    
//    if ([scrollView isKindOfClass:NSClassFromString(@"DVTSourceTextScrollView")]) {
    if ([scrollView isKindOfClass:NSClassFromString(@"NSScrollView")]) {
        
        [[scrollView contentView] setCopiesOnScroll:NO];
        
        if(![[scrollView subviews] containsObject:self]){
//            NIF_INFO(@"added!! %@",NSStringFromRect(scrollView.frame));
            [scrollView addSubview:self positioned:NSWindowAbove relativeTo:nil];
            
            [scrollView setPostsFrameChangedNotifications:YES];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frameDidChanged:) name:NSViewFrameDidChangeNotification  object:scrollView];
        }
    }
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldBoundsSize {
    CGFloat width = NSWidth(self.frame);
    
    _cmdField.frame = NSMakeRect(0,0,width * 0.75,COMMAND_VIEW_HEIGHT);
    _appendField.frame = NSMakeRect(width * 0.75,0,width * 0.25,COMMAND_VIEW_HEIGHT);
    
}

- (void)frameDidChanged:(NSNotification *)notification {
    
    NSScrollView* scrollView = [notification object];
    
    self.frame = NSMakeRect(40,NSMaxY(scrollView.frame) - 30,NSWidth(scrollView.frame)-50,20);
    
}

- (void)vimFunctionSwitched:(NSNotification *)notification {
    self.hidden = ! [[VISettingsManager sharedSettingsManager] isVIMEnabled];
}


- (void)setActive:(BOOL)flag {
    active = flag;
    if (!flag) {
        [self clear];
    }
}

- (void)clear {
    _cmdField.stringValue = @"";
    _appendField.stringValue = @"";
}


- (void)updateCommand:(NSString *)cmd {
    _cmdField.stringValue = cmd?cmd:@"";
}

- (void)updateAppendInfo:(NSString *)info {
    _appendField.stringValue = info?info:@"";
}


- (BOOL)handleKeyEvent:(NSEvent *)theEvent {
    NIF_INFO(@"%@",theEvent);
    
    return [_eventProcessor handleKeyEvent:theEvent];
}

- (void)setEventProcessor:(VIEventProcessor *)newProcessor {
    if (newProcessor != _eventProcessor) {
        [_eventProcessor release];
        _eventProcessor = [newProcessor retain];        
        
        [self stateWillChange:newProcessor];
    }
}

#pragma mark -
#pragma mark VIEventDelegate
- (void)stateWillChange:(VIEventProcessor *)newProcessor {
    NIF_INFO();
    
//    [self updateCommand:newProcessor._cmdBuffer];
//    [self updateAppendInfo:newProcessor.appendString];
    
}


- (void)dealloc {
    [_cmdField release];
    [_appendField release];
    
    [_eventProcessor release];
    [super dealloc];
}






@end
