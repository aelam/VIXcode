//
//  NSObject_VIXcode.h
//  VIXcode
//
//  Created by Ryan Wang on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// based on vim.h and modified
#define EXTERN

/*
 * values for State
 *
 * The lower bits up to 0x20 are used to distinguish normal/visual/op_pending
 * and cmdline/insert+replace mode.  This is used for mapping.  If none of
 * these bits are set, no mapping is done.
 * The upper bits are used to distinguish between other states.
 */

#define FEAT_VREPLACE 1

enum {
    VIMStateNormal                  = 0x01,	/* Normal mode, command expected */
    VIMStateVisual                  = 0x02,	/* Visual mode - use get_real_state() */
    VIMStateOP_Pending              = 0x04,	/* Normal mode, operator is pending - use get_real_state() */
    VIMStateVisualCMDLine           = 0x08,	/* Editing command line */
    VIMStateInsert                  = 0x10,	/* Insert mode */
    VIMStateLanguageMap             = 0x20,	/* Language mapping, can be combined with INSERT and CMDLINE */
    
    VIMStateReplaceFlag             = 0x40,	/* Replace mode flag */
    VIMStateReplace                 = (VIMStateReplaceFlag + VIMStateInsert),
#ifdef FEAT_VREPLACE
    VIMStateVReplaceFlag            = 0x80,	/* Virtual-replace mode flag */
    VIMStateVReplace                = (VIMStateReplaceFlag + VIMStateVReplaceFlag + VIMStateInsert),
#endif
    VIMStateLRepace                 = (VIMStateReplaceFlag + VIMStateLanguageMap),
    VIMStateNormalBusy              = (0x100 + VIMStateNormal),
    VIMStateHitReturn               = (0x200 + VIMStateNormal),
    VIMStateAskMore                 = 0x300,	/* Asking if you want --more-- */
    VIMStateSetWindowSize           = 0x400,	/* window size has changed */
    VIMStateAbbrev                  = 0x500,	/* abbreviation instead of mapping */
    VIMStateExternCMD               = 0x600,	/* executing an external command */
    VIMStateShowMatch               = (0x700 + VIMStateInsert), /* show matching paren */
    VIMStateConfirm                 = 0x800,	/* ":confirm" prompt */
    VIMStateSelectMode              =0x1000,	/* Select mode, only for mappings */
    
    VIMStateMapAllModes             = (0x3f | VIMStateSelectMode) /* all mode bits used for
* mapping */
    
};

typedef NSUInteger VIMState;



/*
 * Operator IDs; The order must correspond to opchars[] in ops.c!
 */

typedef enum {
    VIMOperatorNop          = 0,	/* no pending operation */
    VIMOperatorDelete       = 1,	/* "d"  delete operator */
    VIMOperatorYank         = 2,	/* "y"  yank operator */
    VIMOperatorChance       = 3,	/* "c"  change operator */
    VIMOperatorLeftShift    = 4,	/* "<"  left shift operator */
    VIMOperatorRightShift   = 5,	/* ">"  right shift operator */
    VIMOperatorFilter	    = 6,	/* "!"  filter operator */
    VIMOperatorTilde	    = 7,	/* "g~" switch case operator */
    VIMOperatorIndent	    = 8,	/* "="  indent operator */
    VIMOperatorFormat	    = 9,	/* "gq" format operator */
    VIMOperatorColon	    = 10,	/* ":"  colon operator */
    VIMOperatorUpper	    = 11,	/* "gU" make upper case operator */
    VIMOperatorLower	    = 12,	/* "gu" make lower case operator */
    VIMOperatorJoin         = 13,	/* "J"  join operator, only for Visual mode */
    VIMOperatorJoinNS	    = 14,	/* "gJ"  join operator, only for Visual mode */
    VIMOperatorROT13	    = 15,	/* "g?" rot-13 encoding */
    VIMOperatorReplace	    = 16,	/* "r"  replace chars, only for Visual mode */
    VIMOperatorINSERT	    = 17,	/* "I"  Insert column, only for Visual mode */
    VIMOperatorAppend	    = 18,	/* "A"  Append column, only for Visual mode */
    VIMOperatorFold		    = 19,	/* "zf" define a fold */
    VIMOperatorFoldOpen	    = 20,	/* "zo" open folds */
    VIMOperatorFoldOpenRec	= 21,	/* "zO" open folds recursively */
    VIMOperatorFoldClose    = 22,	/* "zc" close folds */
    VIMOperatorFoldCloseRec = 23,	/* "zC" close folds recursively */
    VIMOperatorFoldDel	    = 24,	/* "zd" delete folds */
    VIMOperatorFoldDelLRec   = 25,	/* "zD" delete folds recursively */
    VIMOperatorFormat2	    = 26,	/* "gw" format operator, keeps cursor pos */
    VIMOperatorFunction	    = 27	/* "g@" call 'operatorfunc' */

}VIMOperatorType;






