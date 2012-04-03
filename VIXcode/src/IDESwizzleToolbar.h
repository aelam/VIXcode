//
//  IDESwizzleToolbar.h
//  VIXcode
//
//  Created by Ryan Wang on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol IDESwizzleToolbarDelegate <NSObject,NSToolbarDelegate>

@optional
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;

- (NSToolbarItem *)origin_toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag;


@end


@interface IDESwizzleToolbar : NSToolbar<IDESwizzleToolbarDelegate,NSToolbarDelegate>

@end

@interface IDESwizzleToolbarDelegate : NSObject <NSToolbarDelegate,IDESwizzleToolbarDelegate>

@end
