//
//  CocoaBridge.m
//  VIXcode
//
//  Created by Ryan Wang on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CocoaBridge.h"

unichar ASCII_of_NSEvent(NSEvent *event) {
    unichar buf = 0;
    
    if (event.type != NSKeyDown && event.type != NSKeyUp) {
        return buf;
    }
    
    NSString *characters = [event characters];
    if (characters && [characters length]) {
        [[event characters] getCharacters:&buf range:NSMakeRange(0,[characters length])];        
    }
    
    return buf;
    
}
