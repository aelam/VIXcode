//
//  VIPlugin.m
//  PluginTest
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#import "VISettingsManager.h"
#import <VIKit/VIKit.h>

void Hook() {
        
    // Hook
    Class DVTSourceTextView = NSClassFromString(@"DVTSourceTextView");
//    Class targetClass = [DVTSwizzleSourceTextView class];
    Class targetClass = [VITextView class];
    NSLog(@"HookClass %@",targetClass);
    
    HookSelector(DVTSourceTextView, @selector(initWithCoder:), targetClass, @selector(initWithCoder:), @selector(origin_initWithCoder:));
    
    HookSelector(DVTSourceTextView, @selector(setSelectedRange:), targetClass, @selector(setSelectedRange:), @selector(origin_setSelectedRange:));
    
    HookSelector(DVTSourceTextView, @selector(keyUp:), targetClass, @selector(keyUp:), @selector(origin_keyUp:));
    
    HookSelector(DVTSourceTextView, @selector(keyDown:), targetClass, @selector(keyDown:), @selector(origin_keyDown:));
    
    HookSelector(DVTSourceTextView, @selector(mouseUp:), targetClass, @selector(mouseUp:), @selector(origin_mouseUp:));
    
    HookSelector(DVTSourceTextView, @selector(mouseDown:), targetClass, @selector(mouseDown:), @selector(origin_mouseDown:));
    
    HookSelector(DVTSourceTextView, @selector(insertText:), targetClass, @selector(insertText:), @selector(origin_insertText:));
    
    //    
    HookSelector(DVTSourceTextView, @selector(doCommandBySelector:), targetClass, @selector(doCommandBySelector:), @selector(origin_doCommandBySelector:));
    
    HookSelector(DVTSourceTextView, @selector(drawInsertionPointInRect:color:turnedOn:), targetClass, @selector(drawInsertionPointInRect:color:turnedOn:), @selector(origin_drawInsertionPointInRect:color:turnedOn:));
    //
    HookSelector(DVTSourceTextView, @selector(_drawInsertionPointInRect:color:), targetClass, @selector(_drawInsertionPointInRect:color:), @selector(origin__drawInsertionPointInRect:color:));
    
    //    performKeyEquivalent
    HookSelector(DVTSourceTextView, @selector(performKeyEquivalent:), targetClass, @selector(performKeyEquivalent:), @selector(origin_performKeyEquivalent:));
    
    HookSelector(DVTSourceTextView, @selector(control:textView:doCommandBySelector:), targetClass, @selector(control:textView:doCommandBySelector:), @selector(origin_control:textView:doCommandBySelector:));
    
    //    viewDidMoveToSuperview
    HookSelector(DVTSourceTextView, @selector(viewDidMoveToSuperview), targetClass, @selector(viewDidMoveToSuperview), @selector(origin_viewDidMoveToSuperview));
    
    //    - (void)viewWillMoveToSuperview:(NSView *)newSuperview;
    HookSelector(DVTSourceTextView, @selector(viewWillMoveToSuperview:), targetClass, @selector(viewWillMoveToSuperview:), @selector(origin_viewWillMoveToSuperview:));
    
    HookSelector(DVTSourceTextView, @selector(becomeFirstResponder), targetClass, @selector(becomeFirstResponder), @selector(origin_becomeFirstResponder));
    HookSelector(DVTSourceTextView, @selector(resignFirstResponder), targetClass, @selector(resignFirstResponder), @selector(origin_resignFirstResponder));

    
    // dealloc Swizzle
    HookSelector(DVTSourceTextView, @selector(dealloc), targetClass, @selector(dealloc), @selector(origin_dealloc));    
    
    InjectProperty(DVTSourceTextView,@selector(setCommandView:),@selector(commandView),targetClass);
    
    //    Class IDEApplication = NSClassFromString(@"IDEApplication");
    //    Class targetClass2 = [IDESwizzleApplication class];
    //
    //    HookSelector(IDEApplication, @selector(sendEvent:), targetClass2, @selector(sendEvent:), @selector(origin_sendEvent:));
    
    //    Class IDEToolbar = NSClassFromString(@"IDEToolbarDelegate");
    //
    //    Class targetClass3 = [IDESwizzleToolbarDelegate class];
    //    
    //    HookSelector(IDEToolbar, @selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:), targetClass3, @selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:), @selector(origin_toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:));
    
}


@interface VIPlugin : NSObject

@end

@implementation VIPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin {
        
    NSString *logPath = @"/Users/ryan/Desktop/VIXcode.log";
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];    
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);    
    NSLog(@"---");
    Hook();

    [[VISettingsManager sharedSettingsManager] startHack];    
}

@end
