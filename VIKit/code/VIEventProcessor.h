//
//  VIEventProcessor.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VICommandView.h"

extern BOOL isVIMEnabled;

///*
// * Arguments for operators.
// */
//typedef struct OperatorArgs_S
//{
//    int		op_type;	/* current pending operator type */
//    int		regname;	/* register to use for the operator */
//    int		motion_type;	/* type of the current cursor motion */
//    int		motion_force;	/* force motion type: 'v', 'V' or CTRL-V */
//    int		use_reg_one;	/* TRUE if delete uses reg 1 even when not
//                             linewise */
//    int		inclusive;	/* TRUE if char motion is inclusive (only
//                         valid when motion_type is MCHAR */
//    int		end_adjusted;	/* backuped b_op_end one char (only used by
//                             do_format()) */
////    pos_T	start;		/* start of the operator */
////    pos_T	end;		/* end of the operator */
////    pos_T	cursor_start;	/* cursor position before motion for "gw" */
//    
//    long	line_count;	/* number of lines from op_start to op_end
//                         (inclusive) */
//    int		empty;		/* op_start and op_end the same (only used by
//                         do_change()) */
//#ifdef FEAT_VISUAL
//    int		is_VIsual;	/* operator on Visual area */
//    int		block_mode;	/* current operator is Visual block mode */
//#endif
////    colnr_T	start_vcol;	/* start col for block mode operator */
////    colnr_T	end_vcol;	/* end col for block mode operator */
//#ifdef FEAT_AUTOCMD
//    long	prev_opcount;	/* ca.opcount saved for K_CURSORHOLD */
//    long	prev_count0;	/* ca.count0 saved for K_CURSORHOLD */
//#endif
//} OperatorArgs;
//
//
//
//typedef struct CommandArgs_S{
//    OperatorArgs *op_args;
//    int		prechar;	/* prefix character (optional, always 'g') */
//    int		cmdchar;	/* command character */
//    int		nchar;		/* next command character (optional) */
//#ifdef FEAT_MBYTE
//    int		ncharC1;	/* first composing character (optional) */
//    int		ncharC2;	/* second composing character (optional) */
//#endif
//    int		extra_char;	/* yet another character (optional) */
//    long	opcount;	/* count before an operator */
//    long	count0;		/* count before command, default 0 */
//    long	count1;		/* count before command, default 1 */
//    int		arg;		/* extra argument from nv_cmds[] */
//    int		retval;		/* return: CA_* values */
//    unsigned char	*searchbuf;	/* return: pointer to search pattern or NULL */
//    
//}CommandArgs;



/****************	General		****************/

FOUNDATION_EXPORT BOOL VIModeEnabled;


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
@property (nonatomic,retain) VIEventHandler     *eventHandler;

@property (nonatomic,retain) NSColor            *currentLineColor;

+ (VIEventProcessor *)sharedProcessor;

- (BOOL)handleKeyEvent:(NSEvent *)event;


- (int)showmode:(BOOL)flag;

- (void)clearCommandArgs;


@end
