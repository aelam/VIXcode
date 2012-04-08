//
//  VIEventProtocol.h
//  VIXcode
//
//  Created by Ryan Wang on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VIMotionManager;
@class VIEventProcessor;

@protocol VIEventDelegate <NSObject>

@optional
- (void)stateDidUpdated:(NSString *)cmdString appendInfo:(NSString *)appendInfo;
- (void)stateWillChange:(VIEventProcessor *)Processor;

@end
