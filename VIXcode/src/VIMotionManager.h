//
//  VIMotionManager.h
//  VIXcode
//
//  Created by Ryan Wang on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DVTSwizzleSourceTextView;

typedef enum {
    VIMStateNormal,
    VIMStateInsert,
    VIMStateVisual,
    VIMStateExit
}VIMState;

@interface VIMotionManager : NSObject {
@private
    NSTextField *_cmdField;
    NSTextField *_stateField;
}

@property (nonatomic,readwrite) VIMState state;
@property (nonatomic,readonly,weak) DVTSwizzleSourceTextView *sourceView;
@property (nonatomic,readonly) NSString *status;
@property (nonatomic,readonly) NSString *cmd;

+ (VIMotionManager *)managerWithSourceTextView:(id)sourceView;

- (id)initWithSourceView:(id)sourceView;

- (void)reset;

@end
