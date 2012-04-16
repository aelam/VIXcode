//
//  VIEventProcessor.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VICommandView.h"
#import "vim.h"

extern BOOL isVIMEnabled;

@class VICommandView;
@class VIEventHandler;

@interface VIEventProcessor : NSObject {

    NSUInteger          _state;
    NSMutableString     *_showcmdBuffer;
    NSMutableString     *_appendString;
    
    BOOL                _showcmdBufferCleared;
    
    NSUInteger          _visualActive;
    
}

@property (nonatomic,assign) NSTextView         *currentTextView;
@property (nonatomic,assign) VICommandView      *currentCommandView;
@property (nonatomic,readwrite) NSUInteger      state;
@property (nonatomic,retain) NSMutableString    *showcmdBuffer;
@property (nonatomic,retain) NSMutableString    *appendString;
@property (nonatomic,retain) VIEventHandler     *eventHandler;

+ (VIEventProcessor *)sharedProcessor;

- (BOOL)handleKeyEvent:(NSEvent *)event;


- (int)showmode:(BOOL)flag;


@end
