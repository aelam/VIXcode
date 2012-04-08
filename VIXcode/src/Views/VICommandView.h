//
//  VICommandView.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * cmd field 
 * append field 
 *
 */
@interface VICommandView : NSView {
@private
    NSTextField *_cmdField;
    NSTextField *_appendField;
}


- (id)init;

- (void)updateCommand:(NSString *)cmd;
- (void)updateAppendInfo:(NSString *)info;

@end
