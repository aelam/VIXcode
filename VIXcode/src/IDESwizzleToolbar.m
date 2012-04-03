//
//  IDESwizzleToolbar.m
//  VIXcode
//
//  Created by Ryan Wang on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IDESwizzleToolbar.h"


@implementation IDESwizzleToolbar

@end



@implementation IDESwizzleToolbarDelegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    if ([toolbar.identifier isEqualToString:XCODE_VIM_ITEM_IDENTIFIER]) {
        static NSToolbarItem *item = nil;
        if (item == nil) {
            item = [[NSToolbarItem alloc] initWithItemIdentifier:XCODE_VIM_ITEM_IDENTIFIER];
        }
        [item setLabel:XCODE_VIM_ITEM_IDENTIFIER];
        
        return item;        
    }

    return [self origin_toolbar:toolbar itemForItemIdentifier:itemIdentifier willBeInsertedIntoToolbar:flag];
}


@end