//
//  VIMotionManager.m
//  VIXcode
//
//  Created by Ryan Wang on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIMotionManager.h"
#import "DVTSwizzleSourceTextView.h"
#import "NSEvent+Keymap.h"
#import "MacKeyMap.h"
#import "RuntimeReporter.h"
#import "VICommandView.h"
#import "VIInsertEventProcessor.h"
#import "VINormalEventProcessor.h"
#import "VIVisualEventProcessor.h"

@implementation VIMotionManager

@synthesize sourceView = _sourceView;
@synthesize eventProcessor = _eventProcessor;

#define CMD_FIELD_HEIGHT    20
#define CMD_FIELD_OFFSET    10

+ (VIMotionManager *)managerWithSourceTextView:(id)sourceView {
    return [[[self alloc] initWithSourceView:sourceView] autorelease];
}

- (id)initWithSourceView:(DVTSwizzleSourceTextView *)sourceView {
    if (self = [super init]) {
        _sourceView = sourceView;
        _cmdView = [[[VICommandView alloc] init] autorelease];
                
        _eventProcessor = [[VIInsertEventProcessor alloc] initWithMotionManager:self];

        [self _updateCMDViewHidden];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(vimFunctionSwitched:) name:VISettingsManagerEnableNotification object:nil];

    }
    return self;
}


- (void)setupUIStaff {

    NSScrollView* scrollView = [_sourceView enclosingScrollView]; // DVTSourceTextScrollView
    
    NSRect scrollViewFrame = scrollView.frame;
    
    _cmdView.frame = NSMakeRect(40, NSMaxY(scrollViewFrame) - 30,NSWidth(_sourceView.frame),20);
    
    if ([scrollView isKindOfClass:NSClassFromString(@"DVTSourceTextScrollView")]) {

        [[scrollView contentView] setCopiesOnScroll:NO];

        if(![[scrollView subviews] containsObject:_cmdView]){
            NIF_INFO(@"added!! %@",NSStringFromRect(scrollView.frame));
            [scrollView addSubview:_cmdView positioned:NSWindowAbove relativeTo:nil];
            
            [scrollView setPostsFrameChangedNotifications:YES];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frameDidChanged:) name:NSViewFrameDidChangeNotification  object:scrollView];
            
        }
    }
}

- (void)frameDidChanged:(NSNotification *)notification {
    
    NSScrollView* scrollView = [notification object];
        
    _cmdView.frame = NSMakeRect(40,NSMaxY(scrollView.frame) - 30,NSWidth(scrollView.frame)-50,20);
    
}

- (void)vimFunctionSwitched:(NSNotification *)notification {
    
    NIF_INFO(@"--- %@",[notification object]);
    
    [self _updateCMDViewHidden];
}

- (void)_updateCMDViewHidden {
        _cmdView.hidden = ! [[VISettingsManager sharedSettingsManager] isVIMEnabled];
}

- (void)reset {
    
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
    
    [_cmdView updateCommand:newProcessor.cmdString];
    [_cmdView updateAppendInfo:newProcessor.appendString];

}

- (void)dealloc {
    NIF_INFO();
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    SAFELY_RELEASE(_sourceView);
    [_eventProcessor release];
    [super dealloc];
}

@end
