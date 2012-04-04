//
//  VISettingsManager.m
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VISettingsManager.h"

@interface VISettingsManager (Private)

- (void)_addVIMItemOnMainMenu;
- (void)_addVIMItemOnMainMenu;
- (void)_hook;

@end

@implementation VISettingsManager

- (void)_hook {
    NIF_INFO();
    
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
    
    //    performKeyEquivalent
    HookSelector(DVTSourceTextView, @selector(performKeyEquivalent:), targetClass, @selector(performKeyEquivalent:), @selector(origin_performKeyEquivalent:));
    
    HookSelector(DVTSourceTextView, @selector(control:textView:doCommandBySelector:), targetClass, @selector(control:textView:doCommandBySelector:), @selector(origin_control:textView:doCommandBySelector:));
    
    
    // dealloc Swizzle
    HookSelector(DVTSourceTextView, @selector(dealloc), targetClass, @selector(dealloc), @selector(origin_dealloc));    
    
    InjectProperty(DVTSourceTextView,@selector(setViMotionManager:),@selector(viMotionManager),targetClass);
    
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

- (void)startHack {
    [self _setDefaultsValues];
    [self _hook];
    [self _addVIMItemOnMainMenu];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


+ (VISettingsManager *)sharedSettingsManager {
    static VISettingsManager *menuManager = nil;
    if(menuManager == nil) {
        menuManager = [[VISettingsManager alloc] init];
    }
    return menuManager;
}

- (id)init {
    if (self = [super init]) {
        
        //        [self HOOK];
    }
    return self;
}



- (BOOL)isVIMEnabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:XCODE_VIM_ENABLED];
}

- (void)setVIMEnabled:(BOOL)flag {
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:flag] forKey:XCODE_VIM_ENABLED];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}


- (void)_setDefaultsValues {
    
    id xcodeVIMEnabled = [[NSUserDefaults standardUserDefaults] objectForKey:XCODE_VIM_ENABLED];
    NIF_INFO(@"xcodeVIMEnabled %@",xcodeVIMEnabled);
    
    if(xcodeVIMEnabled == nil) {
        NIF_INFO(@"SET HERE");
        [self setVIMEnabled:YES];
    }
}

- (void)_addVIMItemOnMainMenu {
    
   NIF_INFO(@"XCODE_VIM_ENABLED : %@",[[NSUserDefaults standardUserDefaults] objectForKey:XCODE_VIM_ENABLED]);
    
    // MenuItem
    NSMenuItem	*menuItem = [[[NSMenuItem alloc] init] autorelease];
    NSMenuItem	*menuItem2 = [[[NSMenuItem alloc] init] autorelease];
    NSMenu *menu = [[[NSMenu alloc] init] autorelease];
    
    [menuItem setTitle:NSLocalizedString(@"VI+",@"")];
    [menuItem2 setTitle:@"addItem"];
    [menu setTitle: NSLocalizedString(@"VI+",@"")];
    
    NSMenuItem *enabledItem = [menu addItemWithTitle: NSLocalizedString(@"Enabled",@"")
                    action: @selector(vimEnableSwitchAction:) keyEquivalent: @""];
    [enabledItem setTitle:[self isVIMEnabled]?@"Enabled":@"Disabled"];
    [enabledItem setTarget:self];
    
    [menu addItem: [NSMenuItem separatorItem]];

    [menu addItem: menuItem2]; 
    [menuItem setSubmenu: menu];
    
    [menu setAutoenablesItems:NO];
    [menuItem setEnabled:YES];
    
    [menuItem setTarget:self];
    [[NSApp mainMenu] addItem: menuItem];
}

- (void)vimEnableSwitchAction:(NSMenuItem *)sender
{
    [self setVIMEnabled:![self isVIMEnabled]];
    [sender setTitle:[self isVIMEnabled]?@"Enabled":@"Disabled"];
    
}

@end
