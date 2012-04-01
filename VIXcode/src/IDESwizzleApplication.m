//
//  IDEApplication.m
//  VIXcode
//
//  Created by Ryan Wang on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IDESwizzleApplication.h"

@implementation IDESwizzleApplication

- (void)sendEvent:(NSEvent *)theEvent {
  
//    NIF_INFO(@"%@",theEvent);
    NSResponder *firstResponder = [[self keyWindow] firstResponder];
//    NIF_INFO(@"------------- firstResponder : %@",firstResponder);
    if ([firstResponder isKindOfClass:NSClassFromString(@"DVTSourceTextView")]) {
     
        NSLog(@"subviews : %@",[firstResponder subviews]);
        NSView *sourceView = (NSView *)firstResponder;
        VICommandField *commandField = [VICommandField sharedInstance];
        if(![sourceView viewWithTag:VICommandFieldTag]) {
            [sourceView addSubview:commandField];
            commandField.frame = NSMakeRect(0, NSMaxY(sourceView.frame) - 35, NSWidth(sourceView.frame), 30);
        }


//        [sourceView vi_sizeToFit];
        
    }
    
    [self origin_sendEvent:theEvent];
}

@end
