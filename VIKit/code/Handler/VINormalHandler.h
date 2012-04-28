//
//  VINormalHandler.h
//  VIXcode
//
//  Created by Ryan Wang on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VIEventHandler.h"
#import "vim.h"
#import "structs.h"

@interface VINormalHandler : VIEventHandler {
    
//    @public
    cmdarg_T    cmdargs;
    
    BOOL        opFinished;
    
    NSUInteger  opcount;
    
    NSEvent     *_currentEvent;
}

@property (nonatomic,readwrite) cmdarg_T cmdargs;
@property (nonatomic,readwrite) BOOL     opFinished;
@property (nonatomic,readonly)  NSEvent *currentEvent;

+ (VINormalHandler *)handler;

- (NSTextView *)textView;

@end

//void normal_cmd(oparg_T oap, int toplevel);
//void scroll_redraw(int up, long count);
/* normal.c */
void init_normal_cmds __ARGS((void));
void normal_cmd __ARGS((oparg_T *oap, int toplevel,NSEvent *event));
void do_pending_operator __ARGS((cmdarg_T *cap, int old_col, int gui_yank));
int do_mouse __ARGS((oparg_T *oap, int c, int dir, long count, int fixindent));
void check_visual_highlight __ARGS((void));
void end_visual_mode __ARGS((void));
void reset_VIsual_and_resel __ARGS((void));
void reset_VIsual __ARGS((void));
int find_ident_under_cursor __ARGS((char_u **string, int find_type));
int find_ident_at_pos __ARGS((win_T *wp, linenr_T lnum, colnr_T startcol, char_u **string, int find_type));
void clear_showcmd __ARGS((void));
int add_to_showcmd __ARGS((int c));
void add_to_showcmd_c __ARGS((int c));
void push_showcmd __ARGS((void));
void pop_showcmd __ARGS((void));
void do_check_scrollbind __ARGS((int check));
void check_scrollbind __ARGS((linenr_T topline_diff, long leftcol_diff));
int find_decl __ARGS((char_u *ptr, int len, int locally, int thisblock, int searchflags));
void scroll_redraw __ARGS((int up, long count));
void handle_tabmenu __ARGS((void));
void do_nv_ident __ARGS((int c1, int c2));
int get_visual_text __ARGS((cmdarg_T *cap, char_u **pp, int *lenp));
void start_selection __ARGS((void));
void may_start_select __ARGS((int c));
/* vim: set ft=c : */

