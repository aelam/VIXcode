//
//  VIManager.m
//  PluginTest
//
//  Created by Ryan Wang on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <objc/objc-class.h>
#import "DVTSwizzleSourceTextView.h"
#import "IDESwizzleApplication.h"

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

/**
 *  If we want inject some codes to a method, we can consider this 
 *  DVTSourceTextView is a private class, and we can't change its method 
 * 
 */
void HookSelector(Class originClass,SEL originSEL,Class targetClass,SEL targetSEL,SEL oldSELKeeper) {
    Method origMethod = class_getInstanceMethod(originClass, originSEL);
    Method newMethod = class_getInstanceMethod(targetClass, targetSEL);
    
    IMP origImp_stret = class_getMethodImplementation_stret(originClass, originSEL);
    class_replaceMethod(originClass, originSEL, method_getImplementation(newMethod), method_getTypeEncoding(origMethod));
    
    class_addMethod(originClass, oldSELKeeper, origImp_stret, method_getTypeEncoding(origMethod));
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////


@interface VIManager : NSObject

@end

@implementation VIManager

+ (void)pluginDidLoad:(NSBundle *)plugin
{
        
    NSString *logPath = @"/Users/ryan/Desktop/VIXcode.log";
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];    
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);    
    
    // Hook
    Class DVTSourceTextView = NSClassFromString(@"DVTSourceTextView");
    Class targetClass = [DVTSwizzleSourceTextView class];
    HookSelector(DVTSourceTextView, @selector(setSelectedRange:), targetClass, @selector(setSelectedRange:), @selector(origin_setSelectedRange:));

    HookSelector(DVTSourceTextView, @selector(keyUp:), targetClass, @selector(keyUp:), @selector(origin_keyUp:));

    HookSelector(DVTSourceTextView, @selector(keyDown:), targetClass, @selector(keyDown:), @selector(origin_keyDown:));

    HookSelector(DVTSourceTextView, @selector(mouseUp:), targetClass, @selector(mouseUp:), @selector(origin_mouseUp:));

    HookSelector(DVTSourceTextView, @selector(mouseDown:), targetClass, @selector(mouseDown:), @selector(origin_mouseDown:));

    Class IDEApplication = NSClassFromString(@"IDEApplication");
    Class targetClass2 = [IDESwizzleApplication class];

    HookSelector(IDEApplication, @selector(sendEvent:), targetClass2, @selector(sendEvent:), @selector(origin_sendEvent:));
    
}


@end
