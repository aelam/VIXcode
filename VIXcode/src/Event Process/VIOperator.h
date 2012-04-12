//
//  VIOperator.h
//  VIXcode
//
//  Created by Ryan Wang on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ascii.h"


/*
 * The names of operators.
 * IMPORTANT: Index must correspond with defines in vim.h!!!
 * The third field indicates whether the operator always works on lines.
 */
static char opchars[][3] =
{
    {NUL, NUL, FALSE},	/* OP_NOP */
    {'d', NUL, FALSE},	/* OP_DELETE */
    {'y', NUL, FALSE},	/* OP_YANK */
    {'c', NUL, FALSE},	/* OP_CHANGE */
    {'<', NUL, TRUE},	/* OP_LSHIFT */
    {'>', NUL, TRUE},	/* OP_RSHIFT */
    {'!', NUL, TRUE},	/* OP_FILTER */
    {'g', '~', FALSE},	/* OP_TILDE */
    {'=', NUL, TRUE},	/* OP_INDENT */
    {'g', 'q', TRUE},	/* OP_FORMAT */
    {':', NUL, TRUE},	/* OP_COLON */
    {'g', 'U', FALSE},	/* OP_UPPER */
    {'g', 'u', FALSE},	/* OP_LOWER */
    {'J', NUL, TRUE},	/* DO_JOIN */
    {'g', 'J', TRUE},	/* DO_JOIN_NS */
    {'g', '?', FALSE},	/* OP_ROT13 */
    {'r', NUL, FALSE},	/* OP_REPLACE */
    {'I', NUL, FALSE},	/* OP_INSERT */
    {'A', NUL, FALSE},	/* OP_APPEND */
    {'z', 'f', TRUE},	/* OP_FOLD */
    {'z', 'o', TRUE},	/* OP_FOLDOPEN */
    {'z', 'O', TRUE},	/* OP_FOLDOPENREC */
    {'z', 'c', TRUE},	/* OP_FOLDCLOSE */
    {'z', 'C', TRUE},	/* OP_FOLDCLOSEREC */
    {'z', 'd', TRUE},	/* OP_FOLDDEL */
    {'z', 'D', TRUE},	/* OP_FOLDDELREC */
    {'g', 'w', TRUE},	/* OP_FORMAT2 */
    {'g', '@', FALSE},	/* OP_FUNCTION */
};


@interface VIOperator : NSObject


- (void)clearOperators;

@end
