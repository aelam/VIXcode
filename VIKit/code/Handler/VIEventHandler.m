//
//  VIEventHandler.m
//  VIXcode
//
//  Created by Ryan Wang on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventHandler.h"

@interface VIEventHandler ()


@end

@implementation VIEventHandler

//@synthesize state = _state;
//@synthesize isFirstChar = _isFirstChar;


- (id)init {
    if (self = [super init]) {
        finish_op = YES;
    }
    return self;
}

- (BOOL)handleEvent:(NSEvent *)event {
    return YES;
}

- (NSTextView *)textView {
    return [VIEventProcessor sharedProcessor].currentTextView;
}

@end
