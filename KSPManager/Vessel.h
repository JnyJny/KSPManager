//
//  Vessel.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 9/5/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#import "PersistentObject.h"
#import "Orbit.h"
#import "VesselPart.h"


#define kVesselKeyPid                @"pid"
#define kVesselKeyName               @"name"
#define kVesselKeySituation          @"sit"
#define kVesselKeyLanded             @"landed"
#define kVesselKeyLandedAt           @"landedAt"
#define kVesselKeySplashed           @"splashed"
#define kVesselKeyMissionElapsedTime @"met"
#define kVesselKeyLocation           @"lct"
#define kVesselKeyRoot               @"root"
#define kVesselKeyLatitude           @"lat"
#define kVesselKeyLongitude          @"lon"
#define kVesselKeyAltitude           @"alt"
#define kVesselKeyHGT                @"hgt"
#define kVesselKeyNRM                @"nrm"
#define kVesselKeyROT                @"rot"
#define kVesselKeyCenterOfMass       @"CoM"
#define kVesselKeyStage              @"stg"
#define kVesselKeyPRST               @"prst"
#define kVesselKeyEVA                @"eva"


@interface Vessel : PersistentObject

@property (strong, nonatomic) Orbit *orbit;
@property (strong, nonatomic) NSMutableArray *parts;

- (void)addOrbit:(NSDictionary *)orbitInfo;
- (void)addPart:(NSDictionary *)partInfo;
@end
