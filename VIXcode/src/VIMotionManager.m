//
//  VIMotionManager.m
//  VIXcode
//
//  Created by Ryan Wang on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIMotionManager.h"
#import "DVTSwizzleSourceTextView.h"

@implementation VIMotionManager

@synthesize sourceView = _sourceView;
@synthesize state = _state;
@synthesize status = _status;
@synthesize cmd = cmd;

+ (VIMotionManager *)managerWithSourceTextView:(id)sourceView {
    return [[[self alloc] initWithSourceView:sourceView] autorelease];
}

- (id)initWithSourceView:(DVTSwizzleSourceTextView *)sourceView {
    if (self = [super init]) {
        _sourceView = sourceView;
        _state = VIMStateInsert;
        
        [self setupUIStaff];
    }
    return self;
}

- (void)setupUIStaff {

}

- (void)reset {
    
}

- (void)setState:(VIMState)aState {
    
}


- (void)dealloc {
    NIF_INFO();
    [_stateField removeFromSuperview];
    SAFELY_RELEASE(_sourceView);
    
    [super dealloc];
}

@end
