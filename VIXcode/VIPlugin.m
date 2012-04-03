//
//  VIPlugin.m
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
#import "IDESwizzleToolbar.h"

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

void InjectProperty(Class originClass,SEL setter,SEL getter,Class fakeClass) {
//    Method setterMethod = class_getInstanceMethod(fakeClass, setter);
    IMP setterIMP = class_getMethodImplementation(fakeClass, setter);
    class_addMethod(originClass,setter,setterIMP,@encode(void));
    
//    Method getterMethod = class_getInstanceMethod(fakeClass,getter);
    IMP getterIMP = class_getMethodImplementation(fakeClass, getter);
    class_addMethod(originClass,getter,getterIMP,@encode(id));
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////


@interface VIPlugin : NSObject

@end

@implementation VIPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin
{
        
    NSString *logPath = @"/Users/ryan/Desktop/VIXcode.log";
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];    
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);    
    
    // Hook
    Class DVTSourceTextView = NSClassFromString(@"DVTSourceTextView");
    Class targetClass = [DVTSwizzleSourceTextView class];

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
    
    // dealloc Swizzle
    HookSelector(DVTSourceTextView, @selector(dealloc), targetClass, @selector(dealloc), @selector(origin_dealloc));    
    
    InjectProperty(DVTSourceTextView,@selector(setViMotionManager:),@selector(viMotionManager),targetClass);

//    origin_resetCursorRects
//    HookSelector(DVTSourceTextView, @selector(resetCursorRects), targetClass, @selector(resetCursorRects), @selector(origin_resetCursorRects));
    
    Class IDEApplication = NSClassFromString(@"IDEApplication");
    Class targetClass2 = [IDESwizzleApplication class];

    HookSelector(IDEApplication, @selector(sendEvent:), targetClass2, @selector(sendEvent:), @selector(origin_sendEvent:));
    
    Class IDEToolbar = NSClassFromString(@"IDEToolbarDelegate");
    NIF_INFO(@"IDEToolbar ; %@",IDEToolbar);

//    printMethodListOfClass(IDEToolbar);
    
    Class targetClass3 = [IDESwizzleToolbarDelegate class];
    
    HookSelector(IDEToolbar, @selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:), targetClass3, @selector(toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:), @selector(origin_toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:));
    
    
    NSApplication *app = [NSApplication sharedApplication];

    NIF_INFO(@"%@",[app windows]);
    
}


@end
