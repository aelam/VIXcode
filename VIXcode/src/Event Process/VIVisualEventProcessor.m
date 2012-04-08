//
//  VIVisualEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIVisualEventProcessor.h"
#import "VIInsertEventProcessor.h"
#import "VINormalEventProcessor.h"

@implementation VIVisualEventProcessor

@synthesize visualMode = _visualMode;

+ (id)processorWithMotionManager:(id)motionManager visualMode:(VIVisualMode)aMode{
    return [[[self alloc] initWithMotionManager:motionManager visualMode:aMode] autorelease];
}

- (id)initWithMotionManager:(id)motionManager visualMode:(VIVisualMode)aMode{
    if (self = [super initWithMotionManager:motionManager]) {
        self.state = VIMStateVisual;
        _visualMode = aMode;
        [self.cmdString appendString:VIVisualModeString[_visualMode]];
        
    }
    return self;
}


- (BOOL)handleKeyEvent:(NSEvent *)theEvent {
    NSString *characters = [theEvent characters];
    unichar keyCode = theEvent.keyCode;

    if (0) {
        
    }
    
    /* BACK TO NORMAL MODE */
    else if([theEvent isESC]) {
        NIF_INFO(@"ESC pressed!!");
        [self.motionManager.sourceView moveBackward:self];
        [self.motionManager setEventProcessor:[VINormalEventProcessor processorWithMotionManager:self.motionManager]];
        return YES;

    }
    
    
    //
    // VIM Navigations
    //
    // 备忘 1G 文档首
    
    else if ([characters isEqualToString:@"k"] || keyCode == ARROW_UP) {        //UP
        [self.motionManager.sourceView moveUp:self];
    } else if ([characters isEqualToString:@"j"] || keyCode == ARROW_DOWN) { //DOWN
        [self.motionManager.sourceView moveDown:self];
    } else if ([characters isEqualToString:@"l"] || keyCode == ARROW_RIGHT) { //RIGHT
        [self.motionManager.sourceView moveForward:self];
    } else if ([characters isEqualToString:@"h"] || keyCode == ARROW_LEFT) { //LEFT
        [self.motionManager.sourceView moveBackward:self];
    } else if ([characters isEqualToString:@"e"]) { //RIGHT WORD
        [self.motionManager.sourceView moveWordForward:self];
    } else if ([characters isEqualToString:@"b"]) { //LEFT WORD
        [self.motionManager.sourceView moveWordBackward:self];
    } else if ([characters isEqualToString:@"0"]) { //LINE OF BEGINNING
        [self.motionManager.sourceView moveToBeginningOfLine:self];
    } else if ([characters isEqualToString:@"$"]) { //LINE OF END
        [self.motionManager.sourceView moveToEndOfLine:self];
    } else if ([characters isEqualToString:@"G"]) {
        [self.motionManager.sourceView moveToEndOfDocument:self];
        //    } else if ([characters isEqualToString:@"G"]) {
        //        [self.motionManager.sourceView moveToEndOfDocument:self];
    } 
    else if ([characters isEqualToString:@"J"]) {   // connect two lines
        
    } else if ([characters isEqualToString:@"~"]) {  // upcase <--> lowcase
        [self.motionManager.sourceView changeCaseOfLetter:self];
    }   
    
    else if ([characters isEqualToString:@"x"]) {    // delete current letter
        
    }
    
    
    /* BACK TO INSERT MODE */
    else if ([characters isEqualToString:@"I"]) {
//        [self.motionManager stateWillChange:VIMStateInsert];
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];

        //        self.state = VIMStateInsert;
        [self.motionManager.sourceView moveToBeginningOfLine:self];
    } else if ([characters isEqualToString:@"i"]) {
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
    } else if ([characters isEqualToString:@"i"]) {
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
    } else if ([characters isEqualToString:@"a"]) {
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
    } else if ([characters isEqualToString:@"o"]) {
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
    } else if ([characters isEqualToString:@"O"]) {
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
    }
    
    
    
    
    return YES;
    
}

- (void)dealloc {
    
    [super dealloc];
}

@end
