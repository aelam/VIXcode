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

@interface VIPlugin : NSObject

@end

@implementation VIPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin {
    
    NSString *logPath = @"/Users/ryan/Desktop/VIXcode.log";
    [[NSFileManager defaultManager] removeItemAtPath:logPath error:nil];    
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);    

    [[VISettingsManager sharedSettingsManager] startHack];    
}

@end
