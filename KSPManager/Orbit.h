//
//  Orbit.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"

@interface Orbit : PersistentObject

#define kOrbitKeySemiMajorAxis            @"SMA"
#define kOrbitKeyEccentricity             @"ECC"
#define kOrbitKeyInclination              @"INC"
#define kOrbitKeyLongitudeOfPeriapsis     @"LPE"
#define kOrbitKeyLongitudeOfAscendingNode @"LAN"
#define kOrbitKeyMeanAnomalyAtEpoch       @"MNA"
#define kOrbitKeyEpoch                    @"EPH"
#define kOrbitKeyReferenceBody            @"REF"
#define kOrbitKeyObjectType               @"OBJ"


enum {
    kReferenceBodyKerbol,
    kReferenceBodyKerbin,
    kReferenceBodyMun,
    kReferenceBodyMinmus
    // more to come
} ;

enum {
    kObjectTypePilotable,
    kObjectTypeDebris
};

@end
