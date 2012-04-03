//
//  IDEApplication.m
//  VIXcode
//
//  Created by Ryan Wang on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IDESwizzleApplication.h"
#import "RuntimeReporter.h"

@implementation IDESwizzleApplication

- (void)sendEvent:(NSEvent *)theEvent {
  
    NSEventType type =  theEvent.type;

    switch (type) {
        case NSLeftMouseDown: {
        }
            break;        
        case NSLeftMouseUp:
            break;        
        case NSRightMouseDown:
            break;
        case NSRightMouseUp:    
            break;      
        case NSMouseMoved:     
            break;
        case NSLeftMouseDragged: 
            break;
        case NSRightMouseDragged:   
            break;
        case NSMouseEntered:       
            break;
        case NSMouseExited:             
            break;
        case NSKeyDown:                   
//            NIF_INFO(@"%@",theEvent);
            break;
        case NSKeyUp:                   
            break; 
        case NSFlagsChanged:            
            break;
        case NSAppKitDefined:            
            break;
        case NSSystemDefined:  
//            NIF_INFO(@"%@",theEvent);
            break;
        case NSApplicationDefined:       
            break;
        case NSPeriodic:               
            break;
        case NSCursorUpdate:            
            break;
        case NSScrollWheel:             
            break;
        case NSTabletPoint:             
            break;
        case NSTabletProximity:         
            break;
        case NSOtherMouseDown:           
            break;
        case NSOtherMouseUp:             
            break;
        case NSOtherMouseDragged:
            break;
        default:
            break;
    }
    [self origin_sendEvent:theEvent];
}

- (void)test {
    NIF_INFO();
}

@end
