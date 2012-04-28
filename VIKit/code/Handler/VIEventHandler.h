//
//  VIEventHandler.h
//  VIXcode
//
//  Created by Ryan Wang on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "vim.h"
#import "VIEventProcessor.h"

@protocol VIEventHandlerDelegate <NSObject>

- (BOOL)handleEvent:(NSEvent *)event;

@end

@interface VIEventHandler : NSObject<VIEventHandlerDelegate>

@property (nonatomic) NSUInteger state;
@property (nonatomic) BOOL isFirstChar;

- (NSTextView *)textView;

@end
