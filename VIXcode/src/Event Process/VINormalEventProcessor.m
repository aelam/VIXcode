//
//  VINormalEventProcessor.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VINormalEventProcessor.h"
#import "VIVisualEventProcessor.h"
#import "VIInsertEventProcessor.h"

@implementation VINormalEventProcessor

+ (id)processorWithMotionManager:(id)motionManager{
    return [[[self alloc] initWithMotionManager:motionManager] autorelease];
}

- (id)initWithMotionManager:(VIMotionManager<VIEventDelegate> *)motionManager {
    if (self = [super initWithMotionManager:motionManager]) {
        self.state = VIMStateNormal;
    }
    return self;
}

- (BOOL)handleKeyEvent:(NSEvent *)theEvent {
    NSString *characters = [theEvent characters];
    unichar keyCode = theEvent.keyCode;

    if (theEvent.keyCode == KEY_ENTER) {
        NIF_INFO(@"NORMAL MODE: ENTER PRESSED !!");
        [self.motionManager.sourceView moveDown:self];
        [self.motionManager.sourceView moveToBeginningOfLine:self];
    }

    else if ([characters isEqualToString:@"/"]) {
        if (self.isInitialized) {
            [self.cmdString setString:@""];
            self.isInitialized = NO;
        }
        [self.cmdString appendString:@"/"];
        [self.motionManager stateWillChange:self];
    }
    
    else if ([characters isEqualToString:@":"]) {
        if (self.isInitialized) {
            [self.cmdString setString:@""];
            self.isInitialized = NO;
        }
        [self.cmdString appendString:@":"];
        [self.motionManager stateWillChange:self];
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
        [self.motionManager setEventProcessor:[VIInsertEventProcessor processorWithMotionManager:self.motionManager]];
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
    
    /* INTO VISUAL MODE */
    else if([characters isEqualToString:@"v"]) {
        NIF_INFO(@"NORMAL--> VISUAL");
        VIVisualEventProcessor *newProcessor = [VIVisualEventProcessor processorWithMotionManager:self.motionManager visualMode:VIVisualModeVisual];
        [self.motionManager setEventProcessor:newProcessor];
    } else if([characters isEqualToString:@"V"]) {
        NIF_INFO(@"NORMAL--> VISUAL LINE");
        VIVisualEventProcessor *newProcessor = [VIVisualEventProcessor processorWithMotionManager:self.motionManager visualMode:VIVisualModeVisualLine];
        [self.motionManager setEventProcessor:newProcessor];
    }


    return YES;
}

@end
