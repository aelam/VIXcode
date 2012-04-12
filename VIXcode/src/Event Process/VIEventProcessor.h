//
//  VIEventProcessor.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VIEventProtocol.h"
#import "NSEvent+Keymap.h"
#import "MacKeyMap.h"
#import "VICommandView.h"
#import "VIXcode.h"

@class DVTSwizzleSourceTextView;

@class VICommandView;

@interface VIEventProcessor : NSObject {

    VIMState         _state;

@protected
    NSMutableString *_showcmdBuffer;
    NSMutableString *_appendString;
    
    BOOL        _showcmdBufferCleared;
    
    NSUInteger  _visualActive;
    
}

@property (nonatomic,assign) DVTSwizzleSourceTextView *currentSourceView;
@property (nonatomic,readwrite) VIMState        state;
@property (nonatomic,retain) NSMutableString    *showcmdBuffer;
@property (nonatomic,retain) NSMutableString    *appendString;
@property (nonatomic,readonly) NSUInteger       repeat;

+ (VIEventProcessor *)sharedProcessor;

- (BOOL)handleKeyEvent:(NSEvent *)event;

- (void)displayCMDBuffer;


@end
