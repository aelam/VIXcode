//
//  VISettingsManager.h
//  VIXcode
//
//  Created by Ryan Wang on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DVTSwizzleSourceTextView.h"
#import "IDESwizzleApplication.h"
#import "IDESwizzleToolbar.h"
#import "VISettingsManager.h"
#import "MehodHook.h"

static NSString *VISettingsManagerEnableNotification = @"VISettingsManagerEnableNotification";

@interface VISettingsManager : NSObject

+ (VISettingsManager *)sharedSettingsManager;

- (BOOL)isVIMEnabled;
- (void)setVIMEnabled:(BOOL)flag;

- (void)startHack;

@end
