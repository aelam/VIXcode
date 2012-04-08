//
//  VICommandView.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VICommandView.h"

#define COMMAND_VIEW_HEIGHT     20
#define COMMAND_VIEW_OFFSET     10

@implementation VICommandView

- (id)init {
    self = [self initWithFrame:NSMakeRect(0,0,0,COMMAND_VIEW_HEIGHT)];
    
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
    
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldBoundsSize {
    NIF_INFO();
    CGFloat width = NSWidth(self.frame);
    
    _cmdField.frame = NSMakeRect(0,0,width * 0.75,COMMAND_VIEW_HEIGHT);
    _appendField.frame = NSMakeRect(width * 0.75,0,width * 0.25,COMMAND_VIEW_HEIGHT);
    
}

- (void)updateCommand:(NSString *)cmd {
    _cmdField.stringValue = cmd?cmd:@"";
}

- (void)updateAppendInfo:(NSString *)info {
    _appendField.stringValue = info?info:@"";
}

- (void)dealloc {
    [_cmdField release];
    [_appendField release];
    [super dealloc];
}






@end
