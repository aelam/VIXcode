//
//  VIConstants.h
//  VIXcode
//
//  Created by Ryan Wang on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define XCODE_TOOLBAR_IDENTIFIER    @"Xcode.IDEKit.ToolbarDefinition.Workspace"

#define XCODE_VIM_ITEM_IDENTIFIER   @"Xcode.IDEKit.CustomToolbarItem.VIM"

#define SAFELY_RELEASE(__POINTER) do {\
            [__POINTER release];\
            __POINTER = nil;\
        }while(0)



#define XCODE_VIM_ENABLED   @"XCODE_VIM_ENABLED"
