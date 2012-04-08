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


- (void)startHack {
//    Hook();
    [self _setDefaultsValues];
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
    
//   NIF_INFO(@"XCODE_VIM_ENABLED : %@",[[NSUserDefaults standardUserDefaults] objectForKey:XCODE_VIM_ENABLED]);
    
    // MenuItem
    NSMenuItem	*menuItem = [[[NSMenuItem alloc] init] autorelease];

    NSMenu *menu = [[[NSMenu alloc] init] autorelease];
    
    [menuItem setTitle:NSLocalizedString(@"VI+",@"")];

    [menu setTitle: NSLocalizedString(@"VI+",@"")];
    
    NSString *keyEquivalentString = @"v";
    
    NSMenuItem *enabledItem = [menu addItemWithTitle: NSLocalizedString(@"Enabled",@"")
                    action: @selector(vimEnableSwitchAction:) keyEquivalent:keyEquivalentString];
    [enabledItem setKeyEquivalentModifierMask:NSCommandKeyMask|NSAlternateKeyMask];
    [enabledItem setTitle:[self isVIMEnabled]?@"Enabled":@"Disabled"];
    [enabledItem setTarget:self];
    
//    [menu addItem: [NSMenuItem separatorItem]];

//    [menu addItem: menuItem2]; 
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
