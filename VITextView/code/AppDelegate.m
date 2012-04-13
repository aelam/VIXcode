//
//  AppDelegate.m
//  VITextView
//
//  Created by Ryan Wang on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
//#import <VIKit/VIEventProcessor.h>
#import <VIKit/VIKit.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize textView = _textView;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    VIEventProcessor *eventProcess = [VIEventProcessor sharedProcessor];
    eventProcess.currentTextView = _textView;
        
}

//- (void)viewDidMoveToSuperview {
//    VIEventProcessor *eventProcess = [VIEventProcessor sharedProcessor];
//    [eventProcess.currentCommandView addMeOnTextView];
        
//}



@end
