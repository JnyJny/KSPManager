//
//  VesselPart.m
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "VesselPart.h"

@implementation VesselPart


- (NSArray *)contentKeys
{
    return @[
    kVesselPartKeyName,
    kVesselPartKeyUID,
    kVesselPartKeyParent,
    kVesselPartKeyPosition,
    kVesselPartKeyRotation,
    kVesselPartKeyMirror,
    kVesselPartKeyISTG,
    kVesselPartKeyDSTG,
    kVesselPartKeySQOR,
    kVesselPartKeySIDX,
    kVesselPartKeyAttm,
    kVesselPartKeyMass,
    kVesselPartKeyTemp,
    kVesselPartKeyEXPT,
    kVesselPartKeyState,
    kVesselPartKeyConnected,
    kVesselPartKeyAttached,
    kVesselPartKeyHasShroud,
    kVesselPartKeyNTime,
    kVesselPartKeyASpeed,
    kVesselPartKeyQTY,
    kVesselPartKeySYM,
    kVesselPartKeyCData
    ];
    
}



+ (NSString *)keyword
{
    // This Class is VesselPart, instead of the expected Part
    // which is already a class in the Assets group.  So we
    // intervene here manually to provide the right configuration
    // file keyword.  This filters up/down/up through - keyword.
    return @"PART";
}
@end
